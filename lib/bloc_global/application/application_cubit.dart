import 'package:bds_hoan_mobile/bloc_global/app_bloc.dart';
import 'package:bloc/bloc.dart';
import 'package:bds_hoan_mobile/configs/_config.dart';

import 'app_text_style.dart';

enum ApplicationState { loading, completed }

class ApplicationCubit extends Cubit<ApplicationState> {
  ApplicationCubit() : super(ApplicationState.loading);

  late AppTextStyle appTextStyle;

  void onSetup() async {
    ///Setup SharedPreferences
    await Preferences.setPreferences();

    ///Authentication begin check
    await AppBloc.authenticationCubit.onCheck();

    ///Done
    await Future.delayed(const Duration(seconds: 1));
    emit(ApplicationState.completed);
  }

  void initAppTextStyle() {
    appTextStyle = AppTextStyle();
  }
}
