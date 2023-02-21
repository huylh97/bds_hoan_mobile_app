import 'package:bds_hoan_mobile/data/enums/api_call_status.dart';
import 'package:bds_hoan_mobile/data/enums/status.dart';
import 'package:bds_hoan_mobile/data/repository/real_estate_repository.dart';
import 'package:bloc/bloc.dart';
import 'package:flutter_app_badger/flutter_app_badger.dart';
import 'app_container_admin_state.dart';

class AppContainerAdminCubit extends Cubit<AppContainerAdminState> {
  AppContainerAdminCubit() : super(AppContainerAdminState());

  void onSelectBottomTab(AppBottomTabAdmin bottomTab) {
    emit(state.copyWith(bottomTab: bottomTab));
  }

  void reset() {
    emit(state.copyWith(bottomTab: AppBottomTabAdmin.manageBDS));
  }

  Future<void> setNumNotifications({required int numNotifications}) async {
    // emit(state.copyWith(apiCallStatus: ApiCallStatus.loading));
    bool supportFlg = await FlutterAppBadger.isAppBadgeSupported();
    if (supportFlg) {
      if (numNotifications == 0) {
        FlutterAppBadger.removeBadge();
      } else {
        FlutterAppBadger.updateBadgeCount(numNotifications);
      }
    }
    emit(state.copyWith(
        apiCallStatus: ApiCallStatus.init, numNotifications: numNotifications));
  }
}
