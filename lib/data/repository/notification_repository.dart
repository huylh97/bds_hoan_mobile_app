import 'package:bds_hoan_mobile/bloc_global/app_bloc.dart';
import 'package:bds_hoan_mobile/bloc_global/bloc.dart';
import 'package:bds_hoan_mobile/data/api_service/api_notification.dart';
import 'package:bds_hoan_mobile/data/models/notification/notification_data.dart';

class NotificationRepository {
  NotificationRepository._internal();

  static Future<List<NotificationData>?> getNotifications() async {
    final result = await ApiNotification.getNotifications();
    if (result.success) {
      final list = <NotificationData>[];
      result.data['result'].forEach((e) {
        list.add(NotificationData.fromJson(e));
      });
      return list;
    }
    if (!result.success && result.statusCode == 400) {
      return null;
    }
    AppBloc.messageBloc.add(OnHttpMessage(resultApi: result));
    return null;
  }

  static Future<NotificationData?> getNotiDetail({required int id}) async {
    final result = await ApiNotification.getNotiDetail(id: id);
    if (result.success) {
      return NotificationData.fromJson(result.data);
    }
    AppBloc.messageBloc.add(OnHttpMessage(resultApi: result));
    return null;
  }

  static Future<bool?> deleteNotification({required int id}) async {
    final result = await ApiNotification.deleteNotification(id: id);
    if (result.success) {
      return true;
    }
    AppBloc.messageBloc.add(OnHttpMessage(resultApi: result));
    return null;
  }
}
