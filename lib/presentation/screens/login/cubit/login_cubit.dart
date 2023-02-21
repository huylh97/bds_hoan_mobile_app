import 'package:bds_hoan_mobile/bloc_global/app_bloc.dart';
import 'package:bloc/bloc.dart';
import 'package:bds_hoan_mobile/data/repository/user_repository.dart';

import 'login_state.dart';

class LoginCubit extends Cubit<LoginState> {
  LoginCubit() : super(const LoginState());

  void onLogin({
    required String phoneNumber,
    required String password,
  }) async {
    emit(state.copyWith(status: LoginStateStatus.loading));

    final result = await UserRepository.login(
      phoneNumber: phoneNumber,
      password: password,
    );

    if (result != null) {
      await AppBloc.authenticationCubit.onSave(result);
    }

    emit(state.copyWith(status: LoginStateStatus.init));
  }
}
