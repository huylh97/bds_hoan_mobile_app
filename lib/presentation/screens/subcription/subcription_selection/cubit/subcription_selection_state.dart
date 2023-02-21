part of 'subcription_selection_cubit.dart';

class SubcriptionSelectionState extends Equatable {
  final ApiCallStatus? apiCallStatus;
  final List<SubcriptionInfo>? dataList;

  const SubcriptionSelectionState({this.apiCallStatus, this.dataList});

  @override
  List<Object?> get props => [apiCallStatus, dataList];

  SubcriptionSelectionState copyWith(
      {ApiCallStatus? apiCallStatus, List<SubcriptionInfo>? dataList}) {
    return SubcriptionSelectionState(
        apiCallStatus: apiCallStatus ?? this.apiCallStatus,
        dataList: dataList ?? this.dataList);
  }
}
