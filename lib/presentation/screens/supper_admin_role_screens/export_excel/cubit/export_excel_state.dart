part of 'export_excel_cubit.dart';

class ExportExcelState extends Equatable {
  final ApiCallStatus? apiCallStatus;
  final List<AddressInfo>? provinceList;
  final AddressInfo? selectedProvince;
  final List<AddressInfo>? dicstrictList;
  final AddressInfo? selectedDicstrict;
  final List<AddressInfo>? wardList;
  final AddressInfo? selectedWard;
  final String? excelUrl;

  const ExportExcelState(
      {this.apiCallStatus,
      this.provinceList,
      this.dicstrictList,
      this.wardList,
      this.selectedProvince,
      this.selectedDicstrict,
      this.selectedWard,
      this.excelUrl});

  @override
  List<Object?> get props => [
        apiCallStatus,
        provinceList,
        dicstrictList,
        wardList,
        selectedProvince,
        selectedDicstrict,
        selectedWard,
        excelUrl
      ];

  ExportExcelState copyWith(
      {ApiCallStatus? apiCallStatus,
      List<AddressInfo>? provinceList,
      List<AddressInfo>? dicstrictList,
      List<AddressInfo>? wardList,
      AddressInfo? selectedProvince,
      AddressInfo? selectedDicstrict,
      AddressInfo? selectedWard,
      String? excelUrl}) {
    return ExportExcelState(
      apiCallStatus: apiCallStatus ?? this.apiCallStatus,
      provinceList: provinceList ?? this.provinceList,
      dicstrictList: dicstrictList ?? this.dicstrictList,
      wardList: wardList ?? this.wardList,
      selectedProvince: selectedProvince,
      selectedDicstrict: selectedDicstrict,
      selectedWard: selectedWard,
      excelUrl: excelUrl ?? this.excelUrl,
    );
  }
}
