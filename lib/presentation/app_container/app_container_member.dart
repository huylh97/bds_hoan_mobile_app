import 'package:bds_hoan_mobile/bloc_global/app_bloc.dart';
import 'package:bds_hoan_mobile/bloc_global/app_container/app_container_member_cubit.dart';
import 'package:bds_hoan_mobile/bloc_global/app_container/app_container_menber_state.dart';
import 'package:bds_hoan_mobile/presentation/screens/screens.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:bds_hoan_mobile/configs/_config.dart';

import 'widgets/app_drawer.dart';

class AppContainerMember extends StatefulWidget {
  const AppContainerMember({Key? key}) : super(key: key);

  @override
  _AppContainerMemberState createState() => _AppContainerMemberState();
}

class _AppContainerMemberState extends State<AppContainerMember>
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
    RealEstateSearchScreen(),
    GroupInfoScreen(),
  ];

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<AppContainerMemberCubit, AppContainerMemberState>(
      builder: (context, state) {
        return Scaffold(
          key: state.scaffoldKey,
          drawer: const AppDrawer(),
          body: _screens.elementAt(state.bottomTab.index),
          bottomNavigationBar: BottomNavigationBar(
            items: [
              BottomNavigationBarItem(
                icon: buildTabIcon(AppIcons.bottom_tab_search, size: 18.sp),
                activeIcon: buildTabIcon(AppIcons.bottom_tab_search,
                    isSelected: true, size: 18.sp),
                label: 'Tìm kiếm',
              ),
              BottomNavigationBarItem(
                icon: buildTabIcon(AppIcons.bottom_tab_group, size: 22.sp),
                activeIcon: buildTabIcon(AppIcons.bottom_tab_group,
                    isSelected: true, size: 22.sp),
                label: 'Nhóm',
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
              AppBloc.appContainerMemberCubit
                  .onSelectBottomTab(AppBottomTabMember.values[index]);
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
}
