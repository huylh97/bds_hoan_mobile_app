import 'package:bds_hoan_mobile/data/models/real_estate/real_estate_data_model.dart';
import 'package:bds_hoan_mobile/presentation/screens/real_estate_view_info/cubit/real_estate_view_info_cubit.dart';
import 'package:bds_hoan_mobile/presentation/screens/real_estate_view_info/view/real_estate_view_info_view.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class RealEstateViewInfoScreen extends StatelessWidget {
  const RealEstateViewInfoScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final productId = ModalRoute.of(context)!.settings.arguments as int;
    return BlocProvider(
      create: (_) => RealEstateViewInfoCubit(),
      child: RealEstateViewInfoView(productId: productId),
    );
  }
}
