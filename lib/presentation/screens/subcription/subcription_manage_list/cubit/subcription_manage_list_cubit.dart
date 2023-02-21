import 'package:bds_hoan_mobile/data/enums/api_call_status.dart';
import 'package:bds_hoan_mobile/data/models/subcription/subcription_info.dart';
import 'package:bds_hoan_mobile/data/models/subcription/subscription_user_data.dart';
import 'package:bds_hoan_mobile/data/repository/subcription_repository.dart';
import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';

part 'subcription_manage_list_state.dart';

class SubcriptionManageListCubit extends Cubit<SubcriptionManageListState> {
  SubcriptionManageListCubit() : super(SubcriptionManageListState());

  Future<void> getListSubcription({bool enableLoading = true}) async {
    if (enableLoading) {
      emit(state.copyWith(apiCallStatus: ApiCallStatus.loading));
    }

    final result = await SubcriptionRepository.getListSubcription();
    if (enableLoading) emit(state.copyWith(apiCallStatus: ApiCallStatus.init));
    if (result != null) {
      emit(state.copyWith(
          fullDataList: result,
          displayDataList: result,
          notAprrovedOnly: false));
    } else {
      emit(const SubcriptionManageListState());
    }
  }

  Future<void> filterNotApprovedDataOnly({bool enableLoading = true}) async {
    if (enableLoading) {
      emit(state.copyWith(apiCallStatus: ApiCallStatus.loading));
    }
    List<SubscriptionUserData> result =
        state.fullDataList != null ? [...state.fullDataList!] : [];
    if (state.notAprrovedOnly == null || state.notAprrovedOnly == false) {
      result = result.where((element) => element.status == 0).toList();
      emit(state.copyWith(
        apiCallStatus: ApiCallStatus.init,
        displayDataList: result,
        notAprrovedOnly: true,
      ));
    } else {
      emit(state.copyWith(
        apiCallStatus: ApiCallStatus.init,
        displayDataList: result,
        notAprrovedOnly: false,
      ));
    }
  }
}
