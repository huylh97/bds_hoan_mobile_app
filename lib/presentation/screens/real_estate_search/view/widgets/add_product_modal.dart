import 'package:bds_hoan_mobile/bloc_global/app_bloc.dart';
import 'package:bds_hoan_mobile/configs/_config.dart';
import 'package:bds_hoan_mobile/data/models/real_estate/real_estate_register_param.dart';
import 'package:bds_hoan_mobile/presentation/screens/real_estate_search/cubit/real_estate_search_cubit.dart';
import 'package:flutter/material.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';

class AddProductModal extends StatelessWidget {
  const AddProductModal(
      {Key? key,
      required this.cubit,
      required this.pinPos,
      required this.callback})
      : super(key: key);

  final RealEstateSearchCubit cubit;
  final LatLng pinPos;
  final VoidCallback callback;

  @override
  Widget build(BuildContext context) {
    return Material(
        child: SafeArea(
      top: false,
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: <Widget>[
          ListTile(
            title: Text('Thêm mới',
                style: const TextStyle(
                    color: AppColors.primary,
                    fontWeight: FontWeight.bold,
                    fontFamily: 'OpenSans')),
            leading: Icon(Icons.add, color: AppColors.primary),
            onTap: callback,
          ),
        ],
      ),
    ));
  }
}
