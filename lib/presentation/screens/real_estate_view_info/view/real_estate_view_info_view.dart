import 'dart:io';

import 'package:bds_hoan_mobile/bloc_global/app_bloc.dart';
import 'package:bds_hoan_mobile/bloc_global/application/app_text_style.dart';
import 'package:bds_hoan_mobile/configs/_config.dart';
import 'package:bds_hoan_mobile/configs/app_colors.dart';
import 'package:bds_hoan_mobile/configs/app_dimension.dart';
import 'package:bds_hoan_mobile/configs/app_icons.dart';
import 'package:bds_hoan_mobile/configs/routes.dart';
import 'package:bds_hoan_mobile/data/enums/api_call_status.dart';
import 'package:bds_hoan_mobile/data/enums/status.dart';
import 'package:bds_hoan_mobile/data/models/real_estate/real_estate_data_model.dart';
import 'package:bds_hoan_mobile/data/models/real_estate/real_estate_detail_model.dart';
import 'package:bds_hoan_mobile/data/models/real_estate/real_estate_register_param.dart';
import 'package:bds_hoan_mobile/presentation/screens/real_estate_view_info/cubit/real_estate_view_info_cubit.dart';
import 'package:bds_hoan_mobile/presentation/screens/real_estate_view_info/view/widgets/confirm_real_estate_dialog.dart';
import 'package:bds_hoan_mobile/presentation/shared_widgets/buttons/widget.dart';
import 'package:bds_hoan_mobile/presentation/shared_widgets/common/heroview.dart';
import 'package:bds_hoan_mobile/presentation/shared_widgets/common/widget.dart';
import 'package:bds_hoan_mobile/presentation/shared_widgets/dialogs/widget.dart';
import 'package:bds_hoan_mobile/presentation/shared_widgets/gallery/gallery_photo_view_wrapper.dart';
import 'package:bds_hoan_mobile/presentation/shared_widgets/text_input/app_text_input.dart';
import 'package:bds_hoan_mobile/presentation/shared_widgets/utils/util_common.dart';
import 'package:bds_hoan_mobile/presentation/shared_widgets/utils/util_date_time.dart';
import 'package:bds_hoan_mobile/presentation/shared_widgets/utils/util_validate.dart';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:carousel_slider/carousel_slider.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:image_picker/image_picker.dart';
import 'package:path_provider/path_provider.dart';
import 'package:photo_view/photo_view.dart';
import 'package:readmore/readmore.dart';
import 'package:share_plus/share_plus.dart';
import 'package:url_launcher/url_launcher.dart';

class RealEstateViewInfoView extends StatefulWidget {
  const RealEstateViewInfoView({Key? key, required this.productId}) : super(key: key);

  final int productId;

  get helperText => null;

  @override
  _RealEstateViewInfoViewState createState() => _RealEstateViewInfoViewState();
}

class _RealEstateViewInfoViewState extends State<RealEstateViewInfoView> {
  late final RealEstateViewInfoCubit cubit;
  String? displayImg;
  int? displayImgIndex;
  String? saledPriceStr;
  final TextEditingController _salePriceInputController = TextEditingController();
  final _formKey = GlobalKey<FormState>();

  @override
  void initState() {
    super.initState();

    cubit = BlocProvider.of<RealEstateViewInfoCubit>(context);
    cubit.getRealEstateDetalById(productId: widget.productId);
  }

  Future<void> _displayTextInputDialog() async {
    return showDialog(
        context: context,
        builder: (context) {
          return AlertDialog(
            title: Text('Giá đã bán'),
            content: Form(
                key: _formKey,
                child: Column(crossAxisAlignment: CrossAxisAlignment.start, mainAxisSize: MainAxisSize.min, children: <Widget>[
                  AppTextInput(
                    controller: _salePriceInputController,
                    hintText: 'Giá đã bán',
                    labelText: 'Giá đã bán',
                    keyboardType: TextInputType.number,
                    validateType: ValidateType.price,
                    commaSeperateFlg: true,
                    // onChanged: (val) {
                    //   setState(() {

                    //   });
                    // },
                  )
                ])),
            actions: <Widget>[
              AppElevatedButton(
                text: 'Xác nhận',
                onPressed: () {
                  if (_formKey.currentState!.validate()) {
                    Navigator.pop(context);
                    setState(() {
                      saledPriceStr = _salePriceInputController.text.replaceAll(',', '');
                    });
                  }
                },
                radius: AppDimension.kButtonBorderRadius,
                // loading: state.apiCallStatus == ApiCallStatus.loading,
                // disabled: state.apiCallStatus == ApiCallStatus.loading,
              )
            ],
          );
        });
  }

