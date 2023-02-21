import 'package:bds_hoan_mobile/data/enums/api_call_status.dart';
import 'package:bds_hoan_mobile/data/models/real_estate/real_estate_data_model.dart';
import 'package:bds_hoan_mobile/data/models/real_estate/real_estate_filter_model.dart';
import 'package:equatable/equatable.dart';

class RealEstateSearchState extends Equatable {
  final ApiCallStatus? apiCallStatus;
  final List<RealEstateDataModel>? fullDataList;
  final RealEstateFilterModel? filterData;
  final List<RealEstateDataModel>? displayDataList;
  final bool? notAprrovedOnly;
  final bool? hiddenOnly;

  const RealEstateSearchState(
      {this.apiCallStatus,
      this.fullDataList,
      this.filterData,
      this.displayDataList,
      this.notAprrovedOnly,
      this.hiddenOnly});

  @override
  List<Object?> get props => [
        apiCallStatus,
        fullDataList,
        filterData,
        displayDataList,
        notAprrovedOnly,
        hiddenOnly
      ];

  RealEstateSearchState copyWith(
      {ApiCallStatus? apiCallStatus,
      List<RealEstateDataModel>? fullDataList,
      RealEstateFilterModel? filterData,
      List<RealEstateDataModel>? displayDataList,
      bool? notAprrovedOnly,
      bool? hiddenOnly}) {
    return RealEstateSearchState(
        apiCallStatus: apiCallStatus ?? this.apiCallStatus,
        fullDataList: fullDataList ?? this.fullDataList,
        filterData: filterData ?? this.filterData,
        displayDataList: displayDataList ?? this.displayDataList,
        notAprrovedOnly: notAprrovedOnly ?? this.notAprrovedOnly,
        hiddenOnly: hiddenOnly ?? this.hiddenOnly);
  }
}
