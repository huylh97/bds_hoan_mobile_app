import 'package:bds_hoan_mobile/presentation/screens/subcription/subcription_manage_list/cubit/subcription_manage_list_cubit.dart';
import 'package:bds_hoan_mobile/presentation/screens/subcription/subcription_manage_list/view/subcription_manage_list_view.dart';
import 'package:flutter/src/foundation/key.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class SubcriptionManageListScreen extends StatelessWidget {
  const SubcriptionManageListScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    // final args =
    //     ModalRoute.of(context)!.settings.arguments as ChangeUserInfoScreenArg;
    return BlocProvider(
      create: (_) => SubcriptionManageListCubit(),
      child: const SubcriptionManageListView(),
    );
  }
}
