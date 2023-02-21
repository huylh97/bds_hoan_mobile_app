import 'package:bds_hoan_mobile/data/enums/api_call_status.dart';
import 'package:bds_hoan_mobile/data/repository/subcription_repository.dart';
import 'package:bloc/bloc.dart';

import 'app_container_new_user_state.dart';

class AppContainerNewUserCubit extends Cubit<AppContainerNewUserState> {
  AppContainerNewUserCubit() : super(AppContainerNewUserState());

  Future<void> checkIfHasUnApprovedSubcription(
      {bool enableLoading = true}) async {
    if (enableLoading) {
      emit(state.copyWith(apiCallStatus: ApiCallStatus.loading));
    }

    final regSubscription =
        await SubcriptionRepository.getRegSubcriptionByUser();
    bool hasUnApprovedSubcription = false;
    if (regSubscription != null && regSubscription.status == 0) {
      hasUnApprovedSubcription = true;
    }
    if (enableLoading) emit(state.copyWith(apiCallStatus: ApiCallStatus.init));
    emit(state.copyWith(hasUnApprovedSubcription: hasUnApprovedSubcription));
  }

  Future<void> showNotBelongToAnyGroup({bool enableLoading = true}) async {
    emit(state.copyWith(showNotBelongToAnyGroup: true));
  }

  Future<void> onClear() async {
    emit(AppContainerNewUserState());
  }
}
