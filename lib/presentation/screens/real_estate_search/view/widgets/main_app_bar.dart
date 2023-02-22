import 'package:bds_hoan_mobile/bloc_global/app_bloc.dart';
import 'package:bds_hoan_mobile/bloc_global/application/app_text_style.dart';
import 'package:bds_hoan_mobile/configs/_config.dart';
import 'package:bds_hoan_mobile/data/models/real_estate/real_estate_register_param.dart';
import 'package:flutter/material.dart';

AppBar buildAppBar(BuildContext context, VoidCallback onTapVn2000) {
  return AppBar(
    centerTitle: false,
    elevation: 0,
    leadingWidth: 0,
    backgroundColor: AppColors.appBarColor,
    leading: const SizedBox(),
    title: Row(
      mainAxisAlignment: MainAxisAlignment.start,
      mainAxisSize: MainAxisSize.max,
      children: [
        InkWell(
          splashColor: Colors.white,
          highlightColor: Colors.white,
          onTap: () {
            if (AppBloc.authenticationCubit.isSuperAdmin == true) {
              AppBloc.appContainerSuperAdminCubit.state.scaffoldKey.currentState?.openDrawer();
            } else {
              if (AppBloc.authenticationCubit.isAdminLogin == true) {
                AppBloc.appContainerAdminCubit.state.scaffoldKey.currentState?.openDrawer();
              } else {
                AppBloc.appContainerMemberCubit.state.scaffoldKey.currentState?.openDrawer();
              }
            }
          },
          child: const Icon(Icons.menu, color: Colors.white),
        ),
        const Expanded(child: SizedBox()),
        Text(
          'Quản lý BĐS',
          style: TextStyle(
            color: Colors.white,
            fontSize: AppTextStyle.largeFontSize,
            fontWeight: FontWeight.w600,
          ),
        ),
        const Expanded(child: SizedBox()),
        AppBloc.authenticationCubit.isSuperAdmin == true
            ? const SizedBox(width: 8)
            : InkWell(
                onTap: () {
                  Navigator.pushNamed(
                    context,
                    Routes.realEstateRegister,
                    arguments: RealEstateRegEditParam(
                      processMode: RealEstateProcessMode.register,
                      inputType: RealEstateInputType.vn2000,
                    ),
                  ).then((value) {
                    onTapVn2000();
                  });
                },
                child: Text(
                  'Thêm mới',
                  style: TextStyle(
                    color: Colors.white,
                    fontSize: AppTextStyle.normalFontSize,
                    fontWeight: FontWeight.w500,
                  ),
                ),
              )
      ],
    ),
  );
}
