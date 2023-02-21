import 'package:bds_hoan_mobile/bloc_global/app_bloc.dart';
import 'package:bds_hoan_mobile/configs/_config.dart';
import 'package:bds_hoan_mobile/data/enums/api_call_status.dart';
import 'package:bds_hoan_mobile/presentation/shared_widgets/common/widget.dart';
import 'package:bds_hoan_mobile/presentation/shared_widgets/text_input/app_text_input.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../cubit/add_member_cubit.dart';
import '../cubit/add_member_state.dart';
import 'widgets/member_card.dart';

class AddMemberView extends StatefulWidget {
  const AddMemberView({
    Key? key,
  }) : super(key: key);

  @override
  State<AddMemberView> createState() => _AddMemberViewState();
}

class _AddMemberViewState extends State<AddMemberView> {
  late final AddMemberCubit cubit;
  final _searchEditingController = TextEditingController();

  @override
  void initState() {
    cubit = BlocProvider.of<AddMemberCubit>(context);
    super.initState();
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
          padding: const EdgeInsets.symmetric(
              horizontal: AppDimension.kScaffoldHorPadding),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              const SizedBox(height: 10),
              const Padding(
                padding: EdgeInsets.symmetric(horizontal: 40),
                child: DefaultDivider(),
              ),
              const SizedBox(height: 20),
              const Text(
                'Tìm kiếm thành viên',
                style: TextStyle(
                    fontSize: 24,
                    color: AppColors.primary,
                    fontWeight: FontWeight.w700),
              ),
              const SizedBox(height: 5),
              const SizedBox(height: AppDimension.kSizedBoxHeight),
              AppTextInput(
                controller: _searchEditingController,
                labelText: 'Số điện thoại',
                hintText: 'Nhập số điện thoại cần tìm',
                keyboardType: TextInputType.phone,
                showSearchIcon: true,
                onSufficIconTap: () {
                  cubit.searchUserByPhone(_searchEditingController.text);
                },
                onFieldSubmitted: (String value) {
                  cubit.searchUserByPhone(value);
                },
              ),
              const SizedBox(height: 20),
              BlocBuilder<AddMemberCubit, AddMemberState>(
                builder: (context, state) {
                  if (state.apiCallStatus == ApiCallStatus.loading) {
                    return Padding(
                      padding: EdgeInsets.only(
                          top: MediaQuery.of(context).size.height / 4),
                      child: const Center(
                        child: CircularProgressIndicator(),
                      ),
                    );
                  }
                  if (state.users == null || state.users!.isEmpty) {
                    return const SizedBox.shrink();
                  }
                  return Expanded(
                    child: ListView.builder(
                      padding: const EdgeInsets.only(bottom: 20),
                      itemCount: state.users!.length,
                      itemBuilder: (BuildContext context, int index) {
                        return MemberCard(
                          cubit: cubit,
                          user: state.users![index],
                          isLastMember: index == state.users!.length - 1,
                        );
                      },
                    ),
                  );
                },
              ),
            ],
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
        'Thêm thành viên',
        style: AppBloc.applicationCubit.appTextStyle.mediumBold,
      ),
    );
  }
}
