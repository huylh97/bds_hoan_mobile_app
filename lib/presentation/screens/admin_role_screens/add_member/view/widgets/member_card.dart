import 'package:bds_hoan_mobile/bloc_global/app_bloc.dart';
import 'package:bds_hoan_mobile/configs/_config.dart';
import 'package:bds_hoan_mobile/data/models/user/user_model.dart';
import 'package:bds_hoan_mobile/presentation/shared_widgets/buttons/app_elevated_button.dart';
import 'package:bds_hoan_mobile/presentation/shared_widgets/dialogs/success_alert_dialog.dart';
import 'package:flutter/material.dart';

import '../../cubit/add_member_cubit.dart';

class MemberCard extends StatefulWidget {
  final AddMemberCubit cubit;
  final UserModel? user;
  final bool? isLastMember;

  const MemberCard({
    Key? key,
    required this.cubit,
    required this.user,
    this.isLastMember,
  }) : super(key: key);

  @override
  State<MemberCard> createState() => _MemberCardState();
}

class _MemberCardState extends State<MemberCard> {
  void addUser() async {
    final success = await widget.cubit.addUserToGroup(widget.user?.id);
    await Future.delayed(const Duration(milliseconds: 500));
    if (success == true) {
      await showDialog<void>(
        context: context,
        barrierDismissible: false,
        builder: (_) => const SuccessAlertDialog(
            message: 'Thêm thành viên vào nhóm thành công'),
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 80,
      decoration: BoxDecoration(
        border: widget.isLastMember == true
            ? null
            : const Border(
                bottom: BorderSide(width: 1, color: AppColors.boxBorder),
              ),
      ),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          CircleAvatar(
            backgroundColor: AppColors.greyLight,
            backgroundImage: NetworkImage(
                (widget.user?.photo != null && widget.user?.photo != '')
                    ? widget.user!.photo!
                    : AppConstant.defaltAvatarUrl),
            radius: 24,
          ),
          const SizedBox(width: 12),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Text(
                  widget.user?.name ?? '',
                  style: AppBloc.applicationCubit.appTextStyle.normalBold,
                  overflow: TextOverflow.ellipsis,
                ),
                const SizedBox(height: 3),
                Text(
                  'SĐT ${widget.user?.phoneNumber ?? ''}',
                  style: AppBloc.applicationCubit.appTextStyle.small.copyWith(
                      fontSize: AppBloc
                              .applicationCubit.appTextStyle.small.fontSize! -
                          1),
                  overflow: TextOverflow.ellipsis,
                ),
              ],
            ),
          ),
          const SizedBox(width: 10),
          AppElevatedButton(
            buttonHeight: 30,
            buttonWidth: 30,
            onPressed: () => addUser(),
            elevation: 0,
            text: 'Thêm',
            textStyle: const TextStyle(
                fontSize: 13, color: Colors.white, fontWeight: FontWeight.w500),
            radius: 10,
          )
        ],
      ),
    );
  }
}
