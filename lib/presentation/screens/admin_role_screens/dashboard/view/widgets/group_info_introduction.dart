import 'package:bds_hoan_mobile/configs/_config.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../cubit/dash_board_cubit.dart';
import '../../cubit/dash_board_state.dart';
import 'starter_package.dart';

class GroupInfoIntroduction extends StatefulWidget {
  const GroupInfoIntroduction({Key? key}) : super(key: key);

  @override
  State<GroupInfoIntroduction> createState() => _GroupInfoIntroductionState();
}

class _GroupInfoIntroductionState extends State<GroupInfoIntroduction> {
  late final DashBoardCubit cubit;

  final kTextStyle = const TextStyle(
    fontSize: 23,
    color: Colors.black,
    fontWeight: FontWeight.w700,
  );

  @override
  void initState() {
    super.initState();
    cubit = BlocProvider.of<DashBoardCubit>(context);
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        // const StarterPackage(),
        const SizedBox(height: 25),
        Text(
          'Bạn chưa là thành viên của bất kỳ nhóm nào.',
          style: kTextStyle,
        ),
        Row(
          children: [
            Text(
              'Hãy ',
              style: kTextStyle,
            ),
            InkWell(
              highlightColor: Colors.white,
              splashColor: Colors.white,
              onTap: () => cubit.selectGroupInfoType(GroupInfoType.form),
              child: Text(
                'tạo đội nhóm',
                style: kTextStyle.copyWith(
                  color: AppColors.primary,
                  decoration: TextDecoration.underline,
                ),
              ),
            ),
            Text(
              ' đầu tiên',
              style: kTextStyle,
            ),
          ],
        ),
        const SizedBox(height: 8),
        Image.asset(AppImages.createNewGroup, width: 260)
      ],
    );
  }
}
