import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../cubit/member_detail_cubit.dart';
import 'member_detail_view.dart';

class MemberDetailScreenArguments {
  final bool? removeFromGroup;
  final int? userId;

  MemberDetailScreenArguments({required this.removeFromGroup, required this.userId});
}

class MemberDetailScreen extends StatelessWidget {
  const MemberDetailScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final args = ModalRoute.of(context)!.settings.arguments as MemberDetailScreenArguments;

    return BlocProvider(
      create: (_) => MemberDetailCubit(),
      child: MemberDetailView(
        removeFromGroup: args.removeFromGroup,
        userId: args.userId,
      ),
    );
  }
}
