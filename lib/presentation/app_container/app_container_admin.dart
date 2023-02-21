import 'package:badges/badges.dart';
import 'package:bds_hoan_mobile/bloc_global/app_bloc.dart';
import 'package:bds_hoan_mobile/bloc_global/app_container/app_container_admin_state.dart';
import 'package:bds_hoan_mobile/bloc_global/bloc.dart';
import 'package:bds_hoan_mobile/data/enums/api_call_status.dart';
import 'package:bds_hoan_mobile/presentation/app_container/widgets/app_drawer.dart';
import 'package:bds_hoan_mobile/presentation/screens/admin_role_screens/admin_notification/view/admin_notification_screen.dart';
import 'package:bds_hoan_mobile/presentation/screens/screens.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:bds_hoan_mobile/configs/_config.dart';

class AppContainerAdmin extends StatefulWidget {
  const AppContainerAdmin({Key? key}) : super(key: key);

  @override
  _AppContainerAdminState createState() => _AppContainerAdminState();
}

class _AppContainerAdminState extends State<AppContainerAdmin>
    with WidgetsBindingObserver {
  @override
  void initState() {
    super.initState();

    ///AppState add observer
    WidgetsBinding.instance.addObserver(this);
    initData();
  }

  @override
  void dispose() {
    WidgetsBinding.instance.removeObserver(this);
    super.dispose();
  }

  ///Handle AppState
  @override
  void didChangeAppLifecycleState(state) {
    super.didChangeAppLifecycleState(state);
    switch (state) {
      case AppLifecycleState.resumed:
        break;
      case AppLifecycleState.inactive:
        break;
      case AppLifecycleState.paused:
        break;
      case AppLifecycleState.detached:
        break;
    }
  }

  void initData() async {}

  static const List<Widget> _screens = <Widget>[
    AdminNotificationScreen(),
    DashBoardScreen(),
    // AdminSearchScreen(),
    RealEstateSearchScreen(),
  ];

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<AppContainerAdminCubit, AppContainerAdminState>(
      builder: (context, state) {
        if (state.apiCallStatus == ApiCallStatus.loading) {
          return const Center(
            child: CircularProgressIndicator(),
          );
        }
        return Scaffold(
          key: state.scaffoldKey,
          body: _screens.elementAt(state.bottomTab.index),
          drawer: const AppDrawer(),
          bottomNavigationBar: BottomNavigationBar(
            items: [
              BottomNavigationBarItem(
                icon: buildTabIconWithBadge(AppIcons.bottom_tab_notification,
                    size: 20.sp, numNotAprroved: state.numNotifications),
                activeIcon: buildTabIconWithBadge(
                    AppIcons.bottom_tab_notification,
                    isSelected: true,
                    size: 20.sp,
                    numNotAprroved: state.numNotifications),
                label: 'Thông báo',
              ),
              BottomNavigationBarItem(
                icon:
                    buildTabIcon(AppIcons.bottom_tab_manage_user, size: 18.sp),
                activeIcon: buildTabIcon(AppIcons.bottom_tab_manage_user,
                    isSelected: true, size: 18.sp),
                label: 'Bảng điều khiển',
              ),
              BottomNavigationBarItem(
                icon: buildTabIcon(AppIcons.bottom_tab_search, size: 20.sp),
                activeIcon: buildTabIcon(AppIcons.bottom_tab_search,
                    isSelected: true, size: 20.sp),
                label: 'Tìm kiếm',
              ),
            ],
            selectedFontSize: 13.sp,
            unselectedFontSize: 13.sp,
            selectedLabelStyle: const TextStyle(
                color: AppColors.primary, fontWeight: FontWeight.bold),
            unselectedLabelStyle:
                const TextStyle(color: AppColors.unSelectedBottomTab),
            fixedColor: AppColors.primary,
            elevation: 16,
            currentIndex: state.bottomTab.index,
            onTap: (int index) async {
              AppBloc.appContainerAdminCubit
                  .onSelectBottomTab(AppBottomTabAdmin.values[index]);
            },
          ),
        );
      },
    );
  }

  Widget buildTabIcon(String assetName,
      {bool isSelected = false, double? size}) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 5.0),
      child: Image.asset(
        assetName,
        color: isSelected ? AppColors.primary : null,
        alignment: Alignment.topCenter,
        height: size ?? 18,
      ),
    );
  }

  Widget buildTabIconWithBadge(String assetName,
      {bool isSelected = false, double? size, int? numNotAprroved}) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 5.0),
      child: Badge(
          badgeColor: Colors.red,
          badgeContent: Text(
            '${numNotAprroved ?? 0}',
            style: TextStyle(color: Colors.white),
          ),
          child: Image.asset(
            assetName,
            color: isSelected ? AppColors.primary : null,
            alignment: Alignment.topCenter,
            height: size ?? 18,
          )),
    );
  }
}
