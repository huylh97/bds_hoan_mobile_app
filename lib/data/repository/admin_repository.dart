import 'package:bds_hoan_mobile/bloc_global/app_bloc.dart';
import 'package:bds_hoan_mobile/bloc_global/message/bloc.dart';
import 'package:bds_hoan_mobile/bloc_global/message/message_event.dart';
import 'package:bds_hoan_mobile/data/api_service/api_admin.dart';
import 'package:bds_hoan_mobile/data/models/group/group_model.dart';
import 'package:bds_hoan_mobile/data/models/user/user_model.dart';

import '../models/group/create_group_params.dart';

class AdminRepository {
  AdminRepository._();

  static Future<GroupModel?> getGroupInfo() async {
    final result = await ApiAdmin.getGroupInfo();
    if (result.success) {
      if (result.data.isEmpty) {
        return null;
      }
      return GroupModel.fromJson(result.data);
    }
    // AppBloc.messageBloc.add(OnHttpMessage(resultApi: result));
    return null;
  }

  static Future<bool?> createGroup(CreateGroupParams params) async {
    final result = await ApiAdmin.createGroup(params.toJson());
    if (result.success) {
      return true;
    }
    AppBloc.messageBloc.add(OnHttpMessage(resultApi: result));
    return null;
  }

  static Future<bool?> updateGroupInfo(CreateGroupParams params) async {
    final result = await ApiAdmin.updateGroupInfo(params.toJson());
    if (result.success) {
      return true;
    }
    AppBloc.messageBloc.add(OnHttpMessage(resultApi: result));
    return null;
  }

  static Future<List<UserModel>?> searchUserByPhone(String? phone) async {
    final result = await ApiAdmin.searchUserByPhone({
      'phone': phone,
    });
    if (result.success) {
      final list = <UserModel>[];
      result.data['result'].forEach((e) {
        list.add(UserModel.fromJson(e));
      });
      return list;
    }
    AppBloc.messageBloc.add(OnHttpMessage(resultApi: result));
    return null;
  }

  static Future<UserModel?> getUserInfoByAdmin(String? userId) async {
    final result = await ApiAdmin.getInfoByAdmin(userId ?? '');
    if (result.success) {
      return UserModel.fromJson(result.data);
    }
    AppBloc.messageBloc.add(OnHttpMessage(resultApi: result));
    return null;
  }

  static Future<bool?> addUserToGroup(List<String>? userIds) async {
    final result = await ApiAdmin.addUserToGroup({'users': userIds});
    if (result.success) {
      return true;
    }
    AppBloc.messageBloc.add(OnHttpMessage(resultApi: result));
    return null;
  }

  static Future<bool?> removeUserFromGroup(List<String>? userIds) async {
    final result = await ApiAdmin.removeUserFromGroup({'users': userIds});
    if (result.success) {
      return true;
    }
    AppBloc.messageBloc.add(OnHttpMessage(resultApi: result));
    return null;
  }

  static Future<String?> adminResetUserPassword(String? userId) async {
    final result = await ApiAdmin.adminResetUserPassword(userId ?? '');
    if (result.success) {
      return result.data['newPassword'];
    }
    AppBloc.messageBloc.add(OnHttpMessage(resultApi: result));
    return null;
  }
}
