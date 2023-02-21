import 'package:bds_hoan_mobile/bloc_global/app_bloc.dart';
import 'package:bds_hoan_mobile/bloc_global/app_container/app_container_new_user_cubit.dart';
import 'package:bds_hoan_mobile/bloc_global/app_container/app_container_new_user_state.dart';
import 'package:bds_hoan_mobile/configs/_config.dart';
import 'package:bds_hoan_mobile/presentation/app_container/widgets/app_drawer.dart';
import 'package:bds_hoan_mobile/presentation/screens/introduction/view/introduction_screen.dart';
import 'package:bds_hoan_mobile/presentation/screens/member_role_screens/invite_group_acception/view/invite_group_acception_screen.dart';
import 'package:bds_hoan_mobile/presentation/screens/screens.dart';
import 'package:bds_hoan_mobile/presentation/shared_widgets/utils/_utils.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class AppContainerNewUser extends StatefulWidget {
  const AppContainerNewUser({Key? key}) : super(key: key);

  @override
  _AppContainerNewUserState createState() => _AppContainerNewUserState();
}

class _AppContainerNewUserState extends State<AppContainerNewUser> with WidgetsBindingObserver {
  late final AppContainerNewUserCubit cubit;

  @override
  void initState() {
    super.initState();

    ///AppState add observer
    WidgetsBinding.instance.addObserver(this);
    // initData();
    cubit = BlocProvider.of<AppContainerNewUserCubit>(context);
    if (AppBloc.authenticationCubit.isSuperAdmin != true) {
      cubit.checkIfHasUnApprovedSubcription();
    }
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

  static const List<Widget> _screens = <Widget>[];

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<AppContainerNewUserCubit, AppContainerNewUserState>(
      builder: (context, state) {
        return Scaffold(
          key: state.scaffoldKey,
          body: getDisplay(state),
          drawer: const AppDrawer(),
        );
      },
    );
  }

  Widget getDisplay(AppContainerNewUserState state) {
    if (AppBloc.authenticationCubit.isSuperAdmin == true) {
      return const SubcriptionManageListScreen();
    }
    if (state.hasUnApprovedSubcription == true) {
      return const SubcriptionPendingScreen(isSubcription: true);
    } else {
      if (state.showNotBelongToAnyGroup == true) {
        return const SubcriptionPendingScreen(isSubcription: false);
      }
    }
    // ignore: unrelated_type_equality_checks
    if (AppBloc.authenticationCubit.inviteGroup != null) {
      return const InviteGroupAcceptionScreen();
    }
    bool? showedIntro = UtilPreferences.getBool(AppConstant.showedIntro);
    if (showedIntro != true) {
      return const IntroductionScreen();
    }
    return const SubcriptionSelectionScreen();
  }
}
