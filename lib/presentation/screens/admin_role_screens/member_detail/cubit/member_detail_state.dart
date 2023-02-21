import 'package:bds_hoan_mobile/data/enums/api_call_status.dart';
import 'package:bds_hoan_mobile/data/enums/button_loading_status.dart';
import 'package:bds_hoan_mobile/data/models/user/user_model.dart';
import 'package:equatable/equatable.dart';

class MemberDetailState extends Equatable {
  final ApiCallStatus apiCallStatus;
  final ButtonLoadingStatus? buttonLoadingStatus;
  final UserModel? user;

  const MemberDetailState({
    this.apiCallStatus = ApiCallStatus.init,
    this.buttonLoadingStatus = ButtonLoadingStatus.init,
    this.user,
  });

  @override
  List<Object?> get props => [apiCallStatus, buttonLoadingStatus, user];

  MemberDetailState copyWith({
    ApiCallStatus? apiCallStatus,
    UserModel? user,
    ButtonLoadingStatus? buttonLoadingStatus,
  }) {
    return MemberDetailState(
      apiCallStatus: apiCallStatus ?? this.apiCallStatus,
      buttonLoadingStatus: buttonLoadingStatus ?? this.buttonLoadingStatus,
      user: user ?? this.user,
    );
  }
}
