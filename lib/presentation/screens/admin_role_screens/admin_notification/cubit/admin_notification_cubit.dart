import 'package:bds_hoan_mobile/bloc_global/app_bloc.dart';
import 'package:bds_hoan_mobile/data/enums/api_call_status.dart';
import 'package:bds_hoan_mobile/data/models/notification/notification_data.dart';
import 'package:bds_hoan_mobile/data/repository/notification_repository.dart';
import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';

part 'admin_notification_state.dart';

class AdminNotificationCubit extends Cubit<AdminNotificationState> {
  AdminNotificationCubit() : super(const AdminNotificationState());

  Future<void> getNotifications({bool enableLoading = true}) async {
    if (enableLoading) {
      emit(state.copyWith(apiCallStatus: ApiCallStatus.loading));
    }

    final result = await NotificationRepository.getNotifications();
    if (enableLoading) emit(state.copyWith(apiCallStatus: ApiCallStatus.init));
    if (result != null) {
      emit(state.copyWith(dataList: result));
      var notSeenList = result
          .where((element) => element.seen == null || element.seen == false);
      AppBloc.appContainerAdminCubit
          .setNumNotifications(numNotifications: notSeenList.length);
    } else {
      emit(const AdminNotificationState());
    }
  }

  Future<void> getNotiDetail(
      {bool enableLoading = true, required int id}) async {
    if (enableLoading) {
      emit(state.copyWith(apiCallStatus: ApiCallStatus.loading));
    }

    final result = await NotificationRepository.getNotiDetail(id: id);
    if (enableLoading) emit(state.copyWith(apiCallStatus: ApiCallStatus.init));
    if (result != null) {
      emit(state.copyWith());
    } else {
      emit(const AdminNotificationState());
    }
  }

  Future<void> deleteNotification(
      {bool enableLoading = true, required int id}) async {
    if (enableLoading) {
      emit(state.copyWith(apiCallStatus: ApiCallStatus.loading));
    }

    final result = await NotificationRepository.deleteNotification(id: id);

    if (result == true) {
      final result = await NotificationRepository.getNotifications();
      if (enableLoading) {
        emit(state.copyWith(apiCallStatus: ApiCallStatus.init));
      }
      if (result != null) {
        emit(state.copyWith(dataList: result));
        var notSeenList = result
            .where((element) => element.seen == null || element.seen == false);
        AppBloc.appContainerAdminCubit
            .setNumNotifications(numNotifications: notSeenList.length);
      } else {
        emit(const AdminNotificationState());
      }
    } else {
      if (enableLoading) {
        emit(state.copyWith(apiCallStatus: ApiCallStatus.init));
      }
    }
  }
}
