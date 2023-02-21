import 'package:bds_hoan_mobile/data/enums/api_call_status.dart';
import 'package:bds_hoan_mobile/data/enums/button_loading_status.dart';
import 'package:bds_hoan_mobile/data/repository/admin_repository.dart';
import 'package:bloc/bloc.dart';

import 'member_detail_state.dart';

class MemberDetailCubit extends Cubit<MemberDetailState> {
  MemberDetailCubit() : super(const MemberDetailState());

  void getUserInfoByAdmin(int? userId, {bool enableLoading = true}) async {
    if (enableLoading) emit(state.copyWith(apiCallStatus: ApiCallStatus.loading));
    final result = await AdminRepository.getUserInfoByAdmin(userId.toString());
    emit(state.copyWith(user: result));
    if (enableLoading) emit(state.copyWith(apiCallStatus: ApiCallStatus.init));
  }

  Future<bool?> removeUserFromGroup(int? userId) async {
    emit(state.copyWith(buttonLoadingStatus: ButtonLoadingStatus.loading));
    final result = await AdminRepository.removeUserFromGroup([userId.toString()]);
    emit(state.copyWith(buttonLoadingStatus: ButtonLoadingStatus.init));
    return result;
  }

  Future<String?> adminResetUserPassword(int? userId) async {
    final result = await AdminRepository.adminResetUserPassword(userId.toString());
    return result;
  }
}
