part of 'search_filters_cubit.dart';

class SearchFiltersState extends Equatable {
  final ApiCallStatus? apiCallStatus;
  final List<AddressInfo>? provinceList;
  final AddressInfo? selectedProvince;
  final List<AddressInfo>? dicstrictList;
  final AddressInfo? selectedDicstrict;
  final List<AddressInfo>? wardList;
  final AddressInfo? selectedWard;
  // final int? kind;

  const SearchFiltersState({
    this.apiCallStatus,
    this.provinceList,
    this.dicstrictList,
    this.wardList,
    this.selectedProvince,
    this.selectedDicstrict,
    this.selectedWard,
    // this.kind
  });

  @override
  List<Object?> get props => [
        apiCallStatus,
        provinceList,
        dicstrictList,
        wardList,
        selectedProvince,
        selectedDicstrict,
        selectedWard,
        // kind,
      ];

  SearchFiltersState copyWith({
    ApiCallStatus? apiCallStatus,
    List<AddressInfo>? provinceList,
    List<AddressInfo>? dicstrictList,
    List<AddressInfo>? wardList,
    AddressInfo? selectedProvince,
    AddressInfo? selectedDicstrict,
    AddressInfo? selectedWard,
    int? kind,
  }) {
    return SearchFiltersState(
      apiCallStatus: apiCallStatus ?? this.apiCallStatus,
      provinceList: provinceList ?? this.provinceList,
      dicstrictList: dicstrictList ?? this.dicstrictList,
      wardList: wardList ?? this.wardList,
      selectedProvince: selectedProvince,
      selectedDicstrict: selectedDicstrict,
      selectedWard: selectedWard,
      // kind: kind ?? this.kind
    );
  }
}
