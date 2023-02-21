import 'package:bds_hoan_mobile/bloc_global/app_bloc.dart';
import 'package:bds_hoan_mobile/configs/_config.dart';
import 'package:bds_hoan_mobile/data/enums/api_call_status.dart';
import 'package:bds_hoan_mobile/data/enums/button_loading_status.dart';
import 'package:bds_hoan_mobile/data/enums/gender.dart';
import 'package:bds_hoan_mobile/data/enums/user_role.dart';
import 'package:bds_hoan_mobile/presentation/screens/screens.dart';
import 'package:bds_hoan_mobile/presentation/shared_widgets/buttons/widget.dart';
import 'package:bds_hoan_mobile/presentation/shared_widgets/common/widget.dart';
import 'package:bds_hoan_mobile/presentation/shared_widgets/label/lable.dart';
import 'package:bds_hoan_mobile/presentation/shared_widgets/utils/_utils.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../cubit/member_detail_cubit.dart';
import '../cubit/member_detail_state.dart';
import 'widgets/confirm_reset_password_dialog.dart';
import 'widgets/succes_alert_dialog.dart';

class MemberDetailView extends StatefulWidget {
  final bool? removeFromGroup;
  final int? userId;

  const MemberDetailView({
    Key? key,
    this.removeFromGroup,
    this.userId,
  }) : super(key: key);

  @override
  State<MemberDetailView> createState() => _MemberDetailViewState();
}

class _MemberDetailViewState extends State<MemberDetailView> {
  late final MemberDetailCubit cubit;

  @override
  void initState() {
    super.initState();
    cubit = BlocProvider.of<MemberDetailCubit>(context);
    cubit.getUserInfoByAdmin(widget.userId);
  }

  void removeUser() async {
    final success = await cubit.removeUserFromGroup(widget.userId);
    if (success == true) {
      await showDialog<void>(
        context: context,
        barrierDismissible: false,
        builder: (_) => const SuccessAlertDialog(message: 'Xoá thành viên thành công'),
      );
      Navigator.pop(context);
    }
  }

