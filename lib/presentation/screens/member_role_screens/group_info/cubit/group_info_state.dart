import 'package:bds_hoan_mobile/data/enums/api_call_status.dart';
import 'package:bds_hoan_mobile/data/enums/button_loading_status.dart';
import 'package:bds_hoan_mobile/data/models/group/group_model.dart';
import 'package:bds_hoan_mobile/presentation/screens/admin_role_screens/dashboard/cubit/dash_board_state.dart';
import 'package:equatable/equatable.dart';

class GroupInfoState extends Equatable {
  final ApiCallStatus? apiCallStatus;
  final GroupInfoType groupInfoType;
  final GroupModel? groupModel;

  const GroupInfoState({
    this.apiCallStatus,
    this.groupInfoType = GroupInfoType.introduction,
    this.groupModel,
  });

  @override
  List<Object?> get props => [apiCallStatus, groupInfoType, groupModel];

  GroupInfoState copyWith({
    ApiCallStatus? apiCallStatus,
    GroupInfoType? groupInfoType,
    GroupModel? groupModel,
    ButtonLoadingStatus? buttonLoadingStatus,
  }) {
    return GroupInfoState(
      apiCallStatus: apiCallStatus ?? this.apiCallStatus,
      groupInfoType: groupInfoType ?? this.groupInfoType,
      groupModel: groupModel ?? this.groupModel,
    );
  }
}
