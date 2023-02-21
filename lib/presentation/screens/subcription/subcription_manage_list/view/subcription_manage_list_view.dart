import 'package:bds_hoan_mobile/bloc_global/app_bloc.dart';
import 'package:bds_hoan_mobile/configs/_config.dart';
import 'package:bds_hoan_mobile/data/enums/api_call_status.dart';
import 'package:bds_hoan_mobile/presentation/app_container/widgets/app_drawer.dart';
import 'package:bds_hoan_mobile/presentation/screens/subcription/subcription_manage_list/cubit/subcription_manage_list_cubit.dart';
import 'package:bds_hoan_mobile/presentation/screens/subcription/subcription_manage_list/view/widgets/widget_subcription_user_list_view.dart';
import 'package:bds_hoan_mobile/presentation/shared_widgets/common/widget.dart';
import 'package:carousel_slider/carousel_slider.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class SubcriptionManageListView extends StatefulWidget {
  const SubcriptionManageListView({
    Key? key,
  }) : super(key: key);

  @override
  State<SubcriptionManageListView> createState() =>
      _SubcriptionManageListViewState();
}

class _SubcriptionManageListViewState extends State<SubcriptionManageListView> {
  late final SubcriptionManageListCubit cubit;

  @override
  void initState() {
    super.initState();
    cubit = BlocProvider.of<SubcriptionManageListCubit>(context);
    cubit.getListSubcription();
  }

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        FocusScope.of(context).unfocus();
      },
      child: Scaffold(
        backgroundColor: AppColors.scaffoldBgColor,
        drawer: const AppDrawer(),
        appBar: _buildAppBar(context),
        body: Padding(
          padding: const EdgeInsets.symmetric(
              horizontal: AppDimension.kScaffoldHorPadding),
          child: BlocBuilder<SubcriptionManageListCubit,
              SubcriptionManageListState>(builder: (context, state) {
            if (state.apiCallStatus == ApiCallStatus.loading) {
              return Padding(
                padding: EdgeInsets.only(
                    top: MediaQuery.of(context).size.height / 4),
                child: const Center(
                  child: CircularProgressIndicator(),
                ),
              );
            }

            return Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  const SizedBox(height: 15),
                  const Padding(
                      padding: EdgeInsets.symmetric(horizontal: 40),
                      child: DefaultDivider()),
                  const SizedBox(height: 30),
                  Row(
                    children: <Widget>[
                      Material(
                        color: Colors.transparent,
                        child: InkWell(
                          borderRadius:
                              const BorderRadius.all(Radius.circular(4.0)),
                          onTap: () {
                            cubit.filterNotApprovedDataOnly(
                              enableLoading: true,
                            );
                          },
                          child: Padding(
                            padding: const EdgeInsets.all(8.0),
                            child: Row(
                              children: <Widget>[
                                Icon(
                                  state.notAprrovedOnly ?? false
                                      ? Icons.check_box
                                      : Icons.check_box_outline_blank,
                                  color: state.notAprrovedOnly ?? false
                                      ? AppColors.primary
                                      : Colors.grey.withOpacity(0.6),
                                ),
                                const SizedBox(
                                  width: 4,
                                ),
                                Text(
                                  'Chưa duyệt',
                                ),
                              ],
                            ),
                          ),
                        ),
                      ),
                    ],
                  ),
                  Expanded(
                      child: ListView.builder(
                    itemCount: state.displayDataList!.length,
                    padding: const EdgeInsets.only(top: 8),
                    scrollDirection: Axis.vertical,
                    itemBuilder: (BuildContext context, int index) {
                      return WidgetSubcriptionUserListView(
                        cubit: cubit,
                        callback: () {},
                        data: state.displayDataList![index],
                      );
                    },
                  ))
                ]);
          }),
        ),
      ),
    );
  }

  // if (state.displayDataList != null) {
  //                   return Expanded(
  //                       child: ListView.builder(
  //                     itemCount: state.displayDataList!.length,
  //                     padding: const EdgeInsets.only(top: 8),
  //                     scrollDirection: Axis.vertical,
  //                     itemBuilder: (BuildContext context, int index) {
  //                       return WidgetSubcriptionUserListView(
  //                         cubit: cubit,
  //                         callback: () {},
  //                         data: state.displayDataList![index],
  //                       );
  //                     },
  //                   ));
  //                 }

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
            onTap: () {
              AppBloc.appContainerSuperAdminCubit.state.scaffoldKey.currentState
                  ?.openDrawer();
            },
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
            'Quản lý đại lý',
            style: AppBloc.applicationCubit.appTextStyle.mediumBold,
          ),
          const Expanded(child: SizedBox()),
          Text('        ')
        ],
      ),
    );
  }
}
