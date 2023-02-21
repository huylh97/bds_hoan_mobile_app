import 'package:bds_hoan_mobile/bloc_global/app_bloc.dart';
import 'package:bds_hoan_mobile/bloc_global/bloc.dart';
import 'package:bds_hoan_mobile/data/enums/api_call_status.dart';
import 'package:bds_hoan_mobile/data/repository/user_repository.dart';
import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';

part 'invite_group_acception_state.dart';

class InviteGroupAcceptionCubit extends Cubit<InviteGroupAcceptionState> {
  InviteGroupAcceptionCubit() : super(InviteGroupAcceptionState());

  Future<bool?> acceptGroup({
    required int groupId,
  }) async {
    AppBloc.messageBloc.add(OnLoadingEvent(showLoading: true));

    final result = await UserRepository.acceptGroup(groupId: groupId);
    AppBloc.messageBloc.add(OnLoadingEvent(showLoading: false));
    return result;
  }

  Future<bool?> rejectGroup({
    required int groupId,
  }) async {
    AppBloc.messageBloc.add(OnLoadingEvent(showLoading: true));

    final result = await UserRepository.rejectGroup(groupId: groupId);
    AppBloc.messageBloc.add(OnLoadingEvent(showLoading: false));
    return result;
  }
}
