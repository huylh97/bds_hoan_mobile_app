import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../cubit/change_use_info_cubit.dart';
import 'change_user_info_view.dart';

class ChangeUserInfoScreenArg {
  // id == null : get my info
  final int? userId;

  ChangeUserInfoScreenArg({required this.userId});
}

class ChangeUserInfoScreen extends StatelessWidget {
  const ChangeUserInfoScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final args = ModalRoute.of(context)!.settings.arguments as ChangeUserInfoScreenArg;
    return BlocProvider(
      create: (_) => ChangeUserInfoCubit(),
      child: ChangeUserInfoView(
        userId: args.userId,
      ),
    );
  }
}
