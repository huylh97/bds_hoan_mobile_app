part of 'subcription_view_info_cubit.dart';

class SubcriptionViewInfoState extends Equatable {
  final ApiCallStatus? apiCallStatus;
  final SubscriptionUserData? subscriptionUserData;

  const SubcriptionViewInfoState(
      {this.apiCallStatus, this.subscriptionUserData});

  @override
  List<Object?> get props => [apiCallStatus, subscriptionUserData];

  SubcriptionViewInfoState copyWith(
      {ApiCallStatus? apiCallStatus, SubscriptionUserData? subcriptionDetail}) {
    return SubcriptionViewInfoState(
        apiCallStatus: apiCallStatus ?? this.apiCallStatus,
        subscriptionUserData: subcriptionDetail ?? this.subscriptionUserData);
  }
}
