import 'package:bds_hoan_mobile/bloc_global/app_bloc.dart';
import 'package:bds_hoan_mobile/bloc_global/bloc.dart';
import 'package:bds_hoan_mobile/data/enums/api_call_status.dart';
import 'package:bds_hoan_mobile/data/models/address/address_info.dart';
import 'package:bds_hoan_mobile/data/models/real_estate/real_estate_export_excel_model.dart';
import 'package:bds_hoan_mobile/data/models/real_estate/real_estate_filter_model.dart';
import 'package:bds_hoan_mobile/data/repository/address_info_repository.dart';
import 'package:bds_hoan_mobile/data/repository/real_estate_repository.dart';
import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';

part 'export_excel_state.dart';

class ExportExcelCubit extends Cubit<ExportExcelState> {
  ExportExcelCubit() : super(ExportExcelState());

  Future<void> getProvinces({bool enableLoading = true}) async {
    if (enableLoading) {
      emit(state.copyWith(apiCallStatus: ApiCallStatus.loading));
    }

    final result = await AddressInfoRepository.getProvinces();
    if (enableLoading) emit(state.copyWith(apiCallStatus: ApiCallStatus.init));
    if (result != null) {
      emit(state.copyWith(provinceList: result));
    } else {
      emit(ExportExcelState());
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

  Future<void> clearSearchCondition({AddressInfo? selectedWard}) async {
    emit(state.copyWith(
        selectedProvince: null,
        selectedDicstrict: null,
        selectedWard: null,
        excelUrl: ''));
  }

  Future<bool?> exportExcelRealEstate({
    required RealEstateFilterModel filterData,
  }) async {
    AppBloc.messageBloc.add(OnLoadingEvent(showLoading: true));

    final result = await RealEstateRepository.exportExcelRealEstate(
        filterData: filterData);

    AppBloc.messageBloc.add(OnLoadingEvent(showLoading: false));
    if (result != null) {
      emit(state.copyWith(
          excelUrl: result.url,
          selectedProvince: state.selectedProvince,
          selectedDicstrict: state.selectedDicstrict,
          selectedWard: state.selectedWard));
      return true;
    }
    return null;
  }
}
