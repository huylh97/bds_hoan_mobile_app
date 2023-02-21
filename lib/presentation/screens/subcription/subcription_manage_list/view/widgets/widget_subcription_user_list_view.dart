import 'package:bds_hoan_mobile/bloc_global/app_bloc.dart';
import 'package:bds_hoan_mobile/configs/_config.dart';
import 'package:bds_hoan_mobile/data/models/real_estate/real_estate_data_model.dart';
import 'package:bds_hoan_mobile/data/models/subcription/subscription_user_data.dart';
import 'package:bds_hoan_mobile/presentation/screens/real_estate_view_info/view/real_estate_view_info_screen.dart';
import 'package:bds_hoan_mobile/presentation/screens/subcription/subcription_manage_list/cubit/subcription_manage_list_cubit.dart';
import 'package:bds_hoan_mobile/presentation/shared_widgets/buttons/widget.dart';
import 'package:bds_hoan_mobile/presentation/shared_widgets/utils/_utils.dart';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';

class WidgetSubcriptionUserListView extends StatelessWidget {
  const WidgetSubcriptionUserListView({Key? key, required this.cubit, required this.data, this.callback}) : super(key: key);

  final SubcriptionManageListCubit cubit;
  final VoidCallback? callback;
  final SubscriptionUserData data;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(left: 16, right: 16, top: 8, bottom: 16),
      child: InkWell(
        splashColor: Colors.transparent,
        // onTap: callback,
        child: Container(
          decoration: BoxDecoration(
            borderRadius: const BorderRadius.all(Radius.circular(16.0)),
            boxShadow: <BoxShadow>[
              BoxShadow(
                color: Colors.grey.withOpacity(0.6),
                offset: const Offset(4, 4),
                blurRadius: 16,
              ),
            ],
          ),
          child: ClipRRect(
            borderRadius: const BorderRadius.all(Radius.circular(16.0)),
            child: Stack(
              children: <Widget>[
                Column(
                  children: <Widget>[
                    Container(
                      color: AppColors.white,
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: <Widget>[
                          Expanded(
                            child: Container(
                              child: Padding(
                                padding: const EdgeInsets.all(8),
                                child: Column(
                                  mainAxisAlignment: MainAxisAlignment.center,
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: <Widget>[
                                    Padding(
                                        padding: const EdgeInsets.all(4),
                                        child: Text('${data.user!.name} - ${data.phone ?? ''}',
                                            textAlign: TextAlign.left,
                                            style: AppBloc.applicationCubit.appTextStyle.extraBoldPrimaryColor.copyWith(fontSize: 18))),
                                    const SizedBox(
                                      height: AppDimension.kSizedBoxHeight,
                                    ),
                                    Padding(
                                        padding: const EdgeInsets.all(4),
                                        child: Row(children: [
                                          const Icon(Icons.info, size: 22),
                                          const SizedBox(width: 5),
                                          Text(getDisplayStatus(data.status!) ?? '',
                                              textAlign: TextAlign.left, style: AppBloc.applicationCubit.appTextStyle.normalBold)
                                        ])),
                                    // const SizedBox(
                                    //   height: AppDimension.kSizedBoxHeight,
                                    // ),
                                    // Padding(
                                    //     padding: const EdgeInsets.all(4),
                                    //     child: Row(
                                    //       crossAxisAlignment:
                                    //           CrossAxisAlignment.center,
                                    //       mainAxisAlignment:
                                    //           MainAxisAlignment.start,
                                    //       children: <Widget>[
                                    //         Expanded(
                                    //             child: Row(children: [
                                    //           Image.asset(AppIcons.location,
                                    //               width: 17),
                                    //           const SizedBox(width: 5),
                                    //           Text(
                                    //             '${data.subscriptionDetails!.name ?? ''}',
                                    //             style: AppBloc.applicationCubit
                                    //                 .appTextStyle.normal,
                                    //           )
                                    //         ])),
                                    //         Expanded(
                                    //             child: Row(
                                    //           children: [
                                    //             Image.asset(AppIcons.comission,
                                    //                 width: 17),
                                    //             const SizedBox(width: 5),
                                    //             Text(
                                    //               '${UtilCommon.formatCommaInt(data.subscriptionDetails!.price)} đ/năm',
                                    //               style: AppBloc
                                    //                   .applicationCubit
                                    //                   .appTextStyle
                                    //                   .normal,
                                    //             )
                                    //           ],
                                    //         )),
                                    //       ],
                                    //     )),
                                    // Padding(
                                    //     padding: const EdgeInsets.only(
                                    //         left: 4,
                                    //         right: 4,
                                    //         top: 4,
                                    //         bottom: 4),
                                    //     child: Row(
                                    //       crossAxisAlignment:
                                    //           CrossAxisAlignment.center,
                                    //       mainAxisAlignment:
                                    //           MainAxisAlignment.start,
                                    //       children: <Widget>[
                                    //         Expanded(
                                    //             child: Row(children: [
                                    //           Image.asset(AppIcons.clock,
                                    //               width: 17),
                                    //           const SizedBox(width: 5),
                                    //           Text(
                                    //             '${data.quantity} năm',
                                    //             style: AppBloc.applicationCubit
                                    //                 .appTextStyle.normal,
                                    //           )
                                    //         ])),
                                    //         Expanded(
                                    //             child: Row(children: [
                                    //           // Image.asset(AppIcons.area, width: 17),
                                    //           // const SizedBox(width: 5),
                                    //           Text(
                                    //             'Tổng cộng: ${UtilCommon.formatCommaInt(data.total)} đ',
                                    //             style: AppBloc.applicationCubit
                                    //                 .appTextStyle.normal,
                                    //           )
                                    //         ]))
                                    //       ],
                                    //     )),
                                    Padding(
                                        padding: const EdgeInsets.all(4),
                                        child: Row(
                                          crossAxisAlignment: CrossAxisAlignment.center,
                                          mainAxisAlignment: MainAxisAlignment.start,
                                          children: <Widget>[
                                            Expanded(
                                                child: Row(children: [
                                              Image.asset(AppIcons.group, width: 17),
                                              const SizedBox(width: 5),
                                              Text(
                                                '${data.currentMembers ?? ''}/${data.maxMembers ?? ''} thành viên',
                                                style: AppBloc.applicationCubit.appTextStyle.normal,
                                              )
                                            ])),
                                          ],
                                        )),
                                    Padding(
                                        padding: const EdgeInsets.all(4),
                                        child: Row(
                                          children: [
                                            Expanded(
                                                child: AppElevatedButton(
                                              text: 'Xem chi tiết',
                                              onPressed: () {
                                                Navigator.pushNamed(context, Routes.subcriptionViewInfo, arguments: data.id).then((value) {
                                                  cubit.getListSubcription();
                                                  // AppBloc
                                                  //     .appContainerSuperAdminCubit
                                                  //     .getNumNotApprovedSubscriptionList();
                                                });
                                              },
                                              radius: AppDimension.kButtonBorderRadius,
                                              // loading: state.apiCallStatus == ApiCallStatus.loading,
                                              // disabled: state.apiCallStatus == ApiCallStatus.loading,
                                            )),
                                            // WidgetSpacer(width: 20),
                                          ],
                                        ))
                                  ],
                                ),
                              ),
                            ),
                          ),
                        ],
                      ),
                    ),
                  ],
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }

  static String? getDisplayStatus(int status) {
    if (status == 0) {
      // New
      return 'Chưa duyệt';
    } else if (status == 1) {
      // Đã duyệt
      return 'Đã duyệt/Đang hữu hiệu';
    } else if (status == 2) {
      // Đang bị khóa
      return 'Đang bị khóa';
    }
    return null;
  }
}
