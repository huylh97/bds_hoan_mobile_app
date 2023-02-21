part of 'subcription_payment_cubit.dart';

class SubcriptionPaymentState extends Equatable {
  final ApiCallStatus? apiCallStatus;
  final List<RealEstateDataModel>? dataList;
  final bool? isUploading;
  List<SubcriptionImageRegister> images = [];
  final bool? finishRegister;

  SubcriptionPaymentState(
      {this.apiCallStatus,
      this.dataList,
      this.isUploading,
      required this.images,
      this.finishRegister});

  @override
  List<Object?> get props =>
      [apiCallStatus, dataList, isUploading, images, finishRegister];

  SubcriptionPaymentState copyWith(
      {ApiCallStatus? apiCallStatus,
      List<RealEstateDataModel>? dataList,
      bool? isUploading,
      List<SubcriptionImageRegister>? images,
      bool? finishRegister}) {
    return SubcriptionPaymentState(
        apiCallStatus: apiCallStatus ?? this.apiCallStatus,
        dataList: dataList ?? this.dataList,
        isUploading: isUploading ?? this.isUploading,
        images: images ?? this.images,
        finishRegister: finishRegister ?? this.finishRegister);
  }
}
