import 'dart:io';

import 'package:bds_hoan_mobile/bloc_global/app_bloc.dart';
import 'package:bds_hoan_mobile/bloc_global/bloc.dart';
import 'package:bds_hoan_mobile/data/enums/api_call_status.dart';
import 'package:bds_hoan_mobile/data/models/address/address_info.dart';
import 'package:bds_hoan_mobile/data/models/real_estate/real_estate_detail_model.dart';
import 'package:bds_hoan_mobile/data/models/real_estate/real_estate_register_model.dart';
import 'package:bds_hoan_mobile/data/models/real_estate/real_estate_register_param.dart';
import 'package:bds_hoan_mobile/data/repository/address_info_repository.dart';
import 'package:bds_hoan_mobile/data/repository/real_estate_repository.dart';
import 'package:bds_hoan_mobile/presentation/screens/real_estate_register/deposit_type_list.dart';
import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:image_picker/image_picker.dart';

part 'real_estate_register_state.dart';

class RealEstateRegisterCubit extends Cubit<RealEstateRegisterState> {
  RealEstateRegisterCubit() : super(RealEstateRegisterState(images: []));

  Future<void> getRealEstateDetalById(
      {bool enableLoading = true, required int productId}) async {
    if (enableLoading) {
      emit(state.copyWith(apiCallStatus: ApiCallStatus.loading));
    }

    final result =
        await RealEstateRepository.getRealEstateDetailById(productId);
    if (result == null) {
      emit(RealEstateRegisterState(images: []));
      return;
    }

    final provinceList = await AddressInfoRepository.getProvinces();

    final dicstrictList =
        await AddressInfoRepository.getDistricts(result!.province!.id!);

    final wardList = await AddressInfoRepository.getWards(result.district!.id!);

    AddressInfo? selectedProvince = provinceList
        ?.firstWhere((element) => element.id == result.province!.id!);
    AddressInfo? selectedDicstrict = dicstrictList
        ?.firstWhere((element) => element.id == result.district!.id!);
    AddressInfo? selectedWard =
        wardList?.firstWhere((element) => element.id == result.wards!.id!);
    if (enableLoading) emit(state.copyWith(apiCallStatus: ApiCallStatus.init));
    emit(state.copyWith(
        editData: result,
        provinceList: provinceList,
        dicstrictList: dicstrictList,
        wardList: wardList,
        selectedProvince: selectedProvince,
        selectedDicstrict: selectedDicstrict,
        selectedWard: selectedWard,
        kind: result.kind!.id,
        images: result.images
            ?.map((e) => RealEstateImageRegister(key: e.key, url: e.url))
            .toList()));
  }

  Future<void> getProvinces({bool enableLoading = true}) async {
    if (enableLoading) {
      emit(state.copyWith(apiCallStatus: ApiCallStatus.loading));
    }

    final result = await AddressInfoRepository.getProvinces();
    if (enableLoading) emit(state.copyWith(apiCallStatus: ApiCallStatus.init));
    if (result != null) {
      emit(state.copyWith(provinceList: result));
    } else {
      emit(RealEstateRegisterState(images: []));
    }
  }

  Future<void> getDicStricts(
      {bool enableLoading = true, AddressInfo? selectedProvince}) async {
    if (enableLoading) {
      emit(state.copyWith(apiCallStatus: ApiCallStatus.loading));
    }

    final result =
        await AddressInfoRepository.getDistricts(selectedProvince!.id!);
    if (enableLoading) emit(state.copyWith(apiCallStatus: ApiCallStatus.init));
    if (result != null) {
      emit(state.copyWith(
          dicstrictList: result,
          selectedProvince: selectedProvince,
          selectedDicstrict: null,
          selectedWard: null));
    } else {
      emit(state.copyWith(
          selectedProvince: selectedProvince,
          selectedDicstrict: null,
          selectedWard: null));
    }
  }

  Future<void> getWards(
      {bool enableLoading = true, AddressInfo? selectedDicstrict}) async {
    if (enableLoading) {
      emit(state.copyWith(apiCallStatus: ApiCallStatus.loading));
    }

    final result = await AddressInfoRepository.getWards(selectedDicstrict!.id!);
    if (enableLoading) emit(state.copyWith(apiCallStatus: ApiCallStatus.init));
    if (result != null) {
      emit(state.copyWith(
          wardList: result,
          selectedProvince: state.selectedProvince,
          selectedDicstrict: selectedDicstrict,
          selectedWard: null));
    } else {
      emit(state.copyWith(
          selectedProvince: state.selectedProvince,
          selectedDicstrict: selectedDicstrict,
          selectedWard: null));
    }
  }

  Future<void> setWard({AddressInfo? selectedWard}) async {
    emit(state.copyWith(
        selectedProvince: state.selectedProvince,
        selectedDicstrict: state.selectedDicstrict,
        selectedWard: selectedWard));
  }

  Future<void> setKind({int? selectedKind}) async {
    emit(state.copyWith(
        kind: selectedKind,
        selectedProvince: state.selectedProvince,
        selectedDicstrict: state.selectedDicstrict,
        selectedWard: state.selectedWard));
  }

