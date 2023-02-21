import 'dart:async';
import 'dart:io';
import 'package:bds_hoan_mobile/data/api_service/dio_client.dart';
import 'package:bds_hoan_mobile/data/api_service/endpoints.dart';
import 'package:bds_hoan_mobile/data/models/api_service/result_api_model.dart';
import 'package:dio/dio.dart';

class ApiUser {
  ApiUser._();

  static final dioClient = DioClient();

  static Future<ResultApiModel> register({
    required String name,
    required String phoneNumber,
    required String password,
    required String confirmPassword,
  }) async {
    final result = await dioClient.post(url: Endpoints.register, data: {
      "name": name,
      "phoneNumber": phoneNumber,
      "password": password,
      "confirmPassword": confirmPassword,
    });
    return ResultApiModel.fromJson(result);
  }

  static Future<ResultApiModel> login(
      String phoneNumber, String password) async {
    final result = await dioClient.post(url: Endpoints.login, data: {
      "phoneNumber": phoneNumber,
      "password": password,
    });
    return ResultApiModel.fromJson(result);
  }

  static Future<ResultApiModel> getUserInfo() async {
    final result = await dioClient.get(url: Endpoints.getUserInfo);
    return ResultApiModel.fromJson(result);
  }

  static Future<ResultApiModel> updateUserInfo(
      Map<String, dynamic> data) async {
    final result = await dioClient.put(url: Endpoints.updateInfo, data: data);
    return ResultApiModel.fromJson(result);
  }

  static Future<ResultApiModel> updatePassword(
      String? password, String? newPassword, String? confirmNewPwd) async {
    final result = await dioClient.put(url: Endpoints.updatePassword, data: {
      "password": password,
      "newPassword": newPassword,
      "confirmNewPwd": confirmNewPwd,
    });
    return ResultApiModel.fromJson(result);
  }

  static Future<ResultApiModel> uploadAvatar(File file) async {
    String fileName = file.path.split('/').last;
    FormData formData = FormData.fromMap({
      "image": await MultipartFile.fromFile(file.path, filename: fileName),
    });
    final result =
        await dioClient.post(url: Endpoints.uploadAvatar, data: formData);
    return ResultApiModel.fromJson(result);
  }

  static Future<ResultApiModel> leaveGroup() async {
    final result = await dioClient.put(url: Endpoints.groupLeave);
    return ResultApiModel.fromJson(result);
  }

  static Future<ResultApiModel> acceptGroup({required int groupId}) async {
    final result =
        await dioClient.put(url: '${Endpoints.groupAccept}/$groupId');
    return ResultApiModel.fromJson(result);
  }

  static Future<ResultApiModel> rejectGroup({required int groupId}) async {
    final result =
        await dioClient.put(url: '${Endpoints.groupReject}/$groupId');
    return ResultApiModel.fromJson(result);
  }

  static Future<ResultApiModel> getInviteList() async {
    final result = await dioClient.get(url: Endpoints.groupListInvite);
    return ResultApiModel.fromJson(result);
  }

  static Future<ResultApiModel> requestDeletion() async {
    final result = await dioClient.delete(url: Endpoints.requestDeletion);
    return ResultApiModel.fromJson(result);
  }
}
