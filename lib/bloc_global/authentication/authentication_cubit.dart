import 'package:bds_hoan_mobile/bloc_global/app_bloc.dart';
import 'package:bds_hoan_mobile/data/enums/user_role.dart';
import 'package:bds_hoan_mobile/data/models/invite_group/invite_group.dart';
import 'package:bds_hoan_mobile/data/models/user/user_model.dart';
import 'package:bds_hoan_mobile/data/repository/admin_repository.dart';
import 'package:bds_hoan_mobile/data/repository/notification_repository.dart';
import 'package:bds_hoan_mobile/data/repository/subcription_repository.dart';
import 'package:bloc/bloc.dart';
import 'package:bds_hoan_mobile/data/repository/user_repository.dart';

enum AuthenticationState {
  loading,
  onRegister,
  onLogin,
  success,
}

class AuthenticationCubit extends Cubit<AuthenticationState> {
  AuthenticationCubit() : super(AuthenticationState.loading);

  bool? isAdminLogin = false;
  bool? hasGroup = false;
  bool? isSuperAdmin = false;
  InviteGroup? inviteGroup;

  Future<void> onCheck() async {
    bool isValidated = await UserRepository.checkLocalAccessToken();
    if (isValidated) {
      final user = await UserRepository.getUserInfo();
      if (user?.role == UserRole.superAdmin) {
        isSuperAdmin = true;
      } else {
        isSuperAdmin = false;
      }

      if (user?.role == UserRole.admin) {
        isAdminLogin = true;
      } else {
        isAdminLogin = false;
      }

      hasGroup = false;
      final result = await AdminRepository.getGroupInfo();
      if (result != null && isAdminLogin == false && isSuperAdmin == false) {
        inviteGroup = null;
        final listInvite = await UserRepository.getListInvite();
        if (listInvite != null && listInvite.isNotEmpty) {
          inviteGroup = listInvite[0];
        }
        hasGroup = true;
      }

      await AppBloc.userCubit.onSaveUser(user);
      if (isAdminLogin == true) {
        final result = await NotificationRepository.getNotifications();
        if (result != null) {
          var notSeenList = result.where(
              (element) => element.seen == null || element.seen == false);
          AppBloc.appContainerAdminCubit
              .setNumNotifications(numNotifications: notSeenList.length);
        }
      }
      emit(AuthenticationState.success);
    } else {
      emit(AuthenticationState.onLogin);
    }
  }

  Future<void> onSave(UserModel? user) async {
    if (user?.role == UserRole.superAdmin) {
      isSuperAdmin = true;
    } else {
      isSuperAdmin = false;
    }

    if (user?.role == UserRole.admin) {
      isAdminLogin = true;
    } else {
      isAdminLogin = false;
    }

    hasGroup = false;
    final result = await AdminRepository.getGroupInfo();
    if (result != null && isAdminLogin == false && isSuperAdmin == false) {
      inviteGroup = null;
      final listInvite = await UserRepository.getListInvite();
      if (listInvite != null && listInvite.isNotEmpty) {
        inviteGroup = listInvite[0];
      }
      hasGroup = true;
    }

    await AppBloc.userCubit.onSaveUser(user);
    if (isAdminLogin == true) {
      final result = await NotificationRepository.getNotifications();
      if (result != null) {
        var notSeenList = result
            .where((element) => element.seen == null || element.seen == false);
        AppBloc.appContainerAdminCubit
            .setNumNotifications(numNotifications: notSeenList.length);
      }
    }

    emit(AuthenticationState.success);
  }

  Future<void> onClear() async {
    await AppBloc.userCubit.onClear();
    emit(AuthenticationState.onLogin);
  }

  void onChangeAuthenticationState(AuthenticationState state) {
    emit(state);
  }
}
