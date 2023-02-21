import 'package:bds_hoan_mobile/presentation/screens/subcription/subcription_view_info/cubit/subcription_view_info_cubit.dart';
import 'package:bds_hoan_mobile/presentation/screens/subcription/subcription_view_info/view/subcription_view_info_view.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class SubcriptionViewInfoScreen extends StatelessWidget {
  const SubcriptionViewInfoScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final subcriptionId = ModalRoute.of(context)!.settings.arguments as int;
    return BlocProvider(
      create: (_) => SubcriptionViewInfoCubit(),
      child: SubcriptionViewInfoView(subcriptionId: subcriptionId),
    );
  }
}
