import 'dart:async';
import 'dart:io';
import 'package:bds_hoan_mobile/data/api_service/dio_client.dart';
import 'package:bds_hoan_mobile/data/api_service/endpoints.dart';
import 'package:bds_hoan_mobile/data/models/api_service/result_api_model.dart';
import 'package:bds_hoan_mobile/data/models/real_estate/real_estate_filter_model.dart';
import 'package:bds_hoan_mobile/data/models/real_estate/real_estate_register_model.dart';
import 'package:bds_hoan_mobile/data/models/real_estate/real_estate_status_update_model.dart';
import 'package:bds_hoan_mobile/presentation/shared_widgets/utils/util_common.dart';
import 'package:bds_hoan_mobile/presentation/shared_widgets/utils/util_date_time.dart';
import 'package:dio/dio.dart';

class ApiRealEstate {
  ApiRealEstate._();

  static final dioClient = DioClient();

  static Future<ResultApiModel> register({required RealEstateRegisterModel data}) async {
    final result = await dioClient.post(url: Endpoints.registerRealEstate, data: data.toJson());
    return ResultApiModel.fromJson(result);
  }

  static Future<ResultApiModel> update({required RealEstateRegisterModel data, required int id}) async {
    final result = await dioClient.put(url: '${Endpoints.getRealEstateById}/${id}', data: data.toJson());
    return ResultApiModel.fromJson(result);
  }

  static Future<ResultApiModel> uploadRealEstateImg(File file) async {
    String fileName = file.path.split('/').last;
    FormData formData = FormData.fromMap({
      "images": await MultipartFile.fromFile(file.path, filename: fileName),
    });
    final result = await dioClient.post(url: Endpoints.uploadRealEstateImage, data: formData);
    return ResultApiModel.fromJson(result);
  }

  static Future<ResultApiModel> delUploadedRealEstateImg(RealEstateImageDel uploadedImgDel) async {
    final result = await dioClient.delete(url: Endpoints.delUploadedRealEstateImage, data: uploadedImgDel.toJson());
    return ResultApiModel.fromJson(result);
  }

  static Future<ResultApiModel> getListRealEstate() async {
    final result = await dioClient.get(url: Endpoints.getListRealEstate + '?disable=1');
    return ResultApiModel.fromJson(result);
  }

  static Future<ResultApiModel> getListRealEstateWithFilter({required RealEstateFilterModel filterData}) async {
    String filterStr = '';
    // Kind
    if (filterData.kindList != null && filterData.kindList!.isNotEmpty) {
      if (filterStr.isEmpty) {
        filterStr = filterStr + '?';
      } else {
        filterStr = filterStr + '&';
      }
      filterStr = filterStr + 'kind=' + filterData.kindList!.join(",");
    }
    // priceType
    if (filterData.priceType != null) {
      if (filterStr.isEmpty) {
        filterStr = filterStr + '?';
      } else {
        filterStr = filterStr + '&';
      }
      filterStr = filterStr + 'priceType=' + '${filterData.priceType}';
    }

    // priceFrom
    if (filterData.priceFrom != null) {
      if (filterStr.isEmpty) {
        filterStr = filterStr + '?';
      } else {
        filterStr = filterStr + '&';
      }
      filterStr = filterStr + 'priceFrom=' + '${filterData.priceFrom}';
    }

    // priceTo
    if (filterData.priceTo != null) {
      if (filterStr.isEmpty) {
        filterStr = filterStr + '?';
      } else {
        filterStr = filterStr + '&';
      }
      filterStr = filterStr + 'priceTo=' + '${filterData.priceTo}';
    }

    // Province
    if (filterData.provinceId != null) {
      if (filterStr.isEmpty) {
        filterStr = filterStr + '?';
      } else {
        filterStr = filterStr + '&';
      }
      filterStr = filterStr + 'province=' + '${filterData.provinceId}';
    }

    // Dicstrict
    if (filterData.districtId != null) {
      if (filterStr.isEmpty) {
        filterStr = filterStr + '?';
      } else {
        filterStr = filterStr + '&';
      }
      filterStr = filterStr + 'district=' + '${filterData.districtId}';
    }

    // Ward
    if (filterData.wardId != null) {
      if (filterStr.isEmpty) {
        filterStr = filterStr + '?';
      } else {
        filterStr = filterStr + '&';
      }
      filterStr = filterStr + 'wards=' + '${filterData.wardId}';
    }

    // Status
    if (filterData.statusList != null && filterData.statusList!.isNotEmpty) {
      if (filterStr.isEmpty) {
        filterStr = filterStr + '?';
      } else {
        filterStr = filterStr + '&';
      }
      filterStr = filterStr + 'status=' + filterData.statusList!.join(",");
    }

    // DateFrom
    if (filterData.fromDate != null) {
      if (filterStr.isEmpty) {
        filterStr = filterStr + '?';
      } else {
        filterStr = filterStr + '&';
      }
      filterStr = filterStr + 'fromDate=' + UtilDateTime.formatDateTimeToSubmit(filterData.fromDate);
    }

    // DateTo
    if (filterData.toDate != null) {
      if (filterStr.isEmpty) {
        filterStr = filterStr + '?';
      } else {
        filterStr = filterStr + '&';
      }
      filterStr = filterStr + 'toDate=' + UtilDateTime.formatDateTimeToSubmit(filterData.toDate);
    }
    final result = await dioClient.get(url: Endpoints.getListRealEstate + filterStr);
    return ResultApiModel.fromJson(result);
  }

