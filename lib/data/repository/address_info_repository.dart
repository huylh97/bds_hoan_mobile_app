import 'package:bds_hoan_mobile/bloc_global/app_bloc.dart';
import 'package:bds_hoan_mobile/bloc_global/message/bloc.dart';
import 'package:bds_hoan_mobile/bloc_global/message/message_event.dart';
import 'package:bds_hoan_mobile/data/api_service/api_address.dart';
import 'package:bds_hoan_mobile/data/models/address/address_info.dart';

class AddressInfoRepository {
  AddressInfoRepository._internal();

  static Future<List<AddressInfo>?> getProvinces() async {
    final result = await ApiAddressInfo.getProvinces();
    if (result.success) {
      final list = <AddressInfo>[];
      result.data['result'].forEach((e) {
        list.add(AddressInfo.fromJson(e));
      });
      return list;
    }
    AppBloc.messageBloc.add(OnHttpMessage(resultApi: result));
    return null;
  }

  static Future<List<AddressInfo>?> getDistricts(int provinceId) async {
    final result = await ApiAddressInfo.getDicstricts(provinceId);
    if (result.success) {
      final list = <AddressInfo>[];
      result.data['result'].forEach((e) {
        list.add(AddressInfo.fromJson(e));
      });
      return list;
    }
    AppBloc.messageBloc.add(OnHttpMessage(resultApi: result));
    return null;
  }

  static Future<List<AddressInfo>?> getWards(int districtId) async {
    final result = await ApiAddressInfo.getWards(districtId);
    if (result.success) {
      final list = <AddressInfo>[];
      result.data['result'].forEach((e) {
        list.add(AddressInfo.fromJson(e));
      });
      return list;
    }
    AppBloc.messageBloc.add(OnHttpMessage(resultApi: result));
    return null;
  }
}
