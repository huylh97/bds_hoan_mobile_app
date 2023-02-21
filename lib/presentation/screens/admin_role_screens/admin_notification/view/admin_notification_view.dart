import 'package:bds_hoan_mobile/bloc_global/app_bloc.dart';
import 'package:bds_hoan_mobile/configs/_config.dart';
import 'package:bds_hoan_mobile/data/enums/api_call_status.dart';
import 'package:bds_hoan_mobile/presentation/app_container/widgets/app_drawer.dart';
import 'package:bds_hoan_mobile/presentation/screens/admin_role_screens/admin_notification/cubit/admin_notification_cubit.dart';
import 'package:bds_hoan_mobile/presentation/shared_widgets/common/widget.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import 'widgets/admin_notification_card_widget.dart';

class NotificationListView extends StatefulWidget {
  const NotificationListView({
    Key? key,
  }) : super(key: key);

  @override
  State<NotificationListView> createState() => _NotificationListViewState();
}

class _NotificationListViewState extends State<NotificationListView> {
  late final AdminNotificationCubit cubit;

  @override
  void initState() {
    super.initState();
    cubit = BlocProvider.of<AdminNotificationCubit>(context);
    cubit.getNotifications();
  }

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        FocusScope.of(context).unfocus();
      },
      child: Scaffold(
        backgroundColor: AppColors.scaffoldBgColor,
        drawer: const AppDrawer(),
        appBar: _buildAppBar(context),
        body: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 0),
          child: BlocBuilder<AdminNotificationCubit, AdminNotificationState>(
              builder: (context, state) {
            if (state.apiCallStatus == ApiCallStatus.loading) {
              return Padding(
                padding: EdgeInsets.only(
                    top: MediaQuery.of(context).size.height / 4),
                child: const Center(
                  child: CircularProgressIndicator(),
                ),
              );
            }

            return Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  const SizedBox(height: 15),
                  const Padding(
                      padding: EdgeInsets.symmetric(horizontal: 0),
                      child: DefaultDivider()),
                  Expanded(
                      child: ListView.builder(
                    itemCount:
                        state.dataList == null ? 0 : state.dataList!.length,
                    padding: const EdgeInsets.only(top: 8),
                    scrollDirection: Axis.vertical,
                    itemBuilder: (BuildContext context, int index) {
                      return Dismissible(
                          key: Key('${state.dataList![index].id!}'),
                          background: Container(
                            color: Colors.red,
                            child: Text('Xóa'),
                          ),
                          onDismissed: (direction) {
                            // Remove the item from the data source.
                            setState(() {
                              cubit.deleteNotification(
                                  id: state.dataList![index].id!);
                            });
                          },
                          child: WidgetAdminNotificationCard(
                            cubit: cubit,
                            callback: () {
                              cubit.getNotiDetail(
                                  id: state.dataList![index].id!);
                              Navigator.pushNamed(
                                      context, Routes.realEstateViewInfo,
                                      arguments:
                                          state.dataList![index].fK_RealEstate)
                                  .then((value) {
                                cubit.getNotifications();
                              });
                            },
                            data: state.dataList![index],
                          ));
                    },
                  ))
                ]);
          }),
        ),
      ),
    );
  }

  AppBar _buildAppBar(BuildContext context) {
    return AppBar(
      centerTitle: false,
      elevation: 0,
      leadingWidth: 0,
      leading: const SizedBox(),
      title: Row(
        mainAxisAlignment: MainAxisAlignment.start,
        mainAxisSize: MainAxisSize.max,
        children: [
          InkWell(
            splashColor: Colors.white,
            highlightColor: Colors.white,
            onTap: () {
              AppBloc.appContainerAdminCubit.state.scaffoldKey.currentState
                  ?.openDrawer();
            },
            child: Container(
              padding: const EdgeInsets.all(8),
              decoration: BoxDecoration(
                border: Border.all(color: AppColors.boxBorder),
                borderRadius: BorderRadius.circular(12),
              ),
              child: const Icon(Icons.menu, color: Color(0xFF374957)),
            ),
          ),
          const Expanded(child: SizedBox()),
          Text(
            'Thông báo',
            style: AppBloc.applicationCubit.appTextStyle.mediumBold,
          ),
          const Expanded(child: SizedBox()),
          Text('        ')
        ],
      ),
    );
  }
}
