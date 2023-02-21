import 'package:bds_hoan_mobile/bloc_global/app_bloc.dart';
import 'package:bds_hoan_mobile/bloc_global/bloc.dart';
import 'package:bds_hoan_mobile/configs/_config.dart';
import 'package:bds_hoan_mobile/presentation/app_container/app_container_admin.dart';
import 'package:bds_hoan_mobile/presentation/app_container/app_container_new_user.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_localizations/flutter_localizations.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import 'presentation/app_container/app_container_member.dart';
import 'presentation/app_container/app_container_super_admin.dart';
import 'presentation/screens/screens.dart';
import 'presentation/shared_widgets/dialogs/widget.dart';

class App extends StatefulWidget {
  const App({Key? key}) : super(key: key);

  @override
  _AppState createState() => _AppState();
}

class _AppState extends State<App> {
  @override
  void initState() {
    super.initState();
    AppBloc.applicationCubit.onSetup();
  }

  @override
  void dispose() {
    AppBloc.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return MultiBlocProvider(
      providers: AppBloc.providers,
      child: BlocBuilder<AuthenticationCubit, AuthenticationState>(
        builder: (context, auth) {
          return ScreenUtilInit(
              designSize: const Size(360, 690),
              builder: (context, child) {
                AppBloc.applicationCubit.initAppTextStyle();
                return MaterialApp(
                  localizationsDelegates: [
                    GlobalMaterialLocalizations.delegate,
                    GlobalCupertinoLocalizations.delegate,
                  ],
                  supportedLocales: [const Locale('vi', 'VN')],
                  debugShowCheckedModeBanner: false,
                  theme: ThemeConfig.getTheme(),
                  darkTheme: ThemeConfig.getTheme(),
                  onGenerateRoute: Routes.generateRoute,
                  builder: (context, child) {
                    return ScrollConfiguration(
                      behavior: MyBehavior(),
                      child: child ?? const SizedBox(),
                    );
                  },
                  home: Scaffold(
                    body: BlocListener<MessageBloc, MessageState>(
                      listener: (context, message) {
                        if (message is MessageShowHttpErrorState) {
                          Future.delayed(const Duration(milliseconds: 200), () {
                            showDialog<void>(
                              context: context,
                              barrierDismissible: false,
                              builder: (_) => ErrorAlertDialog(
                                  message: message.resultApi.message),
                            );
                          });
                        }
                        if (message is MessageShowHttpSuccessState) {
                          Future.delayed(const Duration(milliseconds: 200), () {
                            showDialog<void>(
                              context: context,
                              barrierDismissible: false,
                              builder: (_) => SuccessAlertDialog(
                                  message: message.resultApi.message),
                            );
                          });
                        }
                        if (message is MessageOnLoadingState) {
                          if (message.showLoading) {
                            showDialog<void>(
                              context: context,
                              barrierDismissible: false,
                              builder: (_) => const LoadingDialog(),
                            );
                          } else {
                            Navigator.pop(context);
                          }
                        }
                      },
                      child: BlocBuilder<ApplicationCubit, ApplicationState>(
                        builder: (context, application) {
                          // return const AppContainerAdmin();
                          if (application == ApplicationState.completed) {
                            if (auth == AuthenticationState.onLogin) {
                              return const LoginScreen();
                            }
                            if (auth == AuthenticationState.onRegister) {
                              return const RegisterScreen();
                            }
                            if (auth == AuthenticationState.success) {
                              // Truong hop la super admin
                              if (AppBloc.authenticationCubit.isSuperAdmin ==
                                  true) {
                                return const AppContainerSuperAdmin();
                              }
                              if ((AppBloc.authenticationCubit.hasGroup ==
                                          false &&
                                      AppBloc.authenticationCubit
                                              .isAdminLogin !=
                                          true) ||
                                  (AppBloc.authenticationCubit.hasGroup ==
                                          true &&
                                      AppBloc.authenticationCubit.inviteGroup !=
                                          null)) {
                                return const AppContainerNewUser();
                              }
                              // Truong hop da dang ky goi
                              if (AppBloc.authenticationCubit.isAdminLogin ==
                                  true) {
                                return const AppContainerAdmin();
                              }
                              return const AppContainerMember();
                            }
                          }
                          return const SplashScreen();
                        },
                      ),
                    ),
                  ),
                );
              });
        },
      ),
    );
  }
}

class MyBehavior extends ScrollBehavior {
  @override
  Widget buildOverscrollIndicator(
      BuildContext context, Widget child, ScrollableDetails details) {
    return child;
  }
}
