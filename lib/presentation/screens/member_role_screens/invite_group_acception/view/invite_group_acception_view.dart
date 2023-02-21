import 'package:bds_hoan_mobile/bloc_global/app_bloc.dart';
import 'package:bds_hoan_mobile/bloc_global/application/app_text_style.dart';
import 'package:bds_hoan_mobile/bloc_global/bloc.dart';
import 'package:bds_hoan_mobile/configs/_config.dart';
import 'package:bds_hoan_mobile/data/enums/api_call_status.dart';
import 'package:bds_hoan_mobile/presentation/app_container/app_container_member.dart';
import 'package:bds_hoan_mobile/presentation/app_container/app_container_new_user.dart';
import 'package:bds_hoan_mobile/presentation/app_container/widgets/app_drawer.dart';
import 'package:bds_hoan_mobile/presentation/screens/member_role_screens/invite_group_acception/cubit/invite_group_acception_cubit.dart';
import 'package:bds_hoan_mobile/presentation/shared_widgets/buttons/widget.dart';
import 'package:bds_hoan_mobile/presentation/shared_widgets/common/widget.dart';
import 'package:bds_hoan_mobile/presentation/shared_widgets/dialogs/widget.dart';
import 'package:bds_hoan_mobile/presentation/shared_widgets/text_input/app_text_input.dart';
import 'package:bds_hoan_mobile/presentation/shared_widgets/utils/_utils.dart';
import 'package:bds_hoan_mobile/presentation/shared_widgets/utils/util_common.dart';
import 'package:bds_hoan_mobile/presentation/shared_widgets/utils/util_string.dart';
import 'package:bds_hoan_mobile/presentation/shared_widgets/utils/util_validate.dart';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:carousel_slider/carousel_slider.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:url_launcher/url_launcher.dart';

class InviteGroupAcceptionView extends StatefulWidget {
  const InviteGroupAcceptionView({
    Key? key,
  }) : super(key: key);

  @override
  State<InviteGroupAcceptionView> createState() => _InviteGroupAcceptionViewState();
}

class _InviteGroupAcceptionViewState extends State<InviteGroupAcceptionView> {
  late final InviteGroupAcceptionCubit cubit;

  @override
  void initState() {
    super.initState();
    cubit = BlocProvider.of<InviteGroupAcceptionCubit>(context);
  }

  Future<void> _makePhoneCall(String phoneNumber) async {
    final Uri launchUri = Uri(
      scheme: 'tel',
      path: phoneNumber,
    );
    await launchUrl(launchUri);
  }

  void accept() async {
    bool? success = await cubit.acceptGroup(groupId: AppBloc.authenticationCubit.inviteGroup!.id!);

    await Future.delayed(const Duration(milliseconds: 500));
    if (success == true) {
      await showDialog<void>(
        context: context,
        barrierDismissible: false,
        builder: (_) => const SuccessAlertDialog(message: 'Cập nhật thành công'),
      );
      await Future.delayed(const Duration(milliseconds: 500));
      AppBloc.authenticationCubit.onChangeAuthenticationState(AuthenticationState.loading);
      AppBloc.authenticationCubit.onCheck();
    }
  }

