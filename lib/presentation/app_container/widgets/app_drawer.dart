import 'package:bds_hoan_mobile/bloc_global/app_bloc.dart';
import 'package:bds_hoan_mobile/bloc_global/bloc.dart';
import 'package:bds_hoan_mobile/configs/_config.dart';
import 'package:bds_hoan_mobile/data/enums/user_role.dart';
import 'package:bds_hoan_mobile/data/models/user/user_model.dart';
import 'package:bds_hoan_mobile/presentation/screens/screens.dart';
import 'package:bds_hoan_mobile/presentation/shared_widgets/dialogs/widget.dart';
import 'package:bds_hoan_mobile/presentation/shared_widgets/label/lable.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class AppDrawer extends StatefulWidget {
  const AppDrawer({Key? key}) : super(key: key);

  @override
  State<AppDrawer> createState() => _AppDrawerState();
}

class _AppDrawerState extends State<AppDrawer> {
  void onLogout() async {
    final result = await showDialog<bool>(
      context: context,
      barrierDismissible: true,
      builder: (BuildContext context) {
        return const ConfirmAlertDialog(
          title: 'Xác nhận',
          message: 'Bạn có chắc chắn muốn đăng xuất?',
          isCapitalizeContent: false,
        );
      },
    );
    if (result == true) {
      AppBloc.appContainerAdminCubit.reset();
      AppBloc.appContainerMemberCubit.reset();
      AppBloc.appContainerSuperAdminCubit.reset();
      await AppBloc.authenticationCubit.onClear();
      await AppBloc.appContainerNewUserCubit.onClear();
    }
  }

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<UserCubit, UserModel?>(
      builder: (context, user) {
        return Drawer(
          backgroundColor: AppColors.primary,
          child: Padding(
            padding: const EdgeInsets.symmetric(horizontal: 16.0),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                const SizedBox(height: 50),
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    CircleAvatar(
                      radius: 63,
                      backgroundColor: AppColors.scaffoldBgColor,
                      child: CircleAvatar(
                        backgroundColor: AppColors.scaffoldBgColor,
                        backgroundImage: NetworkImage(
                            user?.photo != null && user?.photo != ''
                                ? user!.photo!
                                : AppConstant.defaltAvatarUrl),
                        radius: 60,
                      ),
                    ),
                  ],
                ),
                const SizedBox(height: 25),
                Wrap(
                  children: [
                    Text(
                      user?.name ?? '',
                      style: const TextStyle(
                          fontSize: 22,
                          color: Colors.white,
                          fontWeight: FontWeight.bold),
                      overflow: TextOverflow.visible,
                      textAlign: TextAlign.center,
                      maxLines: 2,
                    ),
                  ],
                ),
                const SizedBox(height: 20),
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    SizedBox(
                      width: 100,
                      child: Lable(
                        text:
                            '${user?.totalRE == 0 || user?.totalRE == null ? 0 : user?.totalRE.toString().padLeft(2, '0')} sản phẩm',
                        padding: const EdgeInsets.symmetric(
                            horizontal: 10, vertical: 3),
                        backgroundColor: Colors.white,
                        radius: 8,
                        textStyle: AppBloc.applicationCubit.appTextStyle.small
                            .copyWith(color: Colors.black),
                      ),
                    ),
                    const SizedBox(width: 15),
                    SizedBox(
                      width: 100,
                      child: Lable(
                        text: user?.role == UserRole.superAdmin
                            ? 'Super Admin'
                            : (user?.role == UserRole.admin
                                ? 'Admin'
                                : 'Thành viên'),
                        padding: const EdgeInsets.symmetric(
                            horizontal: 10, vertical: 3),
                        backgroundColor: (user?.role == UserRole.superAdmin ||
                                user?.role == UserRole.admin)
                            ? const Color(0xFFFF0656)
                            : const Color(0xFFFFBC00),
                        radius: 8,
                        textStyle: AppBloc
                            .applicationCubit.appTextStyle.smallBold
                            .copyWith(color: Colors.white),
                      ),
                    ),
                  ],
                ),
                const SizedBox(height: 120),
                Row(
                  children: [
                    Padding(
                      padding: const EdgeInsets.only(left: 20),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          InkWell(
                            onTap: () async {
                              Navigator.pop(context);
                              Navigator.pushNamed(
                                  context, Routes.changeUserInfo,
                                  arguments:
                                      ChangeUserInfoScreenArg(userId: null));
                            },
                            child: const Text(
                              'Hồ sơ cá nhân',
                              style: TextStyle(
                                  fontSize: 20,
                                  color: Colors.white,
                                  fontWeight: FontWeight.bold),
                            ),
                          ),
                          const SizedBox(height: 30),
                          InkWell(
                            onTap: () {
                              Navigator.pop(context);
                              Navigator.pushNamed(
                                  context, Routes.changePassword);
                            },
                            child: const Text(
                              'Thay đổi mật khẩu',
                              style: TextStyle(
                                  fontSize: 20,
                                  color: Colors.white,
                                  fontWeight: FontWeight.bold),
                            ),
                          ),
                          const SizedBox(height: 30),
                          InkWell(
                            onTap: () {
                              Navigator.pop(context);
                              Navigator.pushNamed(context, Routes.feedBack);
                            },
                            child: const Text(
                              'Góp ý',
                              style: TextStyle(
                                  fontSize: 20,
                                  color: Colors.white,
                                  fontWeight: FontWeight.bold),
                            ),
                          ),
                          const SizedBox(height: 30),
                          InkWell(
                            onTap: onLogout,
                            child: const Text(
                              'Đăng xuất',
                              style: TextStyle(
                                  fontSize: 20,
                                  color: Colors.white,
                                  fontWeight: FontWeight.bold),
                            ),
                          ),
                        ],
                      ),
                    ),
                  ],
                ),
              ],
            ),
          ),
        );
      },
    );
  }
}
