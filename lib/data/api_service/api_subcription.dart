import 'dart:async';
import 'dart:io';
import 'package:bds_hoan_mobile/data/api_service/dio_client.dart';
import 'package:bds_hoan_mobile/data/api_service/endpoints.dart';
import 'package:bds_hoan_mobile/data/models/api_service/result_api_model.dart';
import 'package:bds_hoan_mobile/data/models/subcription/subcription_register_model.dart';
import 'package:dio/dio.dart';

class ApiSubcription {
  ApiSubcription._();

  static final dioClient = DioClient();

  static Future<ResultApiModel> getSubscriptionInfo() async {
    final result = await dioClient.get(url: Endpoints.getSubcriptionInfo);
    return ResultApiModel.fromJson(result);
  }

  static Future<ResultApiModel> getSubscriptionInfoDetail(
      int subcriptionId) async {
    final result = await dioClient.get(
        url: '${Endpoints.getSubcriptionInfo}/$subcriptionId');
    return ResultApiModel.fromJson(result);
  }

  static Future<ResultApiModel> register(
      {required SubcriptionRegisterModel data}) async {
    final result = await dioClient.post(
        url: Endpoints.registerSubcription, data: data.toJson());
    return ResultApiModel.fromJson(result);
  }

  static Future<ResultApiModel> confirm({required int subcriptionId}) async {
    final result = await dioClient.post(
      url: '${Endpoints.confirmSubcription}/$subcriptionId',
    );
    return ResultApiModel.fromJson(result);
  }

  static Future<ResultApiModel> lock({required int subcriptionId}) async {
    final result = await dioClient.put(
      url: '${Endpoints.lockSubcription}/$subcriptionId',
    );
    return ResultApiModel.fromJson(result);
  }

  static Future<ResultApiModel> unLock({required int subcriptionId}) async {
    final result = await dioClient.put(
      url: '${Endpoints.unlockSubcription}/$subcriptionId',
    );
    return ResultApiModel.fromJson(result);
  }

  static Future<ResultApiModel> uploadSubcriptionImg(File file) async {
    String fileName = file.path.split('/').last;
    FormData formData = FormData.fromMap({
      "image": await MultipartFile.fromFile(file.path, filename: fileName),
    });
    final result = await dioClient.post(
        url: Endpoints.uploadSubcriptionImage, data: formData);
    return ResultApiModel.fromJson(result);
  }

  static Future<ResultApiModel> delUploadedSubcriptionImg(
      SubcriptionImageDel uploadedImgDel) async {
    final result = await dioClient.delete(
        url: Endpoints.delUploadedSubcriptionImage,
        data: uploadedImgDel.toJson());
    return ResultApiModel.fromJson(result);
  }

  static Future<ResultApiModel> getListSubcription() async {
    final result = await dioClient.get(url: Endpoints.getListSubcription);
    return ResultApiModel.fromJson(result);
  }

  static Future<ResultApiModel> getSubcriptionDetailById(int id) async {
    final result =
        await dioClient.get(url: '${Endpoints.getSubcriptionDetails}/${id}');
    return ResultApiModel.fromJson(result);
  }

  static Future<ResultApiModel> getRegSubcriptionByUser() async {
    final result = await dioClient.get(url: Endpoints.getRegSubcriptionByUser);
    return ResultApiModel.fromJson(result);
  }
}