  Future<bool?> registerRealEstate({
    RealEstateRegEditParam? param,
    String? title,
    String? address,
    double? vn2000X,
    double? vn2000Y,
    String? description,
    double? area,
    int? priceSquareMetre,
    int? priceWidthMetre,
    int? priceAll,
    int? commission,
    String? note,
    String? consignorsName,
    String? consignorsPhone,
    String? consignorsExpiry,
  }) async {
    AppBloc.messageBloc.add(OnLoadingEvent(showLoading: true));

    RealEstateRegisterModel registerModel = RealEstateRegisterModel(
        title: title,
        address: address,
        province: state.selectedProvince!.id,
        district: state.selectedDicstrict!.id,
        wards: state.selectedWard!.id,
        vn2000: param!.inputType == RealEstateInputType.vn2000
            ? VN2000(x: vn2000X, y: vn2000Y)
            : null,
        lat: param.inputType == RealEstateInputType.address ? param.lat : null,
        long:
            param.inputType == RealEstateInputType.address ? param.long : null,
        description: description,
        area: area,
        squareMetrePrice: priceSquareMetre,
        widthMetrePrice: priceWidthMetre,
        totalPrice: priceAll,
        // priceType: state.priceType!.id,
        commission: commission,
        note: note,
        kind: state.kind,
        consignors: (state.kind == 2 || state.kind == 4)
            ? 1
            : 0, // kind = 4 la ky gui 2: Lien ket sale
        consignorsName:
            (state.kind == 2 || state.kind == 4) ? consignorsName : null,
        consignorsPhone:
            (state.kind == 2 || state.kind == 4) ? consignorsPhone : null,
        consignorsExpiry: (state.kind == 4)
            ? (consignorsExpiry!.isEmpty ? null : consignorsExpiry)
            : null,
        images: state.images);

    final result =
        await RealEstateRepository.register(registerModel: registerModel);
    AppBloc.messageBloc.add(OnLoadingEvent(showLoading: false));
    return result;
  }

  Future<bool?> updateRealEstate({
    RealEstateRegEditParam? param,
    String? title,
    String? address,
    double? vn2000X,
    double? vn2000Y,
    String? description,
    double? area,
    int? priceSquareMetre,
    int? priceWidthMetre,
    int? priceAll,
    int? commission,
    String? note,
    String? consignorsName,
    String? consignorsPhone,
    String? consignorsExpiry,
  }) async {
    AppBloc.messageBloc.add(OnLoadingEvent(showLoading: true));

    RealEstateRegisterModel updateModel = RealEstateRegisterModel(
        title: title,
        address: address,
        province: state.selectedProvince!.id,
        district: state.selectedDicstrict!.id,
        wards: state.selectedWard!.id,
        vn2000: param!.inputType == RealEstateInputType.vn2000
            ? VN2000(x: vn2000X, y: vn2000Y)
            : null,
        lat: param.inputType == RealEstateInputType.address ? param.lat : null,
        long:
            param.inputType == RealEstateInputType.address ? param.long : null,
        description: description,
        area: area,
        squareMetrePrice: priceSquareMetre,
        widthMetrePrice: priceWidthMetre,
        totalPrice: priceAll,
        // priceType: state.priceType!.id,
        commission: commission,
        note: note,
        kind: state.kind,
        consignors: (state.kind == 2 || state.kind == 4)
            ? 1
            : 0, // kind = 4 la ky gui 2: Lien ket sale
        consignorsName:
            (state.kind == 2 || state.kind == 4) ? consignorsName : null,
        consignorsPhone:
            (state.kind == 2 || state.kind == 4) ? consignorsPhone : null,
        consignorsExpiry: (state.kind == 4)
            ? (consignorsExpiry!.isEmpty ? null : consignorsExpiry)
            : null,
        images: state.images);

    final result = await RealEstateRepository.update(
        updateModel: updateModel, id: param.productId!);
    AppBloc.messageBloc.add(OnLoadingEvent(showLoading: false));
    return result;
  }

  Future<RealEstateImageRegister?> uploadRealEstateImg(
      {required List<XFile> pickedFiles}) async {
    RealEstateImageRegister? result;
    AppBloc.messageBloc.add(OnLoadingEvent(showLoading: true));

    try {
      emit(state.copyWith(
          isUploading: true,
          selectedProvince: state.selectedProvince,
          selectedDicstrict: state.selectedDicstrict,
          selectedWard: state.selectedWard));
      for (var _pickedFile in pickedFiles) {
        result = await RealEstateRepository.uploadRealEstateImg(
            file: File(_pickedFile.path));
        if (result != null) {
          state.images.add(result);
        }
      }

      emit(state.copyWith(
          isUploading: false,
          images: state.images,
          selectedProvince: state.selectedProvince,
          selectedDicstrict: state.selectedDicstrict,
          selectedWard: state.selectedWard));
    } finally {
      AppBloc.messageBloc.add(OnLoadingEvent(showLoading: false));
      emit(state.copyWith(
          isUploading: false,
          selectedProvince: state.selectedProvince,
          selectedDicstrict: state.selectedDicstrict,
          selectedWard: state.selectedWard));
    }
    return result;
  }

  Future<bool?> deleteUploadedRealEstateImg(
      {required RealEstateImageRegister removeFile}) async {
    bool? result;
    AppBloc.messageBloc.add(OnLoadingEvent(showLoading: true));

    try {
      emit(state.copyWith(
          isUploading: true,
          selectedProvince: state.selectedProvince,
          selectedDicstrict: state.selectedDicstrict,
          selectedWard: state.selectedWard));
      List<RealEstateImageRegister> removeList = [];
      removeList.add(
          RealEstateImageRegister(key: removeFile.key, url: removeFile.url));
      result = await RealEstateRepository.delUploadedRealEstateImg(
          uploadedImgDel: RealEstateImageDel(images: removeList));
      state.images.removeWhere((item) => item.url == removeFile.url);
    } finally {
      AppBloc.messageBloc.add(OnLoadingEvent(showLoading: false));
      emit(state.copyWith(
          isUploading: false,
          images: state.images,
          selectedProvince: state.selectedProvince,
          selectedDicstrict: state.selectedDicstrict,
          selectedWard: state.selectedWard));
    }
    return result;
  }
}