  static Future<ResultApiModel> getRealEstateDetailById(int id) async {
    final result = await dioClient.get(url: '${Endpoints.getRealEstateById}/${id}');
    return ResultApiModel.fromJson(result);
  }

  static Future<ResultApiModel> updateStatusById({required int realEstateId, required RealEstateStatusUpdateModel statusUpdateData}) async {
    final result = await dioClient.put(url: '${Endpoints.updateStatus}/${realEstateId}', data: statusUpdateData.toJson());
    return ResultApiModel.fromJson(result);
  }

  static Future<ResultApiModel> exportExcelRealEstate({required RealEstateFilterModel filterData}) async {
    String filterStr = '';
    // Province
    if (filterData.provinceId != null) {
      if (filterStr.isEmpty) {
        filterStr = filterStr + '?';
      } else {
        filterStr = filterStr + '&';
      }
      filterStr = filterStr + 'province=' + '${filterData.provinceId}';
    }

    // Dicstrict
    if (filterData.districtId != null) {
      if (filterStr.isEmpty) {
        filterStr = filterStr + '?';
      } else {
        filterStr = filterStr + '&';
      }
      filterStr = filterStr + 'district=' + '${filterData.districtId}';
    }

    // Ward
    if (filterData.wardId != null) {
      if (filterStr.isEmpty) {
        filterStr = filterStr + '?';
      } else {
        filterStr = filterStr + '&';
      }
      filterStr = filterStr + 'ward=' + '${filterData.wardId}';
    }

    // DateFrom
    if (filterData.fromDate != null) {
      if (filterStr.isEmpty) {
        filterStr = filterStr + '?';
      } else {
        filterStr = filterStr + '&';
      }
      filterStr = filterStr + 'fromDate=' + UtilDateTime.formatDateTimeToSubmit(filterData.fromDate);
    }

    // DateTo
    if (filterData.toDate != null) {
      if (filterStr.isEmpty) {
        filterStr = filterStr + '?';
      } else {
        filterStr = filterStr + '&';
      }
      filterStr = filterStr + 'toDate=' + UtilDateTime.formatDateTimeToSubmit(filterData.toDate);
    }

    final result = await dioClient.get(url: Endpoints.exportExcelRealEstate + filterStr);
    return ResultApiModel.fromJson(result);
  }

  static Future<ResultApiModel> deleteByAdminRealEstate({required int realEstateId}) async {
    final result = await dioClient.delete(url: '${Endpoints.deleteByAdminRealEstate}/$realEstateId');
    return ResultApiModel.fromJson(result);
  }

  static Future<ResultApiModel> disableByAdminRealEstate({required int realEstateId}) async {
    final result = await dioClient.put(url: '${Endpoints.disableByAdminRealEstate}/$realEstateId');
    return ResultApiModel.fromJson(result);
  }

  static Future<ResultApiModel> enableByAdminRealEstate({required int realEstateId}) async {
    final result = await dioClient.put(url: '${Endpoints.enableByAdminRealEstate}/$realEstateId');
    return ResultApiModel.fromJson(result);
  }
}
