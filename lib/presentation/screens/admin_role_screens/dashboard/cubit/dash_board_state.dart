import 'package:bds_hoan_mobile/data/enums/api_call_status.dart';
import 'package:bds_hoan_mobile/data/models/group/group_model.dart';
import 'package:equatable/equatable.dart';

enum TabType { groupInfo, manageMember }

enum GroupInfoType { introduction, form, profile }

class DashBoardState extends Equatable {
  final ApiCallStatus apiCallStatus;
  final TabType selectedTabType;
  final GroupInfoType groupInfoType;
  final GroupModel? groupModel;

  const DashBoardState({
    this.apiCallStatus = ApiCallStatus.loading,
    this.selectedTabType = TabType.groupInfo,
    this.groupInfoType = GroupInfoType.introduction,
    this.groupModel,
  });

  @override
  List<Object?> get props => [
        apiCallStatus,
        selectedTabType,
        groupInfoType,
        groupModel,
      ];

  DashBoardState copyWith({
    ApiCallStatus? apiCallStatus,
    TabType? selectedTabType,
    GroupInfoType? groupInfoType,
    GroupModel? groupModel,
  }) {
    return DashBoardState(
      apiCallStatus: apiCallStatus ?? this.apiCallStatus,
      selectedTabType: selectedTabType ?? this.selectedTabType,
      groupInfoType: groupInfoType ?? this.groupInfoType,
      groupModel: groupModel ?? this.groupModel,
    );
  }
}
