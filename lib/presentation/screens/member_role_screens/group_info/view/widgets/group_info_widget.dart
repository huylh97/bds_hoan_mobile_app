import 'package:bds_hoan_mobile/bloc_global/app_bloc.dart';
import 'package:bds_hoan_mobile/configs/_config.dart';
import 'package:bds_hoan_mobile/data/models/group/group_model.dart';
import 'package:bds_hoan_mobile/presentation/shared_widgets/utils/_utils.dart';
import 'package:flutter/material.dart';
import 'package:url_launcher/url_launcher.dart';

class GroupInfoWidget extends StatelessWidget {
  final GroupModel? groupModel;
  const GroupInfoWidget({Key? key, required this.groupModel}) : super(key: key);

  Future<void> _makePhoneCall(String phoneNumber) async {
    final Uri launchUri = Uri(
      scheme: 'tel',
      path: phoneNumber,
    );
    await launchUrl(launchUri);
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        const Text(
          'Thông tin đội nhóm',
          style: TextStyle(fontSize: 24, color: AppColors.primary, fontWeight: FontWeight.w700),
        ),
        const SizedBox(height: 10),
        _buildTitleMapInfo(title: 'Công ty / Nhóm: ', info: groupModel?.name),
        _buildTitleMapInfo(title: 'Ngày hoạt động: ', info: UtilDateTime.formatDateTime(groupModel?.createdAt)),
        _buildTitleMapInfo(title: 'Địa chỉ: ', info: groupModel?.address),
        _buildTitleMapInfo(title: 'Trưởng nhóm: ', info: groupModel?.owners?.name),
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
                  if (groupModel?.contact != null) {
                    _makePhoneCall(groupModel!.contact!);
                  }
                },
                child: Text(
                  groupModel?.contact ?? '-',
                  style: AppBloc.applicationCubit.appTextStyle.normalBold.copyWith(decoration: TextDecoration.underline),
                ),
              ),
            ],
          ),
        ),
        groupModel?.isEnterprise == true
            ? Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  const SizedBox(height: 10),
                  Text(
                    'Thông tin doanh nghiệp',
                    style: AppBloc.applicationCubit.appTextStyle.mediumBold,
                  ),
                  const SizedBox(height: 5),
                  _buildTitleMapInfo(title: 'Mã số thuế: ', info: groupModel?.taxCode),
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
                            if (groupModel?.contact != null) {
                              _makePhoneCall(groupModel!.contact!);
                            }
                          },
                          child: Text(
                            groupModel?.enterprisePhone ?? '-',
                            style: AppBloc.applicationCubit.appTextStyle.normalBold.copyWith(decoration: TextDecoration.underline),
                          ),
                        ),
                      ],
                    ),
                  ),
                  _buildTitleMapInfo(title: 'Email liên hệ: ', info: groupModel?.enterpriseEmail),
                ],
              )
            : const SizedBox.shrink(),
        const SizedBox(height: 30),
      ],
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
}
