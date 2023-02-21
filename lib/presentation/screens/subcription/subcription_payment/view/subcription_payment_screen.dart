import 'package:bds_hoan_mobile/data/models/subcription/subcription_info.dart';
import 'package:bds_hoan_mobile/presentation/screens/subcription/subcription_payment/cubit/subcription_payment_cubit.dart';
import 'package:bds_hoan_mobile/presentation/screens/subcription/subcription_payment/view/subcription_payment_view.dart';
import 'package:flutter/material.dart';
import 'package:flutter/src/foundation/key.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class SubcriptionPaymentScreen extends StatelessWidget {
  const SubcriptionPaymentScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    List<dynamic> args =
        ModalRoute.of(context)!.settings.arguments as List<dynamic>;
    return BlocProvider(
      create: (_) => SubcriptionPaymentCubit(),
      child: SubcriptionPaymentView(
          selectedSubcription: args[0], numMonth: args[1]),
    );
  }
}
