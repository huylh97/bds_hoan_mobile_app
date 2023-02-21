import 'package:bds_hoan_mobile/bloc_global/app_bloc.dart';
import 'package:bds_hoan_mobile/configs/_config.dart';
import 'package:bds_hoan_mobile/data/enums/api_call_status.dart';
import 'package:bds_hoan_mobile/data/models/group/group_model.dart';
import 'package:bds_hoan_mobile/presentation/shared_widgets/common/widget.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../cubit/dash_board_cubit.dart';
import '../../cubit/dash_board_state.dart';
import '../create_group_form/view/create_group_form.dart';
import '../../../../member_role_screens/group_info/view/widgets/confirm_out_group_dialog.dart';
import '../widgets/widgets.dart';

class GroupInfoTab extends StatefulWidget {
  const GroupInfoTab({
    Key? key,
  }) : super(key: key);

  @override
  State<GroupInfoTab> createState() => _GroupInfoTabState();
}

class _GroupInfoTabState extends State<GroupInfoTab> {
  late final DashBoardCubit cubit;

  @override
  void initState() {
    super.initState();
    cubit = BlocProvider.of<DashBoardCubit>(context);
    cubit.fetchGroupInfo();
  }

  @override
  Widget build(BuildContext context) {
    return BlocSelector<DashBoardCubit, DashBoardState, GroupInfoType>(
        selector: (state) => state.groupInfoType,
        builder: (context, groupInfoType) {
          return Scaffold(
            backgroundColor: AppColors.scaffoldBgColor,
            resizeToAvoidBottomInset: false,
            appBar: _buildAppBar(context),
            body: SingleChildScrollView(
              child: Padding(
                padding: const EdgeInsets.symmetric(horizontal: AppDimension.kScaffoldHorPadding),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    const SizedBox(height: 15),
                    const Padding(
                      padding: EdgeInsets.symmetric(horizontal: 40),
                      child: DefaultDivider(),
                    ),
                    const SizedBox(height: 25),
                    Row(
                      children: [
                        Expanded(
                          child: TabButton(
                            text: 'Thông tin nhóm',
                            borderRadius: const BorderRadius.only(
                              topLeft: Radius.circular(8),
                              bottomLeft: Radius.circular(8),
                            ),
                            isSelected: true,
                            onTap: () => cubit.selectTab(TabType.groupInfo),
                          ),
                        ),
                        Expanded(
                          child: TabButton(
                            text: 'Quản lý thành viên',
                            borderRadius: const BorderRadius.only(
                              topRight: Radius.circular(8),
                              bottomRight: Radius.circular(8),
                            ),
                            isSelected: false,
                            onTap: () => cubit.selectTab(TabType.manageMember),
                          ),
                        ),
                      ],
                    ),
                    const SizedBox(height: 25),
                    BlocBuilder<DashBoardCubit, DashBoardState>(
                      buildWhen: (previous, current) =>
                          previous.groupInfoType != current.groupInfoType || previous.apiCallStatus != current.apiCallStatus,
                      builder: (context, state) {
                        if (state.apiCallStatus == ApiCallStatus.loading) {
                          return Padding(
                            padding: EdgeInsets.only(top: MediaQuery.of(context).size.height / 4),
                            child: const Center(
                              child: CircularProgressIndicator(),
                            ),
                          );
                        }
                        if (groupInfoType == GroupInfoType.form) {
                          return const CreateGroupForm();
                        }
                        if (groupInfoType == GroupInfoType.profile) {
                          return GroupInfoWidget(
                            groupModel: state.groupModel,
                          );
                        }

                        return const GroupInfoIntroduction();
                      },
                    ),
                    const SizedBox(height: 25),
                  ],
                ),
              ),
            ),
          );
        });
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
            'Thông tin nhóm',
            style: AppBloc.applicationCubit.appTextStyle.mediumBold,
          ),
          const Expanded(child: SizedBox()),
          BlocSelector<DashBoardCubit, DashBoardState, GroupModel?>(
              selector: (state) => state.groupModel,
              builder: (context, groupModel) {
                if (groupModel == null) {
                  return const SizedBox.shrink();
                }
                return PopupMenuButton<String>(
                  onSelected: (String item) {},
                  child: const Icon(Icons.more_vert, color: AppColors.primary, size: 30),
                  shape: const RoundedRectangleBorder(borderRadius: BorderRadius.all(Radius.circular(10))),
                  itemBuilder: (BuildContext context) => <PopupMenuEntry<String>>[
                    PopupMenuItem<String>(
                      value: 'edit',
                      onTap: () async {
                        await Future.delayed(const Duration(milliseconds: 500));
                        cubit.selectGroupInfoType(GroupInfoType.form);
                      },
                      child: const Text(
                        'Sửa thông tin',
                        style: TextStyle(color: AppColors.kTextColor),
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
