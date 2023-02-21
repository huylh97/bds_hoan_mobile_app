import 'package:bds_hoan_mobile/presentation/screens/member_role_screens/invite_group_acception/cubit/invite_group_acception_cubit.dart';
import 'package:bds_hoan_mobile/presentation/screens/member_role_screens/invite_group_acception/view/invite_group_acception_view.dart';
import 'package:flutter/src/foundation/key.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class InviteGroupAcceptionScreen extends StatelessWidget {
  const InviteGroupAcceptionScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (_) => InviteGroupAcceptionCubit(),
      child: const InviteGroupAcceptionView(),
    );
  }
}