  void reject() async {
    bool? success = await cubit.rejectGroup(groupId: AppBloc.authenticationCubit.inviteGroup!.id!);

    await Future.delayed(const Duration(milliseconds: 500));
    if (success == true) {
      await showDialog<void>(
        context: context,
        barrierDismissible: false,
        builder: (_) => const SuccessAlertDialog(message: 'Cập nhật thành công'),
      );
      AppBloc.authenticationCubit.inviteGroup = null;
      await Future.delayed(const Duration(milliseconds: 500));
      AppBloc.authenticationCubit.onChangeAuthenticationState(AuthenticationState.loading);
      AppBloc.authenticationCubit.onCheck();
    }
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
          padding: const EdgeInsets.symmetric(horizontal: AppDimension.kScaffoldHorPadding),
          child: SingleChildScrollView(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                const SizedBox(height: 15),
                const Padding(padding: EdgeInsets.symmetric(horizontal: 40), child: DefaultDivider()),
                const SizedBox(height: 30),
                const Text(
                  'Bạn nhận được lời mời vào nhóm',
                  style: TextStyle(fontSize: 24, color: AppColors.primary, fontWeight: FontWeight.w700),
                ),
                const SizedBox(height: 10),
                _buildTitleMapInfo(title: 'Công ty / Nhóm: ', info: AppBloc.authenticationCubit.inviteGroup?.name),
                _buildTitleMapInfo(title: 'Địa chỉ: ', info: AppBloc.authenticationCubit.inviteGroup?.address),
                Padding(
                  padding: const EdgeInsets.symmetric(vertical: 7),
                  child: Row(
                    children: [
                      Text(
                        'Số điện thoại liên hệ: ',
                        style: AppBloc.applicationCubit.appTextStyle.normal,
                      ),
                      InkWell(
                        onTap: () {
                          if (AppBloc.authenticationCubit.inviteGroup?.contact != null) {
                            _makePhoneCall(AppBloc.authenticationCubit.inviteGroup!.contact!);
                          }
                        },
                        child: Text(
                          AppBloc.authenticationCubit.inviteGroup?.contact ?? '-',
                          style: AppBloc.applicationCubit.appTextStyle.normalBold.copyWith(decoration: TextDecoration.underline),
                        ),
                      ),
                    ],
                  ),
                ),
                const Text(
                  'Quản lý nhóm',
                  style: TextStyle(fontSize: 24, color: AppColors.primary, fontWeight: FontWeight.w700),
                ),
                const SizedBox(height: 10),
                Row(
                  children: [
                    CircleAvatar(
                        backgroundColor: Colors.white,
                        radius: 23.0,
                        child: CircleAvatar(
                            radius: 21.0,
                            child: ClipOval(
                                child: CachedNetworkImage(
                              imageUrl: AppBloc.authenticationCubit.inviteGroup?.owners?.photo ?? '',
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
                            )))),
                    _buildTitleMapInfo(title: ' ', info: AppBloc.authenticationCubit.inviteGroup?.owners?.name),
                  ],
                ),
                Padding(
                  padding: const EdgeInsets.symmetric(vertical: 7),
                  child: Row(
                    children: [
                      Text(
                        'Số điện thoại: ',
                        style: AppBloc.applicationCubit.appTextStyle.normal,
                      ),
                      InkWell(
                        onTap: () {
                          if (AppBloc.authenticationCubit.inviteGroup?.owners?.phoneNumber != null) {
                            _makePhoneCall(AppBloc.authenticationCubit.inviteGroup!.owners!.phoneNumber!);
                          }
                        },
                        child: Text(
                          AppBloc.authenticationCubit.inviteGroup?.owners?.phoneNumber ?? '-',
                          style: AppBloc.applicationCubit.appTextStyle.normalBold.copyWith(decoration: TextDecoration.underline),
                        ),
                      ),
                    ],
                  ),
                ),
                const SizedBox(height: AppDimension.kMediumSizedBoxHeight),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                  children: [
                    BlocBuilder<InviteGroupAcceptionCubit, InviteGroupAcceptionState>(builder: (context, state) {
                      return AppElevatedButton(
                        text: 'Đồng ý',
                        onPressed: accept,
                        radius: AppDimension.kButtonBorderRadius,
                        loading: state.apiCallStatus == ApiCallStatus.loading,
                        disabled: state.apiCallStatus == ApiCallStatus.loading,
                      );
                    }),
                    const SizedBox(height: AppDimension.kMediumSizedBoxHeight),
                    BlocBuilder<InviteGroupAcceptionCubit, InviteGroupAcceptionState>(builder: (context, state) {
                      return AppElevatedButton(
                        text: 'Từ chối',
                        onPressed: reject,
                        radius: AppDimension.kButtonBorderRadius,
                        loading: state.apiCallStatus == ApiCallStatus.loading,
                        disabled: state.apiCallStatus == ApiCallStatus.loading,
                      );
                    })
                  ],
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }

  Widget _buildTitleMapInfo({
    required String? title,
    required String? info,
  }) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 7),
      child: RichText(
        text: TextSpan(
          text: title,
          style: AppBloc.applicationCubit.appTextStyle.normal.copyWith(height: 1.4),
          children: <TextSpan>[
            TextSpan(text: info ?? '-', style: AppBloc.applicationCubit.appTextStyle.normalBold.copyWith(height: 1.4)),
          ],
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
            onTap: () {
              AppBloc.appContainerNewUserCubit.state.scaffoldKey.currentState?.openDrawer();
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
            'Lời mời vào nhóm',
            style: AppBloc.applicationCubit.appTextStyle.mediumBold,
          ),
          const Expanded(child: SizedBox()),
          Text('    ')
        ],
      ),
    );
  }
}
