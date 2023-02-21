import 'package:bds_hoan_mobile/presentation/screens/admin_role_screens/admin_notification/cubit/admin_notification_cubit.dart';
import 'package:bds_hoan_mobile/presentation/screens/admin_role_screens/admin_notification/view/admin_notification_view.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class AdminNotificationScreen extends StatelessWidget {
  const AdminNotificationScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (_) => AdminNotificationCubit(),
      child: const NotificationListView(),
    );
  }
}
