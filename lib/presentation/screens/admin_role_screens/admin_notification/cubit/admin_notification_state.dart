part of 'admin_notification_cubit.dart';

class AdminNotificationState extends Equatable {
  final ApiCallStatus? apiCallStatus;
  final List<NotificationData>? dataList;

  const AdminNotificationState({this.apiCallStatus, this.dataList});

  @override
  List<Object?> get props => [apiCallStatus, dataList];

  AdminNotificationState copyWith(
      {ApiCallStatus? apiCallStatus, List<NotificationData>? dataList}) {
    return AdminNotificationState(
        apiCallStatus: apiCallStatus ?? this.apiCallStatus,
        dataList: dataList ?? this.dataList);
  }
}
