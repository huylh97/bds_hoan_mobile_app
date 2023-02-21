import 'package:bds_hoan_mobile/data/repository/user_repository.dart';
import 'package:bloc/bloc.dart';

import 'change_password_state.dart';

class ChangePasswordCubit extends Cubit<ChangePasswordState> {
  ChangePasswordCubit() : super(const ChangePasswordState());

  void changePassword({
    required String? password,
    required String? newPassword,
    required String? confirmNewPassword,
  }) async {
    emit(state.copyWith(loadingStatus: ChangePasswordLoadingStatus.loading));
    await UserRepository.updatePassword(
      password: password,
      newPassword: newPassword,
      confirmNewPassword: confirmNewPassword,
    );
    emit(state.copyWith(loadingStatus: ChangePasswordLoadingStatus.init));
  }
}
