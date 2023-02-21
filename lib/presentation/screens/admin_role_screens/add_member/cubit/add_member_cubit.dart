import 'package:bds_hoan_mobile/bloc_global/app_bloc.dart';
import 'package:bds_hoan_mobile/bloc_global/message/message_event.dart';
import 'package:bds_hoan_mobile/data/enums/api_call_status.dart';
import 'package:bds_hoan_mobile/data/repository/admin_repository.dart';
import 'package:bloc/bloc.dart';

import 'add_member_state.dart';

class AddMemberCubit extends Cubit<AddMemberState> {
  AddMemberCubit() : super(const AddMemberState());

  void searchUserByPhone(String? phone) async {
    emit(state.copyWith(apiCallStatus: ApiCallStatus.loading));
    final result = await AdminRepository.searchUserByPhone(phone);
    emit(state.copyWith(users: result, apiCallStatus: ApiCallStatus.init));
  }

  Future<bool?> addUserToGroup(int? userId) async {
    AppBloc.messageBloc.add(OnLoadingEvent(showLoading: true));
    final result = await AdminRepository.addUserToGroup([userId.toString()]);
    AppBloc.messageBloc.add(OnLoadingEvent(showLoading: false));
    return result;
  }
}
