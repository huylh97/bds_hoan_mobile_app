part of 'subcription_manage_list_cubit.dart';

class SubcriptionManageListState extends Equatable {
  final ApiCallStatus? apiCallStatus;
  final List<SubscriptionUserData>? fullDataList;
  final List<SubscriptionUserData>? displayDataList;
  final bool? notAprrovedOnly;

  const SubcriptionManageListState(
      {this.apiCallStatus,
      this.fullDataList,
      this.displayDataList,
      this.notAprrovedOnly});

  @override
  List<Object?> get props =>
      [apiCallStatus, fullDataList, displayDataList, notAprrovedOnly];

  SubcriptionManageListState copyWith(
      {ApiCallStatus? apiCallStatus,
      List<SubscriptionUserData>? fullDataList,
      List<SubscriptionUserData>? displayDataList,
      bool? notAprrovedOnly}) {
    return SubcriptionManageListState(
        apiCallStatus: apiCallStatus ?? this.apiCallStatus,
        fullDataList: fullDataList ?? this.fullDataList,
        displayDataList: displayDataList ?? this.displayDataList,
        notAprrovedOnly: notAprrovedOnly ?? this.notAprrovedOnly);
  }
}
