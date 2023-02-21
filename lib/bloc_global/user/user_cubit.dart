import 'package:bds_hoan_mobile/data/models/user/user_model.dart';
import 'package:bloc/bloc.dart';
import 'package:bds_hoan_mobile/data/repository/user_repository.dart';

class UserCubit extends Cubit<UserModel?> {
  UserCubit() : super(null);

  Future<void> onSetUser(UserModel? user) async {
    emit(user);
  }

  Future<void> onSaveUser(UserModel? user) async {
    emit(user);
  }

  Future<void> onClear() async {
    UserRepository.clearAccessToken();
    emit(null);
  }
}
