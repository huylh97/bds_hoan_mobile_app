import 'package:bds_hoan_mobile/bloc_global/app_bloc.dart';
import 'package:bds_hoan_mobile/bloc_global/message/message_event.dart';
import 'package:bds_hoan_mobile/data/enums/api_call_status.dart';
import 'package:bds_hoan_mobile/data/repository/admin_repository.dart';
import 'package:bds_hoan_mobile/data/repository/user_repository.dart';
import 'package:bds_hoan_mobile/presentation/screens/admin_role_screens/dashboard/cubit/dash_board_state.dart';
import 'package:bloc/bloc.dart';

import 'group_info_state.dart';

class GroupInfoCubit extends Cubit<GroupInfoState> {
  GroupInfoCubit() : super(const GroupInfoState());

  Future<void> fetchGroupInfo({bool enableLoading = true}) async {
    if (enableLoading) emit(state.copyWith(apiCallStatus: ApiCallStatus.loading));
    final result = await AdminRepository.getGroupInfo();
    if (enableLoading) emit(state.copyWith(apiCallStatus: ApiCallStatus.init));
    if (result != null) {
      emit(state.copyWith(groupModel: result, groupInfoType: GroupInfoType.profile));
    } else {
      emit(const GroupInfoState());
    }
  }

  Future<void> leaveGroup() async {
    AppBloc.messageBloc.add(OnLoadingEvent(showLoading: true));
    await UserRepository.leaveGroup();
    AppBloc.messageBloc.add(OnLoadingEvent(showLoading: false));
    await fetchGroupInfo();
  }
}
