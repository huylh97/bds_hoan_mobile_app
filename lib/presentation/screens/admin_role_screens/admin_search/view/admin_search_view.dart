import 'package:bds_hoan_mobile/bloc_global/app_bloc.dart';
import 'package:bds_hoan_mobile/configs/_config.dart';
import 'package:bds_hoan_mobile/presentation/shared_widgets/common/widget.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../cubit/admin_search_cubit.dart';

class AdminSearchView extends StatefulWidget {
  const AdminSearchView({
    Key? key,
  }) : super(key: key);

  @override
  State<AdminSearchView> createState() => _AdminSearchViewState();
}

class _AdminSearchViewState extends State<AdminSearchView> {
  late final AdminSearchCubit cubit;

  @override
  void initState() {
    cubit = BlocProvider.of<AdminSearchCubit>(context);
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        FocusScope.of(context).unfocus();
      },
      child: Scaffold(
        backgroundColor: AppColors.scaffoldBgColor,
        appBar: _buildAppBar(context),
        body: Padding(
          padding: const EdgeInsets.symmetric(horizontal: AppDimension.kScaffoldHorPadding),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: const [
              SizedBox(height: 10),
              Padding(
                padding: EdgeInsets.symmetric(horizontal: 40),
                child: DefaultDivider(),
              ),
              SizedBox(height: 20),
            ],
          ),
        ),
      ),
    );
  }

  AppBar _buildAppBar(BuildContext context) {
    return AppBar(
      centerTitle: false,
      elevation: 0,
      leadingWidth: 0,
      leading: const SizedBox(),
      title: Row(
        mainAxisAlignment: MainAxisAlignment.start,
        mainAxisSize: MainAxisSize.max,
        children: [
          InkWell(
            splashColor: Colors.white,
            highlightColor: Colors.white,
            onTap: () => AppBloc.appContainerAdminCubit.state.scaffoldKey.currentState?.openDrawer(),
            child: Container(
              padding: const EdgeInsets.all(8),
              decoration: BoxDecoration(
                border: Border.all(color: AppColors.boxBorder),
                borderRadius: BorderRadius.circular(12),
              ),
              child: const Icon(Icons.menu, color: Color(0xFF374957)),
            ),
          ),
          const Expanded(child: SizedBox()),
          Text(
            'Quản lý BDS',
            style: AppBloc.applicationCubit.appTextStyle.mediumBold,
          ),
          const Expanded(child: SizedBox()),
          InkWell(
            onTap: () {
              Navigator.pushNamed(context, Routes.addMember);
            },
            child: Text(
              'Thêm',
              style: AppBloc.applicationCubit.appTextStyle.normalBold.copyWith(
                color: AppColors.primary,
                decoration: TextDecoration.underline,
              ),
            ),
          )
        ],
      ),
    );
  }
}
