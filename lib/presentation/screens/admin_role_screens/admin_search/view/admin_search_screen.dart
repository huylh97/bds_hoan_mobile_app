import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../cubit/admin_search_cubit.dart';
import 'admin_search_view.dart';

class AdminSearchScreen extends StatelessWidget {
  const AdminSearchScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (_) => AdminSearchCubit(),
      child: const AdminSearchView(),
    );
  }
}
