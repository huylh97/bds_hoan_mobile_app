import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../cubit/real_estate_search_cubit.dart';
import 'real_estate_search_view.dart';

class RealEstateSearchScreen extends StatelessWidget {
  const RealEstateSearchScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (_) => RealEstateSearchCubit(),
      child: const RealEstateSearchView(),
    );
  }
}
