import 'package:bds_hoan_mobile/data/enums/api_call_status.dart';
import 'package:bds_hoan_mobile/data/enums/status.dart';
import 'package:bds_hoan_mobile/data/models/real_estate/real_estate_data_model.dart';
import 'package:bds_hoan_mobile/data/models/real_estate/real_estate_filter_model.dart';
import 'package:bds_hoan_mobile/data/repository/real_estate_repository.dart';
import 'package:bds_hoan_mobile/presentation/screens/real_estate_register/deposit_type_list.dart';
import 'package:bloc/bloc.dart';

import 'real_estate_search_state.dart';

class RealEstateSearchCubit extends Cubit<RealEstateSearchState> {
  RealEstateSearchCubit() : super(const RealEstateSearchState());

  Future<void> getListRealEstate({bool enableLoading = true}) async {
    if (enableLoading) {
      emit(state.copyWith(apiCallStatus: ApiCallStatus.loading));
    }

    var result = await RealEstateRepository.getListRealEstate();
    result = result
        ?.where((element) => element.status != StatusEnum.SaledByAdmin)
        .toList();
    var filterList =
        result?.where((element) => element.disable != true).toList();

    if (enableLoading && !isClosed) {
      emit(state.copyWith(apiCallStatus: ApiCallStatus.init));
    }
    if (!isClosed) {
      if (result != null) {
        emit(state.copyWith(
            fullDataList: result,
            displayDataList: filterList,
            notAprrovedOnly: false,
            hiddenOnly: false));
      } else {
        emit(const RealEstateSearchState());
      }
    }
  }

  Future<void> filter(
      {bool enableLoading = true,
      required RealEstateFilterModel filterData}) async {
    if (enableLoading) {
      emit(state.copyWith(apiCallStatus: ApiCallStatus.loading));
    }

    var result = await RealEstateRepository.getListRealEstateWithFilter(
        filterData: filterData);
    result = result
        ?.where((element) => element.status != StatusEnum.SaledByAdmin)
        .toList();
    if (enableLoading) emit(state.copyWith(apiCallStatus: ApiCallStatus.init));
    if (result != null) {
      emit(state.copyWith(
          fullDataList: result,
          displayDataList: result,
          filterData: filterData));
    } else {
      emit(const RealEstateSearchState());
    }
  }

  Future<void> filterNotApprovedDataOnly({
    bool enableLoading = true,
  }) async {
    if (enableLoading) {
      emit(state.copyWith(apiCallStatus: ApiCallStatus.loading));
    }
    List<RealEstateDataModel> result =
        state.fullDataList != null ? [...state.fullDataList!] : [];
    if (state.notAprrovedOnly == null || state.notAprrovedOnly == false) {
      result = result
          .where((element) =>
              element.disable != true && element.status == StatusEnum.New)
          .toList();
      emit(state.copyWith(
          apiCallStatus: ApiCallStatus.init,
          displayDataList: result,
          notAprrovedOnly: true,
          hiddenOnly: false));
    } else {
      result = result.where((element) => element.disable != true).toList();
      emit(state.copyWith(
          apiCallStatus: ApiCallStatus.init,
          displayDataList: result,
          notAprrovedOnly: false));
    }
  }

  Future<void> filterHiddenDataOnly({
    bool enableLoading = true,
  }) async {
    if (enableLoading) {
      emit(state.copyWith(apiCallStatus: ApiCallStatus.loading));
    }
    List<RealEstateDataModel> result =
        state.fullDataList != null ? [...state.fullDataList!] : [];
    if (state.hiddenOnly == null || state.hiddenOnly == false) {
      result = result.where((element) => element.disable == true).toList();
      emit(state.copyWith(
          apiCallStatus: ApiCallStatus.init,
          displayDataList: result,
          notAprrovedOnly: false,
          hiddenOnly: true));
    } else {
      result = result.where((element) => element.disable != true).toList();
      emit(state.copyWith(
          apiCallStatus: ApiCallStatus.init,
          displayDataList: result,
          hiddenOnly: false));
    }
  }
}
