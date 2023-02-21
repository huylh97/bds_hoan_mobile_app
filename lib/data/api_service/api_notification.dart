import 'dart:async';

import 'package:bds_hoan_mobile/data/api_service/dio_client.dart';
import 'package:bds_hoan_mobile/data/api_service/endpoints.dart';
import 'package:bds_hoan_mobile/data/models/api_service/result_api_model.dart';

class ApiNotification {
  ApiNotification._();

  static final dioClient = DioClient();

  static Future<ResultApiModel> getNotifications() async {
    final result = await dioClient.get(url: Endpoints.getNotifications);
    return ResultApiModel.fromJson(result);
  }

  static Future<ResultApiModel> getNotiDetail({required int id}) async {
    final result = await dioClient.get(url: '${Endpoints.getNotiDetail}/$id');
    return ResultApiModel.fromJson(result);
  }

  static Future<ResultApiModel> deleteNotification({required int id}) async {
    final result =
        await dioClient.delete(url: '${Endpoints.deleteNotification}/$id');
    return ResultApiModel.fromJson(result);
  }
}