  void onUpdateStatus(StatusEnum status, int productId) async {
    bool? success = false;
    // cubit.updateStatusById()
    if (status == StatusEnum.New) {
      // Mới đăng chưa duyệt
      // Duyệt sẽ chuyến status = 1(Đã duyệt)
      if (AppBloc.authenticationCubit.isAdminLogin == true) {
        success = await cubit.updateStatusById(realEstateId: productId, status: StatusEnum.Approved, salePrice: null);
      }
    } else if (status == StatusEnum.Approved) {
      // Đã duyệt
      // Nhấn giao dịch sẽ chuyến status = 2(Giao dịch)
      success = await cubit.updateStatusById(realEstateId: productId, status: StatusEnum.GD, salePrice: null);
    } else if (status == StatusEnum.GD) {
      // Đã duyệt
      // Nhấn Đã sẽ chuyến status = 2(Đã bán)

      await _displayTextInputDialog();

      if (saledPriceStr == null) {
        return;
      }

      if (AppBloc.authenticationCubit.isAdminLogin == true) {
        success = await cubit.updateStatusById(
            // Da ban boi admin
            realEstateId: productId,
            status: StatusEnum.SaledByAdmin,
            salePrice: int.tryParse(saledPriceStr!));
      } else {
        // Da ban boi user
        success = await cubit.updateStatusById(realEstateId: productId, status: StatusEnum.SaledByUser, salePrice: int.tryParse(saledPriceStr!));
      }
    } else if (status == StatusEnum.Normal) {
      // Đã duyệt
      // Duyệt sẽ chuyến status = 2(Giao dịch)
      success = await cubit.updateStatusById(realEstateId: productId, status: StatusEnum.GD, salePrice: null);
    } else if (status == StatusEnum.SaledByAdmin) {
    } else if (status == StatusEnum.SaledByUser) {
      success = await cubit.updateStatusById(realEstateId: productId, status: StatusEnum.SaledByAdmin, salePrice: null);
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

  void _onShare(BuildContext context, bool imageShare) async {
    await cubit.share(context, imageShare);
  }

  Future<void> _makePhoneCall(String phoneNumber) async {
    final Uri launchUri = Uri(
      scheme: 'tel',
      path: phoneNumber,
    );
    await launchUrl(launchUri);
  }

  void deleteByAdmin(int productId) async {
    final confirmed = await showDialog<bool>(
      context: context,
      barrierDismissible: false,
      builder: (_) => const ConfirmRealEstateDialog(title: 'Bạn chắc chắc muốn xóa sản phẩm này?'),
    );
    if (confirmed == true) {
      final result = await cubit.deleteByAdmin(realEstateId: productId);
      await Future.delayed(const Duration(milliseconds: 500));
      if (result == true) {
        await showDialog<void>(
          context: context,
          barrierDismissible: false,
          builder: (_) => const SuccessAlertDialog(message: 'Xóa sản phẩm thành công'),
        );
        await Future.delayed(const Duration(milliseconds: 500));
        Navigator.pop(context);
      }
    }
  }

  void disableByAdmin(int productId) async {
    final confirmed = await showDialog<bool>(
      context: context,
      barrierDismissible: false,
      builder: (_) => const ConfirmRealEstateDialog(title: 'Bạn chắc chắc muốn ẩn sản phẩm này?'),
    );
    if (confirmed == true) {
      final result = await cubit.disableByAdmin(realEstateId: productId);
      await Future.delayed(const Duration(milliseconds: 500));
      if (result == true) {
        await showDialog<void>(
          context: context,
          barrierDismissible: false,
          builder: (_) => const SuccessAlertDialog(message: 'Ẩn sản phẩm thành công'),
        );
        await Future.delayed(const Duration(milliseconds: 500));
        Navigator.pop(context);
      }
    }
  }

  void enableByAdmin(int productId) async {
    final confirmed = await showDialog<bool>(
      context: context,
      barrierDismissible: false,
      builder: (_) => const ConfirmRealEstateDialog(title: 'Bạn chắc chắc muốn hiển thị lại sản phẩm này?'),
    );
    if (confirmed == true) {
      final result = await cubit.enableByAdmin(realEstateId: productId);
      await Future.delayed(const Duration(milliseconds: 500));
      if (result == true) {
        await showDialog<void>(
          context: context,
          barrierDismissible: false,
          builder: (_) => const SuccessAlertDialog(message: 'Hiển thị lại sản phẩm thành công'),
        );
        await Future.delayed(const Duration(milliseconds: 500));
        Navigator.pop(context);
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    final double tempHeight = MediaQuery.of(context).size.height - (MediaQuery.of(context).size.width / 1.2) + 24.0;
    return Container(
      // color: AppTheme.nearlyWhite,
      child: Scaffold(
          backgroundColor: Colors.white,
          body: BlocBuilder<RealEstateViewInfoCubit, RealEstateViewInfoState>(builder: (context, state) {
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
                                    ? ((state.productDetail!.images != null && state.productDetail!.images!.isNotEmpty)
                                        ? state.productDetail!.images![0].url!
                                        : '')
                                    : displayImg!,
                                imageBuilder: (context, imageProvider) => GestureDetector(
                                    onTap: () {
                                      Navigator.push(
                                        context,
                                        MaterialPageRoute(
                                          builder: (context) => GalleryPhotoViewWrapper(
                                            galleryItems: state.productDetail!.images!,
                                            backgroundDecoration: const BoxDecoration(
                                              color: Colors.black,
                                            ),
                                            initialIndex: displayImgIndex ?? 0,
                                            scrollDirection: Axis.horizontal,
                                          ),
                                        ),
                                      );
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
                                                    displayImg = state.productDetail!.images![index].url!;
                                                    displayImgIndex = index;
                                                  });
                                                },
                                                child: CachedNetworkImage(
                                                  imageUrl: state.productDetail!.images![index].url!,
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
                                    itemCount: state.productDetail!.images!.length),
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
                              Row(
                                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                crossAxisAlignment: CrossAxisAlignment.center,
                                children: <Widget>[
                                  Container(
                                    padding: EdgeInsets.only(left: 14, right: 14, top: 2, bottom: 2),
                                    decoration: BoxDecoration(
                                      color: UtilCommon.getColorByKind(state.productDetail!.kind!.id!),
                                      border: Border.all(color: AppColors.boxBorder),
                                      borderRadius: BorderRadius.circular(12),
                                    ),
                                    child: Text(
                                      state.productDetail!.kind!.name ?? '',
                                      textAlign: TextAlign.left,
                                      style: AppBloc.applicationCubit.appTextStyle.medium
                                          .copyWith(color: UtilCommon.getTextColorByKind(state.productDetail!.kind!.id!)),
                                    ),
                                  ),
                                  Container(
                                    child: Row(
                                      // ignore: prefer_const_literals_to_create_immutables
                                      children: <Widget>[
                                        (AppBloc.authenticationCubit.isSuperAdmin == true ||
                                                (AppBloc.userCubit.state?.id != state.productDetail?.user?.id &&
                                                    AppBloc.authenticationCubit.isAdminLogin != true))
                                            ? SizedBox()
                                            : InkWell(
                                                onTap: () {
                                                  Navigator.pushNamed(context, Routes.realEstateRegister,
                                                          arguments: RealEstateRegEditParam(
                                                              processMode: RealEstateProcessMode.edit,
                                                              inputType: RealEstateInputType.vn2000,
                                                              productId: state.productDetail!.id))
                                                      .then((value) {
                                                    cubit.getRealEstateDetalById(productId: widget.productId);
                                                  });
                                                },
                                                child: Text(
                                                  'Chỉnh sửa',
                                                  style: AppBloc.applicationCubit.appTextStyle.normalBold.copyWith(
                                                    color: AppColors.primary,
                                                    decoration: TextDecoration.underline,
                                                  ),
                                                ),
                                              )
                                      ],
                                    ),
                                  )
                                ],
                              ),
                              const SizedBox(
                                height: AppDimension.kSizedBoxHeight,
                              ),
                              _basicInfo(state.productDetail!),
                              const SizedBox(
                                height: AppDimension.kSizedBoxHeight,
                              ),
                              _saleInfo(state.productDetail!),
                              const SizedBox(
                                height: AppDimension.kSizedBoxHeight,
                              ),
                              if ((state.productDetail!.kind!.id! == 2 || state.productDetail!.kind!.id! == 4) &&
                                  (AppBloc.authenticationCubit.isSuperAdmin == true ||
                                      AppBloc.userCubit.state?.id == state.productDetail?.user?.id)) ...[_consignorInfo(state.productDetail!)],
                              const SizedBox(
                                height: AppDimension.kSizedBoxHeight,
                              ),
                              _descriptionInfo(state.productDetail!),
                              const SizedBox(
                                height: AppDimension.kSizedBoxHeight,
                              ),
                              _historyInfo(state.productDetail!),
                              const SizedBox(
                                height: AppDimension.kMediumSizedBoxHeight,
                              ),
                              if (AppBloc.authenticationCubit.isSuperAdmin != true) ...[_button(state)]
                            ],
                          ))),
                ),
              ],
            );
          })),
    );
  }

  Widget _basicInfo(RealEstateDetailModel product) {
    return Container(
      child: Padding(
        padding: const EdgeInsets.only(left: 0, top: 0, bottom: 0),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: <Widget>[
            Padding(
                padding: const EdgeInsets.all(4),
                child: Text(product.title ?? '', textAlign: TextAlign.left, style: AppBloc.applicationCubit.appTextStyle.extraBoldBlack)),
            Padding(
                padding: const EdgeInsets.all(4),
                child: Row(children: [
                  const Icon(Icons.info, size: 22),
                  const SizedBox(width: 5),
                  Text(getDisplayStatus(product.status!) ?? '', textAlign: TextAlign.left, style: AppBloc.applicationCubit.appTextStyle.normalBold)
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
                    Image.asset(AppIcons.location, width: 17),
                    const SizedBox(width: 5),
                    Expanded(
                        child: Text(
                      '${product.address ?? ''} ${product.wards!.name ?? ''} ${product.district!.name ?? ''} ${product.province!.name ?? ''}',
                      style: AppBloc.applicationCubit.appTextStyle.normal,
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
                        child: Row(
                      children: [
                        Image.asset(AppIcons.comission, width: 17),
                        const SizedBox(width: 5),
                        Text(
                          '${UtilCommon.getPriceDisplayStr(product.commission)} HH',
                          style: AppBloc.applicationCubit.appTextStyle.normal,
                        )
                      ],
                    )),
                    Expanded(
                        child: Row(children: [
                      Image.asset(AppIcons.clock, width: 17),
                      const SizedBox(width: 5),
                      Text(
                        UtilDateTime.formatDateTime(product.updatedAt),
                        style: AppBloc.applicationCubit.appTextStyle.normal,
                      )
                    ])),
                    Expanded(
                        child: Row(children: [
                      Image.asset(AppIcons.area, width: 17),
                      const SizedBox(width: 5),
                      Text(
                        '${product.area ?? ''} m2',
                        style: AppBloc.applicationCubit.appTextStyle.normal,
                      )
                    ]))
                  ],
                )),
            Padding(
                padding: const EdgeInsets.only(left: 6, right: 4, top: 4, bottom: 4),
                child: Row(
                  crossAxisAlignment: CrossAxisAlignment.center,
                  mainAxisAlignment: MainAxisAlignment.start,
                  children: <Widget>[
                    Expanded(
                        child: Row(
                      children: [
                        Image.asset(AppIcons.square, width: 15),
                        const SizedBox(width: 5),
                        Text(
                          '${UtilCommon.getPriceDisplayStr(product.squareMetrePrice)} /m2',
                          style: AppBloc.applicationCubit.appTextStyle.normal,
                        )
                      ],
                    )),
                    Expanded(
                        child: Row(children: [
                      Image.asset(AppIcons.width, width: 15),
                      const SizedBox(width: 5),
                      Text(
                        '${UtilCommon.getPriceDisplayStr(product.widthMetrePrice)} /mn',
                        style: AppBloc.applicationCubit.appTextStyle.normal,
                      )
                    ])),
                    Expanded(
                        child: Row(children: [
                      Image.asset(AppIcons.total, width: 15),
                      const SizedBox(width: 5),
                      Text(
                        UtilCommon.getPriceDisplayStr(product.totalPrice),
                        style: AppBloc.applicationCubit.appTextStyle.normal,
                      )
                    ]))
                  ],
                )),
            if (product.status == StatusEnum.SaledByAdmin || product.status == StatusEnum.SaledByUser) ...[
              Padding(
                  padding: const EdgeInsets.only(left: 6, right: 4, top: 4, bottom: 4),
                  child: Row(
                    crossAxisAlignment: CrossAxisAlignment.center,
                    mainAxisAlignment: MainAxisAlignment.start,
                    children: <Widget>[
                      Row(
                        children: [
                          Image.asset(AppIcons.comission, width: 17),
                          const SizedBox(width: 5),
                          Text(
                            '${UtilCommon.getPriceDisplayStr(product.salePrice)}',
                            style: AppBloc.applicationCubit.appTextStyle.normal,
                          )
                        ],
                      )
                    ],
                  ))
            ]
          ],
        ),
      ),
    );
  }

  Widget _saleInfo(RealEstateDetailModel product) {
    return Container(
      child: Padding(
        padding: const EdgeInsets.only(left: 0, top: 0, bottom: 0),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: <Widget>[
            _buildTextInputTitle('Đăng bởi'),
            Padding(
                padding: const EdgeInsets.all(4),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Expanded(
                        child: Row(
                      children: [
                        CircleAvatar(
                            backgroundColor: Colors.white,
                            radius: 23.0,
                            child: CircleAvatar(
                              radius: 21.0,
                              child: ClipOval(
                                child: CachedNetworkImage(
                                  imageUrl:
                                      (product.user!.photo != null && product.user!.photo != '') ? product.user!.photo! : AppConstant.defaltAvatarUrl,
                                  imageBuilder: (context, imageProvider) => Container(
                                    decoration: BoxDecoration(
                                      image: DecorationImage(
                                        image: imageProvider,
                                        fit: BoxFit.cover,
                                      ),
                                    ),
                                  ),
                                  placeholder: (context, url) => const Center(child: CircularProgressIndicator()),
                                  errorWidget: (context, url, error) => Container(),
                                ),
                              ),
                            )),
                        const SizedBox(width: AppDimension.kSizedBoxWidth),
                        Text(
                          '${product.user!.name ?? ''}',
                          style: AppBloc.applicationCubit.appTextStyle.normal,
                        ),
                      ],
                    )),
                    Expanded(
                        child: Row(children: [
                      Image.asset(AppIcons.phone, width: 17),
                      const SizedBox(width: 5),
                      InkWell(
                          onTap: () {
                            if (product.user!.phone != null && product.user!.phone!.isNotEmpty) {
                              _makePhoneCall(product.user!.phone!);
                            }
                          },
                          child: Text(
                            product.user!.phone ?? '',
                            style: AppBloc.applicationCubit.appTextStyle.normal,
                          ))
                    ])),
                    // Text(
                    //   'Đăng vào: ${UtilDateTime.formatDateTime(product.createdAt, pattern: "dd/MM/yyyy HH:mm")}',
                    //   style: AppBloc.applicationCubit.appTextStyle.normal,
                    // ),
                  ],
                ))
          ],
        ),
      ),
    );
  }

  Widget _consignorInfo(RealEstateDetailModel product) {
    return Container(
      child: Padding(
        padding: const EdgeInsets.only(left: 0, top: 0, bottom: 0),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: <Widget>[
            _buildTextInputTitle(product.kind!.id! == 2 ? 'Sale liên kết' : 'Ký gửi'),
            Padding(
                padding: const EdgeInsets.only(left: 12, top: 4, bottom: 4, right: 4),
                child: Row(
                  crossAxisAlignment: CrossAxisAlignment.center,
                  mainAxisAlignment: MainAxisAlignment.start,
                  children: <Widget>[
                    Expanded(
                        child: Row(
                      children: [
                        Image.asset(AppIcons.group, width: 17),
                        const SizedBox(width: 5),
                        Text(
                          product.consignorsName ?? '',
                          style: AppBloc.applicationCubit.appTextStyle.normal,
                        )
                      ],
                    )),
                    Expanded(
                        child: Row(children: [
                      Image.asset(AppIcons.phone, width: 17),
                      const SizedBox(width: 5),
                      InkWell(
                          onTap: () {
                            if (product.consignorsPhone != null && product.consignorsPhone!.isNotEmpty) {
                              _makePhoneCall(product.consignorsPhone!);
                            }
                          },
                          child: Text(
                            product.consignorsPhone ?? '',
                            style: AppBloc.applicationCubit.appTextStyle.normal,
                          ))
                    ])),
                    if (product.kind!.id! == 4) ...[
                      Expanded(
                          child: Row(children: [
                        Image.asset(AppIcons.calendar_info, width: 17),
                        const SizedBox(width: 5),
                        Text(
                          '${(product.consignorsExpiry ?? '').replaceAll('-', '/')}',
                          style: AppBloc.applicationCubit.appTextStyle.normal,
                        )
                      ]))
                    ]
                  ],
                )),
          ],
        ),
      ),
    );
  }

  Widget _descriptionInfo(RealEstateDetailModel product) {
    return Container(
      child: Padding(
        padding: const EdgeInsets.only(left: 0, top: 0, bottom: 0),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: <Widget>[
            _buildTextInputTitle('Mô tả'),
            Padding(
                padding: const EdgeInsets.only(left: 12, right: 4, top: 4, bottom: 4),
                child: ReadMoreText(
                  '${product.description}',
                  trimLines: 4,
                  style: AppBloc.applicationCubit.appTextStyle.normal,
                  colorClickableText: Colors.grey,
                  trimMode: TrimMode.Line,
                  trimCollapsedText: '...Nhiều hơn',
                  trimExpandedText: '...Ít hơn',
                ))
          ],
        ),
      ),
    );
  }

  Widget _historyInfo(RealEstateDetailModel product) {
    return Container(
      child: Padding(
        padding: const EdgeInsets.only(left: 0, top: 0, bottom: 0),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: <Widget>[
            _buildTextInputTitle('Lịch sử'),
            for (var history in product.historyList!)
              Padding(
                  padding: const EdgeInsets.only(left: 12, top: 4, bottom: 4, right: 4),
                  child: Row(crossAxisAlignment: CrossAxisAlignment.start, children: <Widget>[
                    Text("• "),
                    Expanded(
                      child: Text(
                        history,
                        style: AppBloc.applicationCubit.appTextStyle.normal,
                      ),
                    ),
                  ]))
          ],
        ),
      ),
    );
  }

  Widget _button(RealEstateViewInfoState state) {
    var buttonBabel = getButtonLabelByStatus(state.productDetail!.status!);
    return buttonBabel != null
        ? Padding(
            padding: const EdgeInsets.only(left: 16, bottom: 16, right: 16),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.center,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: <Widget>[
                InkWell(
                  splashColor: Colors.white,
                  highlightColor: Colors.white,
                  onTap: () {
                    _onShare(context, true);
                  },
                  child: Container(
                    padding: const EdgeInsets.all(8),
                    decoration: BoxDecoration(
                      border: Border.all(color: AppColors.boxBorder),
                      borderRadius: BorderRadius.circular(12),
                    ),
                    child: const Icon(Icons.share, color: Color(0xFF374957)),
                  ),
                ),
                const SizedBox(
                  width: 16,
                ),
                Expanded(
                  child: AppElevatedButton(
                    text: buttonBabel,
                    onPressed: () {
                      onUpdateStatus(state.productDetail!.status!, state.productDetail!.id!);
                    },
                    radius: AppDimension.kButtonBorderRadius,
                    loading: state.apiCallStatus == ApiCallStatus.loading,
                    disabled: state.apiCallStatus == ApiCallStatus.loading,
                  ),
                ),
                if (AppBloc.authenticationCubit.isAdminLogin == true) ...[
                  const SizedBox(
                    width: 16,
                  ),
                  InkWell(
                    splashColor: Colors.white,
                    highlightColor: Colors.white,
                    onTap: () {
                      deleteByAdmin(state.productDetail!.id!);
                    },
                    child: Container(
                      padding: const EdgeInsets.all(8),
                      decoration: BoxDecoration(
                        border: Border.all(color: AppColors.boxBorder),
                        borderRadius: BorderRadius.circular(12),
                      ),
                      child: const Icon(Icons.delete, color: Color(0xFF374957)),
                    ),
                  ),
                  const SizedBox(
                    width: 16,
                  ),
                  InkWell(
                    splashColor: Colors.white,
                    highlightColor: Colors.white,
                    onTap: () {
                      if (state.productDetail!.disable == true) {
                        enableByAdmin(state.productDetail!.id!);
                      }
                      if (state.productDetail!.disable == false) {
                        disableByAdmin(state.productDetail!.id!);
                      }
                    },
                    child: Container(
                      padding: const EdgeInsets.all(8),
                      decoration: BoxDecoration(
                        border: Border.all(color: AppColors.boxBorder),
                        borderRadius: BorderRadius.circular(12),
                      ),
                      child: (state.productDetail!.disable == true)
                          ? const Icon(Icons.visibility, color: Color(0xFF374957))
                          : const Icon(Icons.visibility_off, color: Color(0xFF374957)),
                    ),
                  ),
                ],
              ],
            ),
          )
        : Container();
  }

  static String? getButtonLabelByStatus(StatusEnum status) {
    if (status == StatusEnum.New) {
      // New
      if (AppBloc.authenticationCubit.isAdminLogin == true) {
        return 'Duyệt tin';
      }
    } else if (status == StatusEnum.Approved) {
      // Đã duyệt
      return 'Giao dịch';
    } else if (status == StatusEnum.GD) {
      // Dang giao dich
      return 'Đã bán';
    } else if (status == StatusEnum.Normal) {
      // Binh thuong
      return 'Đã bán';
    } else if (status == StatusEnum.SaledByUser) {
      // Da ban

      if (AppBloc.authenticationCubit.isAdminLogin == true) {
        return 'Duyệt đã bán';
      }
    } else if (status == StatusEnum.SaledByAdmin) {}
    return null;
  }

  static String? getDisplayStatus(StatusEnum status) {
    if (status == StatusEnum.New) {
      // New
      return 'Chưa duyệt';
    } else if (status == StatusEnum.Approved) {
      // Đã duyệt
      return 'Đã duyệt';
    } else if (status == StatusEnum.GD) {
      // Dang giao dich
      return 'Đang giao dịch';
    } else if (status == StatusEnum.Normal) {
      // Binh thuong
      return 'Đang giao dịch';
    } else if (status == StatusEnum.SaledByAdmin || status == StatusEnum.SaledByUser) {
      // Da ban
      return 'Đã bán';
    }
    return null;
  }

  Widget _buildTextInputTitle(String title) {
    return Padding(
      padding: const EdgeInsets.only(left: 8.0),
      child: Text(title, style: AppBloc.applicationCubit.appTextStyle.extraBoldPrimaryColor),
    );
  }
}
