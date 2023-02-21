import 'dart:io';

import 'package:bds_hoan_mobile/bloc_global/app_bloc.dart';
import 'package:bds_hoan_mobile/bloc_global/message/bloc.dart';
import 'package:bds_hoan_mobile/bloc_global/message/message_event.dart';
import 'package:bds_hoan_mobile/configs/_config.dart';
import 'package:bds_hoan_mobile/data/api_service/api_user.dart';
import 'package:bds_hoan_mobile/data/enums/gender.dart';
import 'package:bds_hoan_mobile/data/models/invite_group/invite_group.dart';
import 'package:bds_hoan_mobile/data/models/user/user_model.dart';
import 'package:bds_hoan_mobile/presentation/shared_widgets/utils/_utils.dart';

class UserRepository {
  UserRepository._internal();

  static Future<void> saveAccessToken(String token) async {
    await UtilPreferences.setString(AppConstant.accessToken, token);
  }

  static Future<void> clearAccessToken() async {
    await UtilPreferences.remove(AppConstant.accessToken);
  }

  static Future<bool> checkLocalAccessToken() async {
    UtilLogger.logInfo('Access token: ' + UtilPreferences.getString(AppConstant.accessToken).toString());
    if (UtilPreferences.getString(AppConstant.accessToken) != null) {
      return true;
    }
    return false;
  }

  static Future<bool?> register({
    required String phoneNumber,
    required String name,
    required String password,
    required String confirmPassword,
  }) async {
    final result = await ApiUser.register(name: name, phoneNumber: phoneNumber, password: password, confirmPassword: confirmPassword);
    if (result.success) {
      return true;
    }
    AppBloc.messageBloc.add(OnHttpMessage(resultApi: result));
    return null;
  }

  static Future<UserModel?> login({required String phoneNumber, required String password}) async {
    final result = await ApiUser.login(phoneNumber, password);
    if (result.success) {
      await saveAccessToken(result.data['token']);
      return UserModel.fromJson(result.data['user']);
    }
    AppBloc.messageBloc.add(OnHttpMessage(resultApi: result));
    return null;
  }

  static Future<UserModel?> getUserInfo() async {
    final result = await ApiUser.getUserInfo();
    if (result.success) {
      return UserModel.fromJson(result.data);
    }
    AppBloc.messageBloc.add(OnHttpMessage(resultApi: result));
    return null;
  }

  static Future<void> updateUserInfo({
    required int? userId,
    required String? name,
    required String? birthDay,
    required GenderEnum? gender,
    String? photo,
  }) async {
    final result = await ApiUser.updateUserInfo({
      "Id": userId,
      "name": name,
      "birthday": birthDay,
      "gender": genderEnumEncode(gender),
      "photo": photo,
    });
    AppBloc.messageBloc.add(OnHttpMessage(resultApi: result));
  }

  static Future<void> updatePassword({
    required String? password,
    required String? newPassword,
    required String? confirmNewPassword,
  }) async {
    final result = await ApiUser.updatePassword(password, newPassword, confirmNewPassword);
    AppBloc.messageBloc.add(OnHttpMessage(resultApi: result));
  }

  static Future<String?> uploadAvatar({required File file}) async {
    final result = await ApiUser.uploadAvatar(file);
    if (result.success) {
      return result.data['Location'];
    }
    AppBloc.messageBloc.add(OnHttpMessage(resultApi: result));
    return null;
  }

  static Future<void> leaveGroup() async {
    final result = await ApiUser.leaveGroup();
    if (result.success) {
      return;
    }
    AppBloc.messageBloc.add(OnHttpMessage(resultApi: result));
  }

  static Future<bool?> acceptGroup({required int groupId}) async {
    final result = await ApiUser.acceptGroup(groupId: groupId);
    if (result.success) {
      return true;
    }
    AppBloc.messageBloc.add(OnHttpMessage(resultApi: result));
    return null;
  }

  static Future<bool?> rejectGroup({required int groupId}) async {
    final result = await ApiUser.rejectGroup(groupId: groupId);
    if (result.success) {
      return true;
    }
    AppBloc.messageBloc.add(OnHttpMessage(resultApi: result));
    return null;
  }

  static Future<List<InviteGroup>?> getListInvite() async {
    final result = await ApiUser.getInviteList();
    if (result.success) {
      final list = <InviteGroup>[];
      if (result.data.isEmpty) {
        return list;
      }
      result.data['result'].forEach((e) {
        list.add(InviteGroup.fromJson(e));
      });
      return list;
    }
    AppBloc.messageBloc.add(OnHttpMessage(resultApi: result));
    return null;
  }

  static Future<bool?> requestDeletion() async {
    final result = await ApiUser.requestDeletion();
    if (result.success) {
      return true;
    }
    AppBloc.messageBloc.add(OnHttpMessage(resultApi: result));
    return null;
  }
}
