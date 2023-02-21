import 'package:bds_hoan_mobile/presentation/screens/supper_admin_role_screens/export_excel/cubit/export_excel_cubit.dart';
import 'package:flutter/material.dart';
import 'package:flutter/src/foundation/key.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import 'export_excel__view.dart';

class ExportExcelScreen extends StatelessWidget {
  const ExportExcelScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (_) => ExportExcelCubit(),
      child: ExportExcelView(),
    );
  }
}
