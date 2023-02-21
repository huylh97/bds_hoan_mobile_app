part of 'real_estate_view_info_cubit.dart';

class RealEstateViewInfoState extends Equatable {
  final ApiCallStatus? apiCallStatus;
  final RealEstateDetailModel? productDetail;

  const RealEstateViewInfoState({this.apiCallStatus, this.productDetail});

  @override
  List<Object?> get props => [apiCallStatus, productDetail];

  RealEstateViewInfoState copyWith(
      {ApiCallStatus? apiCallStatus, RealEstateDetailModel? productDetail}) {
    return RealEstateViewInfoState(
        apiCallStatus: apiCallStatus ?? this.apiCallStatus,
        productDetail: productDetail ?? this.productDetail);
  }
}
