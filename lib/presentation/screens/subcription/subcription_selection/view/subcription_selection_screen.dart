import 'package:bds_hoan_mobile/presentation/screens/subcription/subcription_selection/cubit/subcription_selection_cubit.dart';
import 'package:bds_hoan_mobile/presentation/screens/subcription/subcription_selection/view/subcription_selection_view.dart';
import 'package:flutter/src/foundation/key.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class SubcriptionSelectionScreen extends StatelessWidget {
  const SubcriptionSelectionScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    // final args =
    //     ModalRoute.of(context)!.settings.arguments as ChangeUserInfoScreenArg;
    return BlocProvider(
      create: (_) => SubcriptionSelectionCubit(),
      child: SubcriptionSelectionView(),
    );
  }
}
