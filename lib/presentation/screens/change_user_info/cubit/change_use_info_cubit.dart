import 'dart:io';

import 'package:bds_hoan_mobile/bloc_global/app_bloc.dart';
import 'package:bds_hoan_mobile/data/enums/api_call_status.dart';
import 'package:bds_hoan_mobile/data/enums/gender.dart';
import 'package:bds_hoan_mobile/data/repository/admin_repository.dart';
import 'package:bds_hoan_mobile/data/repository/user_repository.dart';
import 'package:bloc/bloc.dart';

import 'change_user_info_state.dart';

class ChangeUserInfoCubit extends Cubit<ChangeUserInfoState> {
  ChangeUserInfoCubit() : super(const ChangeUserInfoState());

  Future<void> getUserInfo() async {
    emit(state.copyWith(apiCallStatus: ApiCallStatus.loading));
    final result = await UserRepository.getUserInfo();
    emit(state.copyWith(apiCallStatus: ApiCallStatus.init));
    if (result != null) {
      emit(state.copyWith(userModel: result));
    }
  }

  Future<void> getUserInfoByAdmin(int? userId) async {
    emit(state.copyWith(apiCallStatus: ApiCallStatus.loading));
    final result = await AdminRepository.getUserInfoByAdmin(userId.toString());
    emit(state.copyWith(userModel: result, apiCallStatus: ApiCallStatus.init));
  }

  void onUpdate({
    required int? userId,
    required String? name,
    required String? birthDay,
    required GenderEnum? gender,
    required File? photo,
  }) async {
    emit(state.copyWith(apiCallStatus: ApiCallStatus.loading));

    if (photo != null) {
      String? photoUrl = await UserRepository.uploadAvatar(file: photo);
      await UserRepository.updateUserInfo(
        userId: userId,
        name: name,
        birthDay: birthDay,
        gender: gender,
        photo: photoUrl,
      );
    } else {
      await UserRepository.updateUserInfo(
        userId: userId,
        name: name,
        birthDay: birthDay,
        gender: gender,
      );
    }
    emit(state.copyWith(apiCallStatus: ApiCallStatus.init));
    if (userId == null) {
      final user = await UserRepository.getUserInfo();
      await AppBloc.userCubit.onSaveUser(user);
    }
  }

  Future<bool?> onRequestDeletion() async {
    emit(state.copyWith(apiCallStatus: ApiCallStatus.loading));
    bool? result = await UserRepository.requestDeletion();
    emit(state.copyWith(apiCallStatus: ApiCallStatus.init));

    return result;
  }
}
