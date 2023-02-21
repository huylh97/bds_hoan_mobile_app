import 'dart:async';
import 'package:bds_hoan_mobile/data/api_service/dio_client.dart';
import 'package:bds_hoan_mobile/data/api_service/endpoints.dart';
import 'package:bds_hoan_mobile/data/models/api_service/result_api_model.dart';

class ApiAdmin {
  ApiAdmin._();

  static final dioClient = DioClient();

  static Future<ResultApiModel> getGroupInfo() async {
    final result = await dioClient.get(
      url: Endpoints.getGroupInfo,
    );
    return ResultApiModel.fromJson(result);
  }

  static Future<ResultApiModel> createGroup(Map<String, dynamic> data) async {
    final result = await dioClient.post(
      url: Endpoints.createGroup,
      data: data,
    );
    return ResultApiModel.fromJson(result);
  }

  static Future<ResultApiModel> updateGroupInfo(Map<String, dynamic> data) async {
    final result = await dioClient.put(
      url: Endpoints.updateGroupInfo,
      data: data,
    );
    return ResultApiModel.fromJson(result);
  }

  static Future<ResultApiModel> searchUserByPhone(Map<String, dynamic> data) async {
    final result = await dioClient.post(
      url: Endpoints.searchUserByPhone,
      data: data,
    );
    return ResultApiModel.fromJson(result);
  }

  static Future<ResultApiModel> getInfoByAdmin(String userId) async {
    final result = await dioClient.get(
      url: Endpoints.getInfoByAdmin + '/' + userId,
    );
    return ResultApiModel.fromJson(result);
  }

  static Future<ResultApiModel> addUserToGroup(Map<String, dynamic> data) async {
    final result = await dioClient.post(
      url: Endpoints.addUserToGroup,
      data: data,
    );
    return ResultApiModel.fromJson(result);
  }

  static Future<ResultApiModel> removeUserFromGroup(Map<String, dynamic> data) async {
    final result = await dioClient.put(
      url: Endpoints.removeUserFromGroup,
      data: data,
    );
    return ResultApiModel.fromJson(result);
  }

  static Future<ResultApiModel> adminResetUserPassword(String userId) async {
    final result = await dioClient.post(
      url: Endpoints.resetPassword + '/' + userId,
    );
    return ResultApiModel.fromJson(result);
  }
}
