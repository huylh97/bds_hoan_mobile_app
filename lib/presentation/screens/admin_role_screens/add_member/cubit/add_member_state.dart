import 'package:bds_hoan_mobile/data/enums/api_call_status.dart';
import 'package:bds_hoan_mobile/data/enums/button_loading_status.dart';
import 'package:bds_hoan_mobile/data/models/user/user_model.dart';
import 'package:equatable/equatable.dart';

class AddMemberState extends Equatable {
  final ApiCallStatus? apiCallStatus;
  final List<UserModel>? users;

  const AddMemberState({
    this.apiCallStatus,
    this.users,
  });

  @override
  List<Object?> get props => [apiCallStatus, users];

  AddMemberState copyWith({
    ApiCallStatus? apiCallStatus,
    List<UserModel>? users,
    ButtonLoadingStatus? buttonLoadingStatus,
  }) {
    return AddMemberState(
      apiCallStatus: apiCallStatus ?? this.apiCallStatus,
      users: users ?? this.users,
    );
  }
}
