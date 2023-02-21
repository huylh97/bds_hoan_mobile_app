import 'package:bds_hoan_mobile/bloc_global/app_container/app_container_new_user_cubit.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'bloc.dart';

class AppBloc {
  static final applicationCubit = ApplicationCubit();
  static final authenticationCubit = AuthenticationCubit();
  static final userCubit = UserCubit();
  static final messageBloc = MessageBloc();
  static final appContainerSuperAdminCubit = AppContainerSuperAdminCubit();
  static final appContainerMemberCubit = AppContainerMemberCubit();
  static final appContainerAdminCubit = AppContainerAdminCubit();
  static final appContainerNewUserCubit = AppContainerNewUserCubit();

  static final List<BlocProvider> providers = [
    BlocProvider<ApplicationCubit>(create: (context) => applicationCubit),
    BlocProvider<AuthenticationCubit>(create: (context) => authenticationCubit),
    BlocProvider<UserCubit>(create: (context) => userCubit),
    BlocProvider<MessageBloc>(create: (context) => messageBloc),
    BlocProvider<AppContainerSuperAdminCubit>(
        create: (context) => appContainerSuperAdminCubit),
    BlocProvider<AppContainerMemberCubit>(
        create: (context) => appContainerMemberCubit),
    BlocProvider<AppContainerAdminCubit>(
        create: (context) => appContainerAdminCubit),
    BlocProvider<AppContainerNewUserCubit>(
        create: (context) => appContainerNewUserCubit),
  ];

  static void dispose() {
    applicationCubit.close();
    authenticationCubit.close();
    userCubit.close();
    messageBloc.close();
    appContainerSuperAdminCubit.close();
    appContainerMemberCubit.close();
    appContainerAdminCubit.close();
    appContainerNewUserCubit.close();
  }

  ///Singleton factory
  static final AppBloc _instance = AppBloc._internal();

  factory AppBloc() {
    return _instance;
  }

  AppBloc._internal();
}
