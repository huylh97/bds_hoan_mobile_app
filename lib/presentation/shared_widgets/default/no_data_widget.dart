import 'package:bds_hoan_mobile/bloc_global/app_bloc.dart';
import 'package:flutter/material.dart';

class NoDataWidget extends StatelessWidget {
  const NoDataWidget({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Text('No Data To Display', style: AppBloc.applicationCubit.appTextStyle.normal);
  }
}
