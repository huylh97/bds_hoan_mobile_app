part of 'invite_group_acception_cubit.dart';

class InviteGroupAcceptionState extends Equatable {
  final ApiCallStatus? apiCallStatus;

  const InviteGroupAcceptionState({this.apiCallStatus});

  @override
  List<Object?> get props => [apiCallStatus];

  InviteGroupAcceptionState copyWith({ApiCallStatus? apiCallStatus}) {
    return InviteGroupAcceptionState(
        apiCallStatus: apiCallStatus ?? this.apiCallStatus);
  }
}
