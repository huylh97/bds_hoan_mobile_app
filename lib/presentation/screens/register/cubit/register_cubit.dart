import 'package:bloc/bloc.dart';
import 'package:bds_hoan_mobile/data/repository/user_repository.dart';

import 'register_state.dart';

class RegisterCubit extends Cubit<RegisterState> {
  RegisterCubit() : super(const RegisterState());

  void onToggleConfirmPrivacy() {
    emit(state.copyWith(confirmPrivacy: !state.confirmPrivacy));
  }

  /// Function handle remote date
  Future<bool?> onRegister({
    required String phoneNumber,
    required String name,
    required String password,
    required String confirmPassword,
  }) async {
    emit(state.copyWith(loadingStatus: RegisterLoadingStatus.loading));

    final result = await UserRepository.register(
      phoneNumber: phoneNumber,
      name: name,
      password: password,
      confirmPassword: confirmPassword,
    );
    emit(state.copyWith(loadingStatus: RegisterLoadingStatus.init));
    return result;
  }
}
