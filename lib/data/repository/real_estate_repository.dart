import 'dart:io';

import 'package:bds_hoan_mobile/bloc_global/app_bloc.dart';
import 'package:bds_hoan_mobile/bloc_global/bloc.dart';
import 'package:bds_hoan_mobile/data/api_service/api_real_estate.dart';
import 'package:bds_hoan_mobile/data/models/api_service/result_api_model.dart';
import 'package:bds_hoan_mobile/data/models/real_estate/real_estate_data_model.dart';
import 'package:bds_hoan_mobile/data/models/real_estate/real_estate_detail_model.dart';
import 'package:bds_hoan_mobile/data/models/real_estate/real_estate_export_excel_model.dart';
import 'package:bds_hoan_mobile/data/models/real_estate/real_estate_filter_model.dart';
import 'package:bds_hoan_mobile/data/models/real_estate/real_estate_register_model.dart';
import 'package:bds_hoan_mobile/data/models/real_estate/real_estate_status_update_model.dart';

class RealEstateRepository {
  RealEstateRepository._internal();

  static Future<bool?> register(
      {required RealEstateRegisterModel registerModel}) async {
    final result = await ApiRealEstate.register(data: registerModel);
    if (result.success) {
      return true;
    }
    AppBloc.messageBloc.add(OnHttpMessage(resultApi: result));
    return null;
  }

  static Future<bool?> update(
      {required RealEstateRegisterModel updateModel, required int id}) async {
    final result = await ApiRealEstate.update(data: updateModel, id: id);
    if (result.success) {
      return true;
    }
    AppBloc.messageBloc.add(OnHttpMessage(resultApi: result));
    return null;
  }

  static Future<RealEstateImageRegister?> uploadRealEstateImg(
      {required File file}) async {
    final result = await ApiRealEstate.uploadRealEstateImg(file);
    if (result.success &&
        result.data.containsKey('result') &&
        result.data['result'].length > 0 &&
        result.data['result'][0].containsKey('Key')) {
      return RealEstateImageRegister(
          key: result.data['result'][0]['Key'],
          url: result.data['result'][0]['Location']);
    } else {
      AppBloc.messageBloc.add(OnHttpMessage(
          resultApi: ResultApiModel(
        success: false,
        message: 'Upload thất bại',
      )));
    }
    return null;
  }

  static Future<bool?> delUploadedRealEstateImg(
      {required RealEstateImageDel uploadedImgDel}) async {
    final result = await ApiRealEstate.delUploadedRealEstateImg(uploadedImgDel);
    if (result.success) {
      return true;
    }

    AppBloc.messageBloc.add(OnHttpMessage(resultApi: result));
    return null;
  }

  static Future<List<RealEstateDataModel>?> getListRealEstate() async {
    final result = await ApiRealEstate.getListRealEstate();
    if (result.success) {
      final list = <RealEstateDataModel>[];
      result.data['result'].forEach((e) {
        list.add(RealEstateDataModel.fromJson(e));
      });
      return list;
    }
    AppBloc.messageBloc.add(OnHttpMessage(resultApi: result));
    return null;
  }

  static Future<List<RealEstateDataModel>?> getListRealEstateWithFilter(
      {required RealEstateFilterModel filterData}) async {
    final result =
        await ApiRealEstate.getListRealEstateWithFilter(filterData: filterData);
    if (result.success) {
      final list = <RealEstateDataModel>[];
      result.data['result'].forEach((e) {
        list.add(RealEstateDataModel.fromJson(e));
      });
      return list;
    }
    AppBloc.messageBloc.add(OnHttpMessage(resultApi: result));
    return null;
  }

  static Future<RealEstateDetailModel?> getRealEstateDetailById(int id) async {
    final result = await ApiRealEstate.getRealEstateDetailById(id);
    if (result.success) {
      return RealEstateDetailModel.fromJson(result.data);
    }
    AppBloc.messageBloc.add(OnHttpMessage(resultApi: result));
    return null;
  }

  static Future<bool?> updateStatusById(
      {required int realEstateId,
      required RealEstateStatusUpdateModel statusUpdateData}) async {
    final result = await ApiRealEstate.updateStatusById(
        realEstateId: realEstateId, statusUpdateData: statusUpdateData);
    if (result.success) {
      return true;
    }
    AppBloc.messageBloc.add(OnHttpMessage(resultApi: result));
    return null;
  }

  static Future<RealEstateExportExcelModel?> exportExcelRealEstate(
      {required RealEstateFilterModel filterData}) async {
    final result =
        await ApiRealEstate.exportExcelRealEstate(filterData: filterData);
    if (result.success) {
      return RealEstateExportExcelModel.fromJson(result.data);
    }
    AppBloc.messageBloc.add(OnHttpMessage(resultApi: result));
    return null;
  }

  static Future<bool?> deleteByAdminRealEstate(
      {required int realEstateId}) async {
    final result =
        await ApiRealEstate.deleteByAdminRealEstate(realEstateId: realEstateId);
    if (result.success) {
      return true;
    }
    AppBloc.messageBloc.add(OnHttpMessage(resultApi: result));
    return null;
  }

  static Future<bool?> disableByAdminRealEstate(
      {required int realEstateId}) async {
    final result = await ApiRealEstate.disableByAdminRealEstate(
        realEstateId: realEstateId);
    if (result.success) {
      return true;
    }
    AppBloc.messageBloc.add(OnHttpMessage(resultApi: result));
    return null;
  }

  static Future<bool?> enableByAdminRealEstate(
      {required int realEstateId}) async {
    final result =
        await ApiRealEstate.enableByAdminRealEstate(realEstateId: realEstateId);
    if (result.success) {
      return true;
    }
    AppBloc.messageBloc.add(OnHttpMessage(resultApi: result));
    return null;
  }
}
