import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../cubit/dash_board_cubit.dart';
import '../cubit/dash_board_state.dart';
import 'tab_views/group_info_tab.dart';
import 'tab_views/manage_member_tab.dart';

class DashBoardView extends StatefulWidget {
  const DashBoardView({Key? key}) : super(key: key);

  @override
  _DashBoardViewState createState() {
    return _DashBoardViewState();
  }
}

class _DashBoardViewState extends State<DashBoardView> {
  late final DashBoardCubit cubit;

  @override
  void initState() {
    cubit = BlocProvider.of<DashBoardCubit>(context);
    super.initState();
  }

  @override
  void dispose() {
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return BlocSelector<DashBoardCubit, DashBoardState, TabType>(
      selector: (state) => state.selectedTabType,
      builder: (context, _selectedTabType) {
        if (_selectedTabType == TabType.groupInfo) {
          return const GroupInfoTab();
        } else {
          return const ManageMemberTab();
        }
      },
    );
  }
}
