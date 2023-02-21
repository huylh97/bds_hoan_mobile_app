import 'package:bds_hoan_mobile/data/models/real_estate/real_estate_filter_model.dart';
import 'package:bds_hoan_mobile/presentation/screens/search_filter/cubit/search_filters_cubit.dart';
import 'package:bds_hoan_mobile/presentation/screens/search_filter/view/search_filters_view.dart';
import 'package:flutter/material.dart';
import 'package:flutter/src/foundation/key.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class SearchFiltersScreen extends StatelessWidget {
  const SearchFiltersScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    RealEstateFilterModel? filteredData =
        ModalRoute.of(context)!.settings.arguments as RealEstateFilterModel?;
    return BlocProvider(
      create: (_) => SearchFiltersCubit(),
      child: SearchFiltersView(
        filteredData: filteredData,
      ),
    );
  }
}
