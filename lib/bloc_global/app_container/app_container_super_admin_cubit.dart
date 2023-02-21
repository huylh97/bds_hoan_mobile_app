import 'package:bds_hoan_mobile/data/enums/api_call_status.dart';
import 'package:bds_hoan_mobile/data/repository/subcription_repository.dart';
import 'package:bloc/bloc.dart';
import 'package:flutter_app_badger/flutter_app_badger.dart';
import 'app_container_super_admin_state.dart';

class AppContainerSuperAdminCubit extends Cubit<AppContainerSuperAdminState> {
  AppContainerSuperAdminCubit() : super(AppContainerSuperAdminState());

  void onSelectBottomTab(AppBottomTabSuperAdmin bottomTab) {
    emit(state.copyWith(bottomTab: bottomTab));
  }

  void reset() {
    emit(state.copyWith(bottomTab: AppBottomTabSuperAdmin.manageSubcription));
  }
}
