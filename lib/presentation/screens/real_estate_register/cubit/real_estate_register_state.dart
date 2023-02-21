part of 'real_estate_register_cubit.dart';

class RealEstateRegisterState extends Equatable {
  final ApiCallStatus? apiCallStatus;
  final List<AddressInfo>? provinceList;
  final AddressInfo? selectedProvince;
  final List<AddressInfo>? dicstrictList;
  final AddressInfo? selectedDicstrict;
  final List<AddressInfo>? wardList;
  final AddressInfo? selectedWard;

  final int? kind;
  List<RealEstateImageRegister> images = [];
  final bool? isUploading;

  final RealEstateDetailModel? editData;

  RealEstateRegisterState(
      {this.apiCallStatus,
      this.provinceList,
      this.dicstrictList,
      this.wardList,
      this.selectedProvince,
      this.selectedDicstrict,
      this.selectedWard,
      this.kind,
      required this.images,
      this.isUploading,
      this.editData});

  @override
  List<Object?> get props => [
        apiCallStatus,
        provinceList,
        dicstrictList,
        wardList,
        selectedProvince,
        selectedDicstrict,
        selectedWard,
        kind,
        images,
        isUploading,
        editData
      ];

  RealEstateRegisterState copyWith(
      {ApiCallStatus? apiCallStatus,
      List<AddressInfo>? provinceList,
      List<AddressInfo>? dicstrictList,
      List<AddressInfo>? wardList,
      AddressInfo? selectedProvince,
      AddressInfo? selectedDicstrict,
      AddressInfo? selectedWard,
      int? kind,
      List<RealEstateImageRegister>? images,
      bool? isUploading,
      RealEstateDetailModel? editData}) {
    return RealEstateRegisterState(
        apiCallStatus: apiCallStatus ?? this.apiCallStatus,
        provinceList: provinceList ?? this.provinceList,
        dicstrictList: dicstrictList ?? this.dicstrictList,
        wardList: wardList ?? this.wardList,
        selectedProvince: selectedProvince,
        selectedDicstrict: selectedDicstrict,
        selectedWard: selectedWard,
        kind: kind ?? this.kind,
        images: images ?? this.images,
        isUploading: isUploading ?? this.isUploading,
        editData: editData ?? this.editData);
  }
}
