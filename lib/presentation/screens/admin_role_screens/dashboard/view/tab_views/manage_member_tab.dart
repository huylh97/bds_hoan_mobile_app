import 'package:bds_hoan_mobile/bloc_global/app_bloc.dart';
import 'package:bds_hoan_mobile/configs/_config.dart';
import 'package:bds_hoan_mobile/data/models/group/group_model.dart';
import 'package:bds_hoan_mobile/presentation/shared_widgets/common/widget.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../cubit/dash_board_cubit.dart';
import '../../cubit/dash_board_state.dart';
import '../widgets/widgets.dart';

class ManageMemberTab extends StatefulWidget {
  const ManageMemberTab({
    Key? key,
  }) : super(key: key);

  @override
  State<ManageMemberTab> createState() => _ManageMemberTabState();
}

class _ManageMemberTabState extends State<ManageMemberTab> {
  late final DashBoardCubit cubit;

  @override
  void initState() {
    cubit = BlocProvider.of<DashBoardCubit>(context);
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.scaffoldBgColor,
      appBar: _buildAppBar(context),
      body: Padding(
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
                    borderRadius: const BorderRadius.only(topLeft: Radius.circular(8), bottomLeft: Radius.circular(8)),
                    isSelected: false,
                    onTap: () => cubit.selectTab(TabType.groupInfo),
                  ),
                ),
                Expanded(
                  child: TabButton(
                    text: 'Quản lý thành viên',
                    borderRadius: const BorderRadius.only(topRight: Radius.circular(8), bottomRight: Radius.circular(8)),
                    isSelected: true,
                    onTap: () => cubit.selectTab(TabType.manageMember),
                  ),
                ),
              ],
            ),
            const SizedBox(height: 20),
            const Text(
              'Danh sách thành viên',
              style: TextStyle(fontSize: 24, color: AppColors.primary, fontWeight: FontWeight.w700),
            ),
            const SizedBox(height: 5),
            BlocSelector<DashBoardCubit, DashBoardState, GroupModel?>(
              selector: (state) => state.groupModel,
              builder: (context, groupModel) {
                if (groupModel == null) {
                  return Text(
                    'Bạn chưa nằm trong nhóm nào',
                    style: AppBloc.applicationCubit.appTextStyle.normal.copyWith(color: const Color(0xFF555252)),
                  );
                }
                return Text(
                  '${groupModel.members?.length ?? 0}/10 thành viên',
                  style: AppBloc.applicationCubit.appTextStyle.normal.copyWith(color: const Color(0xFF555252)),
                );
              },
            ),
            const SizedBox(height: 10),
            BlocSelector<DashBoardCubit, DashBoardState, GroupModel?>(
                selector: (state) => state.groupModel,
                builder: (context, groupModel) {
                  if (groupModel == null || groupModel.members == null || groupModel.members!.isEmpty) {
                    return const SizedBox.shrink();
                  }
                  return Expanded(
                    child: ListView.builder(
                      padding: EdgeInsets.zero,
                      itemCount: groupModel.members!.length,
                      itemBuilder: (BuildContext context, int index) {
                        return MemberCard(
                          cubit: cubit,
                          isLastMember: index == groupModel.members!.length - 1,
                          user: groupModel.members![index],
                        );
                      },
                    ),
                  );
                }),
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
        crossAxisAlignment: CrossAxisAlignment.center,
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
            'Quản lý thành viên',
            style: AppBloc.applicationCubit.appTextStyle.mediumBold,
          ),
          const Expanded(child: SizedBox()),
          InkWell(
            splashColor: Colors.white,
            highlightColor: Colors.white,
            onTap: () {
              Navigator.pushNamed(context, Routes.addMember).then((value) {
                cubit.fetchGroupInfo(enableLoading: false);
              });
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
