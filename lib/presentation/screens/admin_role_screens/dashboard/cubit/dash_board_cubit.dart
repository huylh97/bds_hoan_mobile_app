import 'package:bds_hoan_mobile/data/enums/api_call_status.dart';
import 'package:bds_hoan_mobile/data/models/group/group_model.dart';
import 'package:bds_hoan_mobile/data/repository/admin_repository.dart';
import 'package:bloc/bloc.dart';

import 'dash_board_state.dart';

class DashBoardCubit extends Cubit<DashBoardState> {
  DashBoardCubit() : super(const DashBoardState());

  void selectTab(TabType value) {
    emit(state.copyWith(selectedTabType: value));
  }

  void selectGroupInfoType(GroupInfoType value) {
    emit(state.copyWith(groupInfoType: value));
  }

  void createGroupCallback(GroupModel? groupModel) {
    fetchGroupInfo();
  }

  Future<void> fetchGroupInfo({bool enableLoading = true}) async {
    if (enableLoading)
      emit(state.copyWith(apiCallStatus: ApiCallStatus.loading));
    final result = await AdminRepository.getGroupInfo();
    if (!isClosed && enableLoading)
      emit(state.copyWith(apiCallStatus: ApiCallStatus.init));
    if (!isClosed) {
      if (result != null) {
        emit(state.copyWith(
            groupModel: result, groupInfoType: GroupInfoType.profile));
      } else {
        emit(state.copyWith(
            groupModel: result, groupInfoType: GroupInfoType.introduction));
      }
    }
  }
}
