import 'package:bds_hoan_mobile/bloc_global/app_bloc.dart';
import 'package:bds_hoan_mobile/configs/_config.dart';
import 'package:bds_hoan_mobile/data/enums/api_call_status.dart';
import 'package:bds_hoan_mobile/data/models/subcription/subcription_info.dart';
import 'package:bds_hoan_mobile/data/models/subcription/subcription_register_model.dart';
import 'package:bds_hoan_mobile/presentation/screens/subcription/subcription_payment/cubit/subcription_payment_cubit.dart';
import 'package:bds_hoan_mobile/presentation/shared_widgets/buttons/widget.dart';
import 'package:bds_hoan_mobile/presentation/shared_widgets/common/widget.dart';
import 'package:bds_hoan_mobile/presentation/shared_widgets/dialogs/widget.dart';
import 'package:bds_hoan_mobile/presentation/shared_widgets/utils/_utils.dart';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:image_picker/image_picker.dart';
import 'package:url_launcher/url_launcher.dart';

class SubcriptionPaymentView extends StatefulWidget {
  const SubcriptionPaymentView({Key? key, required this.selectedSubcription, required this.numMonth}) : super(key: key);

  final SubcriptionInfo selectedSubcription;
  final int numMonth;

  @override
  State<SubcriptionPaymentView> createState() => _SubcriptionPaymentViewState();
}

class _SubcriptionPaymentViewState extends State<SubcriptionPaymentView> {
  late final SubcriptionPaymentCubit cubit;
  final ImagePicker _picker = ImagePicker();

  @override
  void initState() {
    super.initState();
    cubit = BlocProvider.of<SubcriptionPaymentCubit>(context);
  }

  void onRegisterSubcription() async {
    final success = await cubit.registerSubcription(
        phone: AppBloc.userCubit.state!.phoneNumber!, subscription: widget.selectedSubcription.type, quantity: widget.numMonth);

    await Future.delayed(const Duration(milliseconds: 500));
    if (success == true) {
      await showDialog<void>(
        context: context,
        barrierDismissible: false,
        builder: (_) => const SuccessAlertDialog(message: 'Xác nhận thanh toán thành công'),
      );
      await Future.delayed(const Duration(milliseconds: 500));
      Navigator.pop(context);
      Navigator.pushReplacementNamed(context, Routes.subcriptionPending, arguments: true);
    }
  }

  void _getFromGallery() async {
    try {
      final _pickedFiles = await _picker.pickImage(source: ImageSource.gallery);
      if (_pickedFiles == null) return;

      setState(() {
        cubit.uploadSubcriptionImg(pickedFiles: [_pickedFiles]);
      });
    } catch (e) {
      UtilLogger.log('Pickfile error');
    }
  }

