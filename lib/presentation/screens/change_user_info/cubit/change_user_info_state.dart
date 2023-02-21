import 'package:bds_hoan_mobile/data/enums/api_call_status.dart';
import 'package:bds_hoan_mobile/data/models/user/user_model.dart';
import 'package:equatable/equatable.dart';

class ChangeUserInfoState extends Equatable {
  final ApiCallStatus? apiCallStatus;
  final UserModel? userModel;

  const ChangeUserInfoState({
    this.apiCallStatus,
    this.userModel,
  });

  @override
  List<Object?> get props => [apiCallStatus, userModel];

  ChangeUserInfoState copyWith({
    ApiCallStatus? apiCallStatus,
    UserModel? userModel,
  }) {
    return ChangeUserInfoState(
      apiCallStatus: apiCallStatus ?? this.apiCallStatus,
      userModel: userModel ?? this.userModel,
    );
  }
}
