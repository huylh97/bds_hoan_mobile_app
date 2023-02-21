import 'package:bds_hoan_mobile/bloc_global/app_bloc.dart';
import 'package:bds_hoan_mobile/configs/app_colors.dart';
import 'package:bds_hoan_mobile/configs/app_dimension.dart';
import 'package:bds_hoan_mobile/configs/app_icons.dart';
import 'package:bds_hoan_mobile/data/enums/api_call_status.dart';
import 'package:bds_hoan_mobile/data/enums/status.dart';
import 'package:bds_hoan_mobile/data/models/subcription/subscription_user_data.dart';
import 'package:bds_hoan_mobile/presentation/screens/subcription/subcription_view_info/cubit/subcription_view_info_cubit.dart';
import 'package:bds_hoan_mobile/presentation/shared_widgets/buttons/widget.dart';
import 'package:bds_hoan_mobile/presentation/shared_widgets/common/heroview.dart';
import 'package:bds_hoan_mobile/presentation/shared_widgets/dialogs/widget.dart';
import 'package:bds_hoan_mobile/presentation/shared_widgets/utils/util_common.dart';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:photo_view/photo_view.dart';

class SubcriptionViewInfoView extends StatefulWidget {
  const SubcriptionViewInfoView({Key? key, required this.subcriptionId}) : super(key: key);

  final int subcriptionId;

  get helperText => null;

  @override
  _SubcriptionViewInfoViewState createState() => _SubcriptionViewInfoViewState();
}

class _SubcriptionViewInfoViewState extends State<SubcriptionViewInfoView> {
  late final SubcriptionViewInfoCubit cubit;
  String? displayImg;
  String? saledPriceStr;
  final TextEditingController _salePriceInputController = TextEditingController();
  final _formKey = GlobalKey<FormState>();

  @override
  void initState() {
    super.initState();

    cubit = BlocProvider.of<SubcriptionViewInfoCubit>(context);
    cubit.getSubcriptionDetailById(subcriptionId: widget.subcriptionId);
  }

  void onUpdateStatus(int status, int subcriptiontId) async {
    bool? success = false;

    if (status == 0) {
      success = await cubit.confirm(
        subcriptionId: subcriptiontId,
      );
    } else if (status == 1) {
      success = await cubit.lock(subcriptionId: subcriptiontId);
    } else if (status == 2) {
      success = await cubit.unlock(subcriptionId: subcriptiontId);
    }

    await Future.delayed(const Duration(milliseconds: 500));
    if (success == true) {
      await showDialog<void>(
        context: context,
        barrierDismissible: false,
        builder: (_) => const SuccessAlertDialog(message: 'Cập nhật trạng thái thành công'),
      );
      await Future.delayed(const Duration(milliseconds: 500));
      Navigator.pop(context);
    }
  }

