import 'dart:io';

import 'package:bloc/bloc.dart';
import 'package:bds_hoan_mobile/app.dart';
import 'package:bds_hoan_mobile/presentation/shared_widgets/utils/_utils.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';

class AppBlocObserver extends BlocObserver {
  @override
  void onCreate(BlocBase bloc) {
    super.onCreate(bloc);
    UtilLogger.log('${bloc.runtimeType}');
  }

  @override
  void onChange(BlocBase bloc, Change change) {
    super.onChange(bloc, change);
    UtilLogger.log('${bloc.runtimeType}', change);
  }

  @override
  void onError(BlocBase bloc, Object error, StackTrace stackTrace) {
    super.onError(bloc, error, stackTrace);
    UtilLogger.log('${bloc.runtimeType}', error);
  }

  @override
  void onClose(BlocBase bloc) {
    super.onClose(bloc);
    UtilLogger.log('${bloc.runtimeType}');
  }
}

class MyHttpOverrides extends HttpOverrides {
  @override
  HttpClient createHttpClient(SecurityContext? context) {
    return super.createHttpClient(context)..badCertificateCallback = (X509Certificate cert, String host, int port) => true;
  }
}

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  HttpOverrides.global = MyHttpOverrides();

  BlocOverrides.runZoned(
    () {
      runApp(const App());
    },
    blocObserver: AppBlocObserver(),
  );
}
