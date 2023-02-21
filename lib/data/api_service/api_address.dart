import 'dart:async';

import 'package:bds_hoan_mobile/data/api_service/dio_client.dart';
import 'package:bds_hoan_mobile/data/api_service/endpoints.dart';
import 'package:bds_hoan_mobile/data/models/api_service/result_api_model.dart';

class ApiAddressInfo {
  ApiAddressInfo._();

  static final dioClient = DioClient();

  static Future<ResultApiModel> getProvinces() async {
    final result = await dioClient.get(url: Endpoints.getProvinces);
    return ResultApiModel.fromJson(result);
  }

  static Future<ResultApiModel> getDicstricts(int provinceId) async {
    final result =
        await dioClient.get(url: Endpoints.getDicstricts + '/$provinceId');
    return ResultApiModel.fromJson(result);
  }

  static Future<ResultApiModel> getWards(int districtId) async {
    final result =
        await dioClient.get(url: Endpoints.getWards + '/$districtId');
    return ResultApiModel.fromJson(result);
  }
}