  @override
  Widget build(BuildContext context) {
    final double tempHeight = MediaQuery.of(context).size.height - (MediaQuery.of(context).size.width / 1.2) + 24.0;
    return Container(
      // color: AppTheme.nearlyWhite,
      child: Scaffold(
          backgroundColor: Colors.white,
          body: BlocBuilder<SubcriptionViewInfoCubit, SubcriptionViewInfoState>(builder: (context, state) {
            if (state.apiCallStatus == ApiCallStatus.loading) {
              return const Center(
                child: CircularProgressIndicator(),
              );
            }

            return Column(
              children: <Widget>[
                Container(
                    color: Colors.grey,
                    height: (MediaQuery.of(context).size.width / 1.4),
                    child: Stack(
                      children: [
                        Stack(children: [
                          Positioned(
                              left: 0,
                              right: 0,
                              bottom: 0,
                              top: 0,
                              child: ClipRect(
                                  child: CachedNetworkImage(
                                imageUrl: displayImg == null
                                    ? ((state.subscriptionUserData!.images != null && state.subscriptionUserData!.images!.isNotEmpty)
                                        ? state.subscriptionUserData!.images![0].url!
                                        : '')
                                    : displayImg!,
                                imageBuilder: (context, imageProvider) => GestureDetector(
                                    onTap: () {
                                      Navigator.push(
                                          context,
                                          MaterialPageRoute(
                                            builder: (context) =>
                                                HeroPhotoViewRouteWrapper(minScale: PhotoViewComputedScale.contained, imageProvider: imageProvider),
                                          ));
                                    },
                                    child: PhotoView(
                                      // initialScale: 2,
                                      imageProvider: imageProvider,
                                    )),
                                placeholder: (context, url) => const Center(child: CircularProgressIndicator()),
                                errorWidget: (context, url, error) => Image.asset(
                                  'assets/images/no-image.png',
                                  fit: BoxFit.cover,
                                ),
                              ))),
                          Positioned(
                              left: 10,
                              right: 10,
                              bottom: 10,
                              child: SizedBox(
                                height: 80,
                                child: ListView.separated(
                                    scrollDirection: Axis.horizontal,
                                    itemBuilder: (context, index) {
                                      return Container(
                                        height: 80,
                                        width: 80,
                                        decoration: BoxDecoration(
                                          border: Border.all(color: AppColors.boxBorder),
                                          borderRadius: BorderRadius.circular(12),
                                          // color: AppColors.white,
                                        ),
                                        margin: const EdgeInsets.only(left: 0, right: 0),
                                        child: ClipRRect(
                                            borderRadius: BorderRadius.circular(12),
                                            child: InkWell(
                                                onTap: () {
                                                  setState(() {
                                                    displayImg = state.subscriptionUserData!.images![index].url!;
                                                  });
                                                },
                                                child: CachedNetworkImage(
                                                  imageUrl: state.subscriptionUserData!.images![index].url!,
                                                  imageBuilder: (context, imageProvider) => Container(
                                                    decoration: BoxDecoration(
                                                      image: DecorationImage(
                                                        image: imageProvider,
                                                        fit: BoxFit.cover,
                                                      ),
                                                    ),
                                                  ),
                                                  placeholder: (context, url) => const Center(child: CircularProgressIndicator()),
                                                  errorWidget: (context, url, error) => Image.asset(
                                                    'assets/images/no-image.png',
                                                    fit: BoxFit.cover,
                                                  ),
                                                ))),
                                      );
                                    },
                                    separatorBuilder: (context, index) {
                                      return const SizedBox(width: 12);
                                    },
                                    itemCount: state.subscriptionUserData!.images!.length),
                              ))
                        ]),
                        Positioned(
                            left: MediaQuery.of(context).padding.left + 20,
                            top: MediaQuery.of(context).padding.top + 10,
                            child: GestureDetector(
                              onTap: () {
                                Navigator.pop(context);
                              },
                              child: Container(
                                padding: const EdgeInsets.all(8),
                                decoration: BoxDecoration(
                                  border: Border.all(color: AppColors.boxBorder),
                                  borderRadius: BorderRadius.circular(10),
                                  color: AppColors.white,
                                ),
                                child: const Icon(
                                  Icons.arrow_back_ios_outlined,
                                  color: AppColors.kTextColor,
                                ),
                              ),
                            )),
                      ],
                    )),
                Expanded(
                  child: SingleChildScrollView(
                      child: Padding(
                          padding: const EdgeInsets.only(left: 12, right: 12, bottom: 8, top: 30),
                          child: Column(
                            mainAxisAlignment: MainAxisAlignment.center,
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: <Widget>[
                              _basicInfo(state.subscriptionUserData!),
                              const SizedBox(
                                height: AppDimension.kSizedBoxHeight,
                              ),
                              _button(state)
                            ],
                          ))),
                ),
              ],
            );
          })),
    );
  }

