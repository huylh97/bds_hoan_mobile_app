import 'package:bds_hoan_mobile/configs/_config.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../cubit/group_info_cubit.dart';

class GroupInfoIntroduction extends StatefulWidget {
  const GroupInfoIntroduction({Key? key}) : super(key: key);

  @override
  State<GroupInfoIntroduction> createState() => _GroupInfoIntroductionState();
}

class _GroupInfoIntroductionState extends State<GroupInfoIntroduction> {
  late final GroupInfoCubit cubit;

  final kTextStyle = const TextStyle(
    fontSize: 23,
    color: AppColors.kTextColor,
    fontWeight: FontWeight.w700,
    height: 1.4,
  );

  @override
  void initState() {
    super.initState();
    cubit = BlocProvider.of<GroupInfoCubit>(context);
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Text(
          'Bạn chưa là thành viên của bất kỳ nhóm nào.',
          style: kTextStyle,
        ),
        RichText(
          text: TextSpan(
            text: 'Hãy liên hệ với ',
            style: kTextStyle,
            children: <TextSpan>[
              TextSpan(text: 'Admin', style: kTextStyle.copyWith(color: AppColors.primary)),
              const TextSpan(text: ' để được thêm vào nhóm.'),
            ],
          ),
        ),
        const SizedBox(height: 25),
        Image.asset(AppImages.createNewGroup, width: 260)
      ],
    );
  }
}
