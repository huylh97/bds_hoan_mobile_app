import 'package:bds_hoan_mobile/bloc_global/app_bloc.dart';
import 'package:bds_hoan_mobile/configs/_config.dart';
import 'package:bds_hoan_mobile/data/enums/api_call_status.dart';
import 'package:bds_hoan_mobile/data/models/group/group_model.dart';
import 'package:bds_hoan_mobile/presentation/screens/admin_role_screens/dashboard/cubit/dash_board_state.dart';
import 'package:bds_hoan_mobile/presentation/screens/member_role_screens/group_info/view/widgets/confirm_out_group_dialog.dart';
import 'package:bds_hoan_mobile/presentation/shared_widgets/common/widget.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../cubit/group_info_cubit.dart';
import '../cubit/group_info_state.dart';
import 'widgets/group_info_introduction.dart';
import 'widgets/group_info_widget.dart';

class GroupInfoView extends StatefulWidget {
  const GroupInfoView({
    Key? key,
  }) : super(key: key);

  @override
  State<GroupInfoView> createState() => _GroupInfoViewState();
}

class _GroupInfoViewState extends State<GroupInfoView> {
  late final GroupInfoCubit cubit;

  @override
  void initState() {
    super.initState();
    cubit = BlocProvider.of<GroupInfoCubit>(context);
    cubit.fetchGroupInfo();
  }

  void confirmOutGroup() async {
    final confirmed = await showDialog<bool>(
      context: context,
      barrierDismissible: false,
      builder: (_) => const ConfirmOutGroupDialog(),
    );
    if (confirmed == true) {
      cubit.leaveGroup();
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
                BlocBuilder<GroupInfoCubit, GroupInfoState>(
                  builder: (context, state) {
                    if (state.apiCallStatus == ApiCallStatus.loading) {
                      return Padding(
                        padding: EdgeInsets.only(top: MediaQuery.of(context).size.height / 4),
                        child: const Center(
                          child: CircularProgressIndicator(),
                        ),
                      );
                    }
                    if (state.groupInfoType == GroupInfoType.profile) {
                      return GroupInfoWidget(
                        groupModel: state.groupModel,
                      );
                    }
                    return const GroupInfoIntroduction();
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
      title: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          InkWell(
            splashColor: Colors.white,
            highlightColor: Colors.white,
            onTap: () => AppBloc.appContainerMemberCubit.state.scaffoldKey.currentState?.openDrawer(),
            child: Container(
              padding: const EdgeInsets.all(8),
              decoration: BoxDecoration(
                border: Border.all(color: AppColors.boxBorder),
                borderRadius: BorderRadius.circular(12),
              ),
              child: const Icon(Icons.menu, color: Color(0xFF374957)),
            ),
          ),
          Text(
            'Thông tin nhóm',
            style: AppBloc.applicationCubit.appTextStyle.mediumBold,
          ),
          BlocSelector<GroupInfoCubit, GroupInfoState, GroupModel?>(
              selector: (state) => state.groupModel,
              builder: (context, groupModel) {
                return groupModel == null
                    ? const SizedBox.shrink()
                    : PopupMenuButton<String>(
                        onSelected: (String item) {},
                        child: const Icon(Icons.more_vert, color: AppColors.primary, size: 30),
                        shape: const RoundedRectangleBorder(borderRadius: BorderRadius.all(Radius.circular(10))),
                        itemBuilder: (BuildContext context) => <PopupMenuEntry<String>>[
                          PopupMenuItem<String>(
                            value: 'outGroup',
                            onTap: () async {
                              await Future.delayed(const Duration(milliseconds: 500));
                              confirmOutGroup();
                            },
                            child: const Text(
                              'Rời nhóm',
                              style: TextStyle(color: Color(0xffDC1515)),
                            ),
                          ),
                        ],
                      );
              }),
        ],
      ),
    );
  }
}