  void resetUserPassword() async {
    final confirmed = await showDialog<bool>(
      context: context,
      barrierDismissible: false,
      builder: (_) => const ConfirmResetPasswordDialog(),
    );
    if (confirmed == true) {
      final result = await cubit.adminResetUserPassword(widget.userId);
      if (result != null) {
        await showDialog<void>(
          context: context,
          barrierDismissible: false,
          builder: (_) => SuccessAlertDialog(message: 'Mật khẩu mới là $result'),
        );
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.scaffoldBgColor,
      appBar: _buildAppBar(context),
      body: Padding(
        padding: const EdgeInsets.symmetric(horizontal: AppDimension.kScaffoldHorPadding),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const SizedBox(height: 10),
            const Padding(
              padding: EdgeInsets.symmetric(horizontal: 40),
              child: DefaultDivider(),
            ),
            const SizedBox(height: 20),
            const Text(
              'Thông tin thành viên',
              style: TextStyle(fontSize: 24, color: AppColors.primary, fontWeight: FontWeight.w700),
            ),
            const SizedBox(height: 25),
            BlocBuilder<MemberDetailCubit, MemberDetailState>(
              builder: (context, state) {
                if (state.apiCallStatus == ApiCallStatus.loading) {
                  return Padding(
                    padding: EdgeInsets.only(top: MediaQuery.of(context).size.height / 4),
                    child: const Center(
                      child: CircularProgressIndicator(),
                    ),
                  );
                }
                return Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        CircleAvatar(
                          radius: 61,
                          backgroundColor: AppColors.primary,
                          child: CircleAvatar(
                            backgroundColor: AppColors.greyLight,
                            backgroundImage:
                                NetworkImage(state.user?.photo != null && state.user?.photo != '' ? state.user!.photo! : AppConstant.defaltAvatarUrl),
                            radius: 60,
                          ),
                        ),
                      ],
                    ),
                    const SizedBox(height: 30),
                    Wrap(
                      crossAxisAlignment: WrapCrossAlignment.center,
                      children: [
                        _buildTitleMapInfo(title: 'Họ tên: ', info: state.user?.name),
                        const SizedBox(width: 15),
                        SizedBox(
                          width: 100,
                          child: Lable(
                            text: state.user?.role == UserRole.admin ? 'Admin' : 'Thành viên',
                            padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 3),
                            backgroundColor: state.user?.role == UserRole.admin ? const Color(0xFFFF0656) : const Color(0xFFFFBC00),
                            radius: 8,
                            textStyle: AppBloc.applicationCubit.appTextStyle.smallBold.copyWith(color: Colors.white),
                          ),
                        ),
                      ],
                    ),
                    _buildTitleMapInfo(title: 'Số điện thoại: ', info: state.user?.phoneNumber),
                    _buildTitleMapInfo(title: 'Ngày sinh: ', info: state.user?.birthDayFormat()),
                    _buildTitleMapInfo(title: 'Giới tính: ', info: genderEnumToString(state.user?.gender)),
                    _buildTitleMapInfo(title: 'Ngày tham gia: ', info: UtilDateTime.formatDateTime(state.user?.createdAt)),
                    _buildTitleMapInfo(
                        title: 'Số lượng sản phẩm đã đăng: ',
                        info: '${state.user?.totalRE == 0 ? 0 : state.user?.totalRE.toString().padLeft(2, '0')} sản phẩm'),
                  ],
                );
              },
            ),
            const Expanded(child: SizedBox()),
            BlocBuilder<MemberDetailCubit, MemberDetailState>(builder: (context, state) {
              return AppElevatedButton(
                text: 'Xóa khỏi nhóm',
                onPressed: removeUser,
                radius: AppDimension.kButtonBorderRadius,
                loading: state.buttonLoadingStatus == ButtonLoadingStatus.loading,
                disabled: state.buttonLoadingStatus == ButtonLoadingStatus.loading,
              );
            }),
            const SizedBox(height: AppDimension.kTextFormFieldMargin),
          ],
        ),
      ),
    );
  }

  AppBar _buildAppBar(BuildContext context) {
    return AppBar(
      centerTitle: true,
      elevation: 0,
      title: Text(
        'Chi tiết thành viên',
        style: AppBloc.applicationCubit.appTextStyle.mediumBold,
      ),
      actions: [
        Container(
          padding: const EdgeInsets.only(right: AppDimension.kScaffoldHorPadding),
          alignment: Alignment.center,
          child: widget.removeFromGroup == true
              ? PopupMenuButton<String>(
                  onSelected: (String item) {},
                  child: const Icon(Icons.more_vert, color: AppColors.primary, size: 30),
                  shape: const RoundedRectangleBorder(borderRadius: BorderRadius.all(Radius.circular(10))),
                  itemBuilder: (BuildContext context) => <PopupMenuEntry<String>>[
                    PopupMenuItem<String>(
                      value: 'edit',
                      onTap: () async {
                        await Future.delayed(const Duration(milliseconds: 500));
                        Navigator.pushNamed(context, Routes.changeUserInfo, arguments: ChangeUserInfoScreenArg(userId: widget.userId)).then((value) {
                          cubit.getUserInfoByAdmin(widget.userId, enableLoading: false);
                        });
                      },
                      child: const Text(
                        'Sửa thông tin',
                        style: TextStyle(color: AppColors.kTextColor),
                      ),
                    ),
                    PopupMenuItem<String>(
                      value: 'resetPassword',
                      onTap: () async {
                        await Future.delayed(const Duration(milliseconds: 500));
                        resetUserPassword();
                      },
                      child: const Text(
                        'Đặt lại mật khẩu',
                        style: TextStyle(color: AppColors.kTextColor),
                      ),
                    ),
                  ],
                )
              : const SizedBox.shrink(),
        )
      ],
    );
  }

  Widget _buildTitleMapInfo({
    required String? title,
    required String? info,
  }) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 7),
      child: RichText(
        text: TextSpan(
          text: title,
          style: AppBloc.applicationCubit.appTextStyle.normal.copyWith(height: 1.4),
          children: <TextSpan>[
            TextSpan(text: info ?? '-', style: AppBloc.applicationCubit.appTextStyle.normalBold.copyWith(height: 1.4)),
          ],
        ),
      ),
    );
  }
}
