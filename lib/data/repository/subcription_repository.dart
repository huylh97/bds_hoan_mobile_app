import 'dart:io';

import 'package:bds_hoan_mobile/bloc_global/app_bloc.dart';
import 'package:bds_hoan_mobile/bloc_global/bloc.dart';
import 'package:bds_hoan_mobile/data/api_service/api_subcription.dart';
import 'package:bds_hoan_mobile/data/models/api_service/result_api_model.dart';
import 'package:bds_hoan_mobile/data/models/subcription/subcription_info.dart';
import 'package:bds_hoan_mobile/data/models/subcription/subcription_register_model.dart';
import 'package:bds_hoan_mobile/data/models/subcription/subscription_registered_data.dart';
import 'package:bds_hoan_mobile/data/models/subcription/subscription_user_data.dart';

class SubcriptionRepository {
  SubcriptionRepository._internal();

  static Future<List<SubcriptionInfo>?> getSubscriptionInfo() async {
    final result = await ApiSubcription.getSubscriptionInfo();
    if (result.success) {
      final list = <SubcriptionInfo>[];
      result.data['result'].forEach((e) {
        list.add(SubcriptionInfo.fromJson(e));
      });
      return list;
    }
    AppBloc.messageBloc.add(OnHttpMessage(resultApi: result));
    return null;
  }

  static Future<SubcriptionInfo?> getSubscriptionInfoDetail(int id) async {
    final result = await ApiSubcription.getSubscriptionInfoDetail(id);
    if (result.success) {
      return SubcriptionInfo.fromJson(result.data);
    }
    AppBloc.messageBloc.add(OnHttpMessage(resultApi: result));
    return null;
  }

  static Future<bool?> register(
      {required SubcriptionRegisterModel registerModel}) async {
    final result = await ApiSubcription.register(data: registerModel);
    if (result.success) {
      return true;
    }
    AppBloc.messageBloc.add(OnHttpMessage(resultApi: result));
    return null;
  }

  static Future<SubcriptionImageRegister?> uploadSubcriptionImg(
      {required File file}) async {
    final result = await ApiSubcription.uploadSubcriptionImg(file);
    if (result.success &&
        result.data.containsKey('Key') &&
        result.data.containsKey('Location')) {
      return SubcriptionImageRegister(
          key: result.data['Key'], url: result.data['Location']);
    } else {
      AppBloc.messageBloc.add(OnHttpMessage(
          resultApi: ResultApiModel(
        success: false,
        message: 'Upload thất bại',
      )));
    }
    return null;
  }

  static Future<bool?> delUploadedSubcriptionImg(
      {required SubcriptionImageDel uploadedImgDel}) async {
    final result =
        await ApiSubcription.delUploadedSubcriptionImg(uploadedImgDel);
    if (result.success) {
      return true;
    }

    AppBloc.messageBloc.add(OnHttpMessage(resultApi: result));
    return null;
  }

  static Future<List<SubscriptionUserData>?> getListSubcription() async {
    final result = await ApiSubcription.getListSubcription();
    if (result.success) {
      final list = <SubscriptionUserData>[];
      result.data['result'].forEach((e) {
        list.add(SubscriptionUserData.fromJson(e));
      });
      return list;
    }
    AppBloc.messageBloc.add(OnHttpMessage(resultApi: result));
    return null;
  }

  static Future<SubscriptionUserData?> getSubcriptionDetailById(int id) async {
    final result = await ApiSubcription.getSubcriptionDetailById(id);
    if (result.success) {
      return SubscriptionUserData.fromJson(result.data);
    }
    AppBloc.messageBloc.add(OnHttpMessage(resultApi: result));
    return null;
  }

  static Future<SubscriptionRegisteredData?> getRegSubcriptionByUser() async {
    final result = await ApiSubcription.getRegSubcriptionByUser();
    if (result.success) {
      return SubscriptionRegisteredData.fromJson(result.data);
    }
    AppBloc.messageBloc.add(OnHttpMessage(resultApi: result));
    return null;
  }

  static Future<bool?> confirm({required int subcriptionId}) async {
    final result = await ApiSubcription.confirm(subcriptionId: subcriptionId);
    if (result.success) {
      return true;
    }
    AppBloc.messageBloc.add(OnHttpMessage(resultApi: result));
    return null;
  }

  static Future<bool?> lock({required int subcriptionId}) async {
    final result = await ApiSubcription.lock(subcriptionId: subcriptionId);
    if (result.success) {
      return true;
    }
    AppBloc.messageBloc.add(OnHttpMessage(resultApi: result));
    return null;
  }

  static Future<bool?> unlock({required int subcriptionId}) async {
    final result = await ApiSubcription.unLock(subcriptionId: subcriptionId);
    if (result.success) {
      return true;
    }
    AppBloc.messageBloc.add(OnHttpMessage(resultApi: result));
    return null;
  }
}