  Widget _basicInfo(SubscriptionUserData data) {
    return Padding(
      padding: const EdgeInsets.only(left: 0, top: 0, bottom: 0),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: <Widget>[
          Padding(
              padding: const EdgeInsets.all(4),
              child: Text('${data.user!.name} - ${data.phone ?? ''}',
                  textAlign: TextAlign.left, style: AppBloc.applicationCubit.appTextStyle.extraBoldPrimaryColor)),
          const SizedBox(
            height: AppDimension.kSizedBoxHeight,
          ),
          Padding(
              padding: const EdgeInsets.all(4),
              child: Row(children: [
                const Icon(Icons.info, size: 22),
                const SizedBox(width: 5),
                Text(getDisplayStatus(data.status!) ?? '', textAlign: TextAlign.left, style: AppBloc.applicationCubit.appTextStyle.normalBold)
              ])),
          const SizedBox(
            height: AppDimension.kSizedBoxHeight,
          ),
          Padding(
              padding: const EdgeInsets.all(4),
              child: Row(
                crossAxisAlignment: CrossAxisAlignment.center,
                mainAxisAlignment: MainAxisAlignment.start,
                children: <Widget>[
                  Expanded(
                      child: Row(children: [
                    Image.asset(AppIcons.location, width: 17),
                    const SizedBox(width: 5),
                    Text(
                      '${data.subscriptionDetails!.name ?? ''}',
                      style: AppBloc.applicationCubit.appTextStyle.normal,
                    )
                  ])),
                  Expanded(
                      child: Row(
                    children: [
                      Image.asset(AppIcons.comission, width: 17),
                      const SizedBox(width: 5),
                      Text(
                        '${UtilCommon.formatCommaInt(data.subscriptionDetails!.price)} đ/năm',
                        style: AppBloc.applicationCubit.appTextStyle.normal,
                      )
                    ],
                  )),
                ],
              )),
          Padding(
              padding: const EdgeInsets.only(left: 4, right: 4, top: 4, bottom: 4),
              child: Row(
                crossAxisAlignment: CrossAxisAlignment.center,
                mainAxisAlignment: MainAxisAlignment.start,
                children: <Widget>[
                  Expanded(
                      child: Row(children: [
                    Image.asset(AppIcons.clock, width: 17),
                    const SizedBox(width: 5),
                    Text(
                      '${data.quantity} năm',
                      style: AppBloc.applicationCubit.appTextStyle.normal,
                    )
                  ])),
                  Expanded(
                      child: Row(children: [
                    // Image.asset(AppIcons.area, width: 17),
                    // const SizedBox(width: 5),
                    Text(
                      'Tổng cộng: ${UtilCommon.formatCommaInt((data.quantity ?? 0) * data.subscriptionDetails!.price!)} đ',
                      style: AppBloc.applicationCubit.appTextStyle.normal,
                    )
                  ]))
                ],
              )),
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
                crossAxisAlignment: CrossAxisAlignment.center,
                mainAxisAlignment: MainAxisAlignment.start,
                children: <Widget>[
                  Expanded(
                      child: Row(children: [
                    Image.asset(AppIcons.calendar, width: 17),
                    const SizedBox(width: 5),
                    Text(
                      '${(data.subStart ?? '').replaceAll('-', '/')} ～ ${(data.subEnd ?? '').replaceAll('-', '/')}',
                      style: AppBloc.applicationCubit.appTextStyle.normal,
                    )
                  ])),
                ],
              )),
        ],
      ),
    );
  }

  Widget _button(SubcriptionViewInfoState state) {
    var buttonBabel = getButtonLabelByStatus(state.subscriptionUserData!.status!);
    return buttonBabel != null
        ? Padding(
            padding: const EdgeInsets.all(16),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.center,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: <Widget>[
                Expanded(
                  child: AppElevatedButton(
                    text: buttonBabel,
                    onPressed: () {
                      onUpdateStatus(state.subscriptionUserData!.status!, state.subscriptionUserData!.id!);
                    },
                    radius: AppDimension.kButtonBorderRadius,
                    loading: state.apiCallStatus == ApiCallStatus.loading,
                    disabled: state.apiCallStatus == ApiCallStatus.loading,
                  ),
                )
              ],
            ),
          )
        : Container();
  }

  static String? getButtonLabelByStatus(int status) {
    if (status == 0) {
      return 'Duyệt tài khoản';
    } else if (status == 1) {
      return 'Khóa';
    } else if (status == 2) {
      return 'Mở khóa';
    }
    return null;
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
