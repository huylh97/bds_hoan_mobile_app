import 'dart:io';

import 'package:bds_hoan_mobile/bloc_global/app_bloc.dart';
import 'package:bds_hoan_mobile/bloc_global/bloc.dart';
import 'package:bds_hoan_mobile/data/enums/api_call_status.dart';
import 'package:bds_hoan_mobile/data/models/real_estate/real_estate_data_model.dart';
import 'package:bds_hoan_mobile/data/models/subcription/subcription_register_model.dart';
import 'package:bds_hoan_mobile/data/repository/subcription_repository.dart';
import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:image_picker/image_picker.dart';

part 'subcription_payment_state.dart';

class SubcriptionPaymentCubit extends Cubit<SubcriptionPaymentState> {
  SubcriptionPaymentCubit() : super(SubcriptionPaymentState(images: []));

  Future<bool?> registerSubcription({
    int? subscription,
    String? phone,
    int? quantity,
  }) async {
    AppBloc.messageBloc.add(OnLoadingEvent(showLoading: true));

    SubcriptionRegisterModel registerModel = SubcriptionRegisterModel(
        subscription: subscription,
        phone: phone,
        quantity: quantity,
        images: state.images);

    final result =
        await SubcriptionRepository.register(registerModel: registerModel);
    AppBloc.messageBloc.add(OnLoadingEvent(showLoading: false));
    return result;
  }

  Future<void> uploadSubcriptionImg({required List<XFile> pickedFiles}) async {
    AppBloc.messageBloc.add(OnLoadingEvent(showLoading: true));

    try {
      emit(state.copyWith(
        isUploading: true,
      ));
      for (var _pickedFile in pickedFiles) {
        SubcriptionImageRegister? result =
            await SubcriptionRepository.uploadSubcriptionImg(
                file: File(_pickedFile.path));
        if (result != null) {
          state.images.add(result);
        }
      }

      emit(state.copyWith(
        isUploading: false,
        images: state.images,
      ));
    } finally {
      AppBloc.messageBloc.add(OnLoadingEvent(showLoading: false));
      emit(state.copyWith(
        isUploading: false,
      ));
    }
  }

  Future<bool?> deleteUploadedSubcriptionImg(
      {required SubcriptionImageRegister removeFile}) async {
    bool? result;
    AppBloc.messageBloc.add(OnLoadingEvent(showLoading: true));

    try {
      emit(state.copyWith(isUploading: true));
      List<SubcriptionImageRegister> removeList = [];
      removeList.add(
          SubcriptionImageRegister(key: removeFile.key, url: removeFile.url));
      result = await SubcriptionRepository.delUploadedSubcriptionImg(
          uploadedImgDel: SubcriptionImageDel(images: removeList));
      state.images.removeWhere((item) => item.url == removeFile.url);
    } finally {
      AppBloc.messageBloc.add(OnLoadingEvent(showLoading: false));
      emit(state.copyWith(isUploading: false, images: state.images));
    }
    return result;
  }
}
