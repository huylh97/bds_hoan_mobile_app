import 'package:bds_hoan_mobile/presentation/screens/subcription/subcription_pending/cubit/subcription_pending_cubit.dart';
import 'package:bds_hoan_mobile/presentation/screens/subcription/subcription_pending/view/subcription_pending_view.dart';
import 'package:flutter/material.dart';
import 'package:flutter/src/foundation/key.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class SubcriptionPendingScreen extends StatelessWidget {
  const SubcriptionPendingScreen({Key? key, required this.isSubcription})
      : super(key: key);

  final bool isSubcription;

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (_) => SubcriptionPendingCubit(),
      child: SubcriptionPendingView(isSubcription: isSubcription),
    );
  }
}
