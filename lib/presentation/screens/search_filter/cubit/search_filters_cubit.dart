import 'package:bds_hoan_mobile/data/enums/api_call_status.dart';
import 'package:bds_hoan_mobile/data/models/address/address_info.dart';
import 'package:bds_hoan_mobile/data/repository/address_info_repository.dart';
import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';

part 'search_filters_state.dart';

class SearchFiltersCubit extends Cubit<SearchFiltersState> {
  SearchFiltersCubit() : super(SearchFiltersState());

  Future<void> getLocationInfo(
      {bool enableLoading = true,
      int? provinceId,
      int? dicstrictId,
      int? wardId}) async {
    if (enableLoading) {
      emit(state.copyWith(apiCallStatus: ApiCallStatus.loading));
    }
    AddressInfo? selectedProvince;
    AddressInfo? selectedDicstrict;
    AddressInfo? selectedWard;

    List<AddressInfo>? provinceList =
        await AddressInfoRepository.getProvinces();
    List<AddressInfo>? dicstrictList;
    List<AddressInfo>? wardList;
    if (provinceId != null) {
      selectedProvince =
          provinceList?.firstWhere((element) => element.id == provinceId);

      dicstrictList = await AddressInfoRepository.getDistricts(provinceId);
      if (dicstrictId != null) {
        selectedDicstrict =
            dicstrictList?.firstWhere((element) => element.id == dicstrictId);

        wardList = await AddressInfoRepository.getWards(dicstrictId);

        if (wardId != null) {
          selectedWard =
              wardList?.firstWhere((element) => element.id == wardId);
        }
      }
    }

    if (enableLoading) emit(state.copyWith(apiCallStatus: ApiCallStatus.init));
    emit(state.copyWith(
      provinceList: provinceList,
      dicstrictList: dicstrictList,
      wardList: wardList,
      selectedProvince: selectedProvince,
      selectedDicstrict: selectedDicstrict,
      selectedWard: selectedWard,
    ));
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
      emit(SearchFiltersState());
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
}