  Future<void> _makePhoneCall(String phoneNumber) async {
    final Uri launchUri = Uri(
      scheme: 'tel',
      path: phoneNumber,
    );
    await launchUrl(launchUri);
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
          child: SingleChildScrollView(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                const SizedBox(height: 15),
                const Padding(padding: EdgeInsets.symmetric(horizontal: 40), child: DefaultDivider()),
                const SizedBox(height: 30),
                BlocBuilder<SubcriptionPaymentCubit, SubcriptionPaymentState>(
                  builder: (context, state) {
                    if (state.apiCallStatus == ApiCallStatus.loading) {
                      return Padding(
                        padding: EdgeInsets.only(top: MediaQuery.of(context).size.height / 4),
                        child: const Center(
                          child: CircularProgressIndicator(),
                        ),
                      );
                    }
                    // if (state.groupInfoType == GroupInfoType.profile) {
                    //   return GroupInfoWidget(
                    //     groupModel: state.groupModel,
                    //   );
                    // }
                    // return const GroupInfoIntroduction();
                    return buildLayout(state);
                  },
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }

  AppBar _buildAppBar(BuildContext context) {
    return AppBar(
      centerTitle: true,
      elevation: 0,
      title: Text(
        'Đăng ký đại lý',
        style: AppBloc.applicationCubit.appTextStyle.mediumBold,
      ),
    );
  }

  Widget buildLayout(SubcriptionPaymentState state) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text('Thông tin thanh toán', style: AppBloc.applicationCubit.appTextStyle.largeBold),
        const SizedBox(
          height: AppDimension.kMediumSizedBoxHeight,
        ),
        Container(
          width: 1000,
          padding: const EdgeInsets.all(8),
          decoration: BoxDecoration(
            color: const Color(0xFFFFBC00),
            border: Border.all(color: const Color(0xFFFFBC00)),
            borderRadius: BorderRadius.circular(12),
          ),
          // color: const Color(0xFFFFBC00),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text('Chuyển khoản ngân hàng', style: AppBloc.applicationCubit.appTextStyle.mediumBold),
              Text('VCB - 0581000785276 - Diệp Đại Hoán', style: AppBloc.applicationCubit.appTextStyle.mediumBold)
            ],
          ),
        ),
        const SizedBox(
          height: AppDimension.kMediumSizedBoxHeight,
        ),
        Row(children: [
          Expanded(
              child: Text('Sau khi thanh toán, vui lòng chụp màn hình biên lai và tải lên ở đây. Chúng tôi sẽ xác nhận thanh toán sau 5 phút.',
                  style: AppBloc.applicationCubit.appTextStyle.normal)),
        ]),
        const SizedBox(
          height: AppDimension.kMediumSizedBoxHeight,
        ),
        Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
          Text('Sau 5 phút, nếu thanh toán chưa được xác nhận', style: AppBloc.applicationCubit.appTextStyle.normal),
          Row(
            children: [
              Text('vui lòng liên hệ hotline ', style: AppBloc.applicationCubit.appTextStyle.normal),
              InkWell(
                onTap: () {
                  _makePhoneCall('0789522688');
                },
                child: Text('0789522688', style: AppBloc.applicationCubit.appTextStyle.mediumBold),
              ),
            ],
          )
        ]),
        const SizedBox(
          height: AppDimension.kMediumSizedBoxHeight,
        ),
        Text('Tải biên lai', style: AppBloc.applicationCubit.appTextStyle.largeBold),
        const SizedBox(height: AppDimension.kTextFormFieldMargin),
        (state.isUploading != null && state.isUploading!)
            ? const Center(
                child: CircularProgressIndicator(),
              )
            : _imageUpload(images: state.images),
        Row(
          mainAxisAlignment: MainAxisAlignment.start,
          children: [
            InkWell(
                highlightColor: Colors.transparent,
                splashColor: Colors.transparent,
                onTap: () => _getFromGallery(),
                child: Container(
                    height: 120,
                    width: 120,
                    decoration: BoxDecoration(
                      color: AppColors.greyAccountIcon,
                      borderRadius: BorderRadius.circular(12),
                    ),
                    padding: const EdgeInsets.all(40),
                    child: Icon(
                      Icons.add,
                      color: AppColors.greyLight,
                    ))),
          ],
        ),
        const SizedBox(height: AppDimension.kTextFormFieldMargin),
        const SizedBox(
          height: AppDimension.kSizedBoxHeight,
        ),
        AppElevatedButton(
          onPressed: onRegisterSubcription,
          elevation: 0,
          text: 'Xác nhận thanh toán',
          radius: AppDimension.kButtonBorderRadius,
          // loading: state.apiCallStatus == ApiCallStatus.loading,
          // disabled: state.apiCallStatus == ApiCallStatus.loading,
        )
      ],
    );
  }

  Widget _imageUpload({required List<SubcriptionImageRegister> images}) {
    return Column(
      mainAxisAlignment: MainAxisAlignment.center,
      crossAxisAlignment: CrossAxisAlignment.start,
      children: <Widget>[
        Padding(
          padding: const EdgeInsets.only(right: 0, left: 0),
          child: Column(
            children: _getImageList(images: images),
          ),
        ),
        const SizedBox(
          height: 8,
        )
      ],
    );
  }

  List<Widget> _getImageList({required List<SubcriptionImageRegister> images}) {
    final List<Widget> noList = <Widget>[];
    int count = 0;
    const int columnCount = 3;
    for (int i = 0; i < images.length / columnCount; i++) {
      final List<Widget> listUI = <Widget>[];
      for (int i = 0; i < columnCount; i++) {
        try {
          final SubcriptionImageRegister realEstateImage = images[count];
          listUI.add(Expanded(
            child: Row(
              children: <Widget>[
                Material(
                  color: Colors.transparent,
                  child: Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: Row(
                      children: <Widget>[
                        Container(
                          height: 120,
                          width: 120,
                          decoration: BoxDecoration(
                            border: Border.all(color: AppColors.boxBorder),
                            borderRadius: BorderRadius.circular(12),
                          ),
                          child: ClipRRect(
                              borderRadius: BorderRadius.circular(12),
                              child: realEstateImage.url != null
                                  ? Stack(children: <Widget>[
                                      CachedNetworkImage(
                                        imageUrl: realEstateImage.url!,
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
                                      ),
                                      Positioned(
                                          top: 5,
                                          right: 5,
                                          child: GestureDetector(
                                            onTap: () {
                                              cubit.deleteUploadedSubcriptionImg(removeFile: realEstateImage);
                                            },
                                            child: Container(
                                              padding: const EdgeInsets.all(2),
                                              decoration: BoxDecoration(
                                                border: Border.all(color: AppColors.boxBorder),
                                                borderRadius: BorderRadius.circular(10),
                                              ),
                                              child: Icon(
                                                Icons.highlight_remove,
                                                color: AppColors.primary,
                                              ),
                                            ),
                                          )),
                                    ])
                                  : Container()),
                        ),
                      ],
                    ),
                  ),
                ),
              ],
            ),
          ));
          if (count < images.length - 1) {
            count += 1;
          } else {
            break;
          }
        } catch (e) {
          print(e);
        }
      }
      noList.add(Row(
        mainAxisAlignment: MainAxisAlignment.center,
        crossAxisAlignment: CrossAxisAlignment.center,
        mainAxisSize: MainAxisSize.min,
        children: listUI,
      ));
    }
    return noList;
  }
}
