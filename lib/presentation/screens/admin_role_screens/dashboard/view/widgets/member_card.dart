import 'package:bds_hoan_mobile/bloc_global/app_bloc.dart';
import 'package:bds_hoan_mobile/configs/_config.dart';
import 'package:bds_hoan_mobile/data/models/group/group_model.dart';
import 'package:bds_hoan_mobile/presentation/screens/screens.dart';
import 'package:flutter/material.dart';

import '../../cubit/dash_board_cubit.dart';

class MemberCard extends StatelessWidget {
  final DashBoardCubit cubit;
  final Member? user;
  final bool? isLastMember;

  const MemberCard({
    Key? key,
    required this.cubit,
    required this.user,
    this.isLastMember,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: () {
        Navigator.pushNamed(
          context,
          Routes.memberDetail,
          arguments: MemberDetailScreenArguments(
            removeFromGroup: true,
            userId: user?.id,
          ),
        ).then((value) => cubit.fetchGroupInfo(enableLoading: false));
      },
      child: Container(
        height: 80,
        decoration: const BoxDecoration(
          border: Border(
            bottom: BorderSide(width: 1, color: AppColors.boxBorder),
          ),
        ),
        child: Row(
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            CircleAvatar(
              backgroundColor: AppColors.greyLight,
              backgroundImage: NetworkImage(user?.photo != null && user?.photo != '' ? user!.photo! : AppConstant.defaltAvatarUrl),
              radius: 24,
            ),
            const SizedBox(width: 12),
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Text(
                    user?.name ?? '-',
                    style: AppBloc.applicationCubit.appTextStyle.normalBold,
                    overflow: TextOverflow.visible,
                  ),
                  const SizedBox(height: 3),
                  Text(
                    'SĐT ${user?.phoneNumber ?? ''}',
                    style: AppBloc.applicationCubit.appTextStyle.small.copyWith(fontSize: AppBloc.applicationCubit.appTextStyle.small.fontSize! - 1),
                    overflow: TextOverflow.ellipsis,
                  ),
                ],
              ),
            ),
            const SizedBox(width: 10),
            Container(
              padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 3),
              decoration: BoxDecoration(
                color: Colors.white,
                border: Border.all(color: const Color(0xFF979797)),
                borderRadius: BorderRadius.circular(8),
              ),
              child: Text(
                '${user?.totalRE ?? 0} sản phẩm',
                style: AppBloc.applicationCubit.appTextStyle.small.copyWith(fontSize: AppBloc.applicationCubit.appTextStyle.small.fontSize! - 2),
              ),
            ),
            const SizedBox(width: 10),
            const Icon(Icons.arrow_forward, size: 18)
          ],
        ),
      ),
    );
  }
}
