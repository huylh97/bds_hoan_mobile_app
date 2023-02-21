import 'dart:io';

import 'package:bds_hoan_mobile/bloc_global/app_bloc.dart';
import 'package:bds_hoan_mobile/bloc_global/bloc.dart';
import 'package:bds_hoan_mobile/data/enums/api_call_status.dart';
import 'package:bds_hoan_mobile/data/enums/status.dart';
import 'package:bds_hoan_mobile/data/models/real_estate/real_estate_data_model.dart';
import 'package:bds_hoan_mobile/data/models/real_estate/real_estate_detail_model.dart';
import 'package:bds_hoan_mobile/data/models/real_estate/real_estate_status_update_model.dart';
import 'package:bds_hoan_mobile/data/repository/real_estate_repository.dart';
import 'package:bds_hoan_mobile/presentation/shared_widgets/utils/_utils.dart';
import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:image_picker/image_picker.dart';
import 'package:path_provider/path_provider.dart';
import 'package:share_plus/share_plus.dart';

part 'real_estate_view_info_state.dart';

class RealEstateViewInfoCubit extends Cubit<RealEstateViewInfoState> {
  RealEstateViewInfoCubit() : super(const RealEstateViewInfoState());

  Future<void> getRealEstateDetalById({bool enableLoading = true, required int productId}) async {
    if (enableLoading) {
      emit(state.copyWith(apiCallStatus: ApiCallStatus.loading));
    }

    final result = await RealEstateRepository.getRealEstateDetailById(productId);
    if (enableLoading) emit(state.copyWith(apiCallStatus: ApiCallStatus.init));
    if (result != null) {
      emit(state.copyWith(productDetail: result));
    } else {
      emit(const RealEstateViewInfoState());
    }
  }

  Future<bool?> updateStatusById({
    required int realEstateId,
    StatusEnum? status,
    int? salePrice,
  }) async {
    AppBloc.messageBloc.add(OnLoadingEvent(showLoading: true));

    RealEstateStatusUpdateModel registerModel = RealEstateStatusUpdateModel(
      status: StatusEnumEncode(status),
      salePrice: salePrice,
    );

    final result = await RealEstateRepository.updateStatusById(realEstateId: realEstateId!, statusUpdateData: registerModel);
    AppBloc.messageBloc.add(OnLoadingEvent(showLoading: false));
    return result;
  }

  Future<void> share(BuildContext context, bool imageShare) async {
    AppBloc.messageBloc.add(OnLoadingEvent(showLoading: true));
    final box = context.findRenderObject() as RenderBox?;

    RealEstateDetailModel product = state.productDetail!;
    // XFile()
    if (imageShare == true) {
      if (product.images != null && product!.images!.isNotEmpty) {
        List<XFile> listXfile = [];
        List<File> fileList = [];

        final tempDir = await getTemporaryDirectory();
        for (var image in product.images!) {
          Uint8List bytes = (await NetworkAssetBundle(Uri.parse(image.url!)).load(image.url!)).buffer.asUint8List();
          String fileName = image.url!.split('/').last;
          final file = await File('${tempDir.path}/$fileName').create();
          await file.writeAsBytes(bytes);

          listXfile.add(XFile('${tempDir.path}/$fileName'));
          fileList.add(file);
        }
        AppBloc.messageBloc.add(OnLoadingEvent(showLoading: false));
        await Share.shareXFiles(listXfile,
            text:
                '📑 ${product.title} \n📍 Địa chỉ: ${product.address ?? ''} ${product.wards!.name ?? ''} ${product.district!.name ?? ''} ${product.province!.name ?? ''}\n📍 Địa chỉ Google maps: http://maps.google.com/maps?q=${product.lat}+${product.long} \n${product.description}\n🏷 Đơn giá: ${UtilCommon.getPriceDisplayStr(product.totalPrice)} \n📞 Sđt liên hệ: ${AppBloc.userCubit.state!.phoneNumber}',
            sharePositionOrigin: box!.localToGlobal(Offset.zero) & box.size);

        tempDir.deleteSync(recursive: true);
      } else {
        AppBloc.messageBloc.add(OnLoadingEvent(showLoading: false));
        await Share.share(
            '📑 ${product.title} \n📍 Địa chỉ: ${product.address ?? ''} ${product.wards!.name ?? ''} ${product.district!.name ?? ''} ${product.province!.name ?? ''}\n📍 Địa chỉ Google maps: http://maps.google.com/maps?q=${product.lat}+${product.long} \n${product.description}\n🏷 Đơn giá: ${UtilCommon.getPriceDisplayStr(product.totalPrice)} \n📞 Sđt liên hệ: ${AppBloc.userCubit.state!.phoneNumber}',
            subject: '',
            sharePositionOrigin: box!.localToGlobal(Offset.zero) & box.size);
      }
    } else {
      AppBloc.messageBloc.add(OnLoadingEvent(showLoading: false));
      await Share.share(
          '📑 ${product.title} \n📍 Địa chỉ: ${product.address ?? ''} ${product.wards!.name ?? ''} ${product.district!.name ?? ''} ${product.province!.name ?? ''}\n📍 Địa chỉ Google maps: http://maps.google.com/maps?q=${product.lat}+${product.long} \n${product.description}\n🏷 Đơn giá: ${UtilCommon.getPriceDisplayStr(product.totalPrice)} \n📞 Sđt liên hệ: ${AppBloc.userCubit.state!.phoneNumber}',
          subject: '',
          sharePositionOrigin: box!.localToGlobal(Offset.zero) & box.size);
    }
  }

  Future<bool?> deleteByAdmin({
    required int realEstateId,
  }) async {
    AppBloc.messageBloc.add(OnLoadingEvent(showLoading: true));
    final result = await RealEstateRepository.deleteByAdminRealEstate(realEstateId: realEstateId);
    AppBloc.messageBloc.add(OnLoadingEvent(showLoading: false));
    return result;
  }

  Future<bool?> disableByAdmin({
    required int realEstateId,
  }) async {
    AppBloc.messageBloc.add(OnLoadingEvent(showLoading: true));
    final result = await RealEstateRepository.disableByAdminRealEstate(realEstateId: realEstateId);
    AppBloc.messageBloc.add(OnLoadingEvent(showLoading: false));
    return result;
  }

  Future<bool?> enableByAdmin({
    required int realEstateId,
  }) async {
    AppBloc.messageBloc.add(OnLoadingEvent(showLoading: true));
    final result = await RealEstateRepository.enableByAdminRealEstate(realEstateId: realEstateId);
    AppBloc.messageBloc.add(OnLoadingEvent(showLoading: false));
    return result;
  }
}
