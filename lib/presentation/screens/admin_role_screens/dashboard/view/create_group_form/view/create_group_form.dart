import 'dart:io';

import 'package:bds_hoan_mobile/bloc_global/application/app_text_style.dart';
import 'package:bds_hoan_mobile/configs/_config.dart';
import 'package:bds_hoan_mobile/data/enums/api_call_status.dart';
import 'package:bds_hoan_mobile/data/models/group/create_group_params.dart';
import 'package:bds_hoan_mobile/presentation/shared_widgets/buttons/app_elevated_button.dart';
import 'package:bds_hoan_mobile/presentation/shared_widgets/dialogs/widget.dart';
import 'package:bds_hoan_mobile/presentation/shared_widgets/text_input/app_text_input.dart';
import 'package:bds_hoan_mobile/presentation/shared_widgets/utils/util_validate.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../cubit/dash_board_cubit.dart';
import '../../../cubit/dash_board_state.dart';
import '../cubit/create_group_form_cubit.dart';
import '../cubit/create_group_form_state.dart';

class CreateGroupForm extends StatefulWidget {
  const CreateGroupForm({Key? key}) : super(key: key);

  @override
  State<CreateGroupForm> createState() => _CreateGroupFormState();
}

class _CreateGroupFormState extends State<CreateGroupForm> {
  late final DashBoardCubit dashBoardCubit;
  late final CreateGroupFormCubit cubit;
  final _formKey = GlobalKey<FormState>();
  final TextEditingController _nameEditingController = TextEditingController();
  final TextEditingController _phoneEditingController = TextEditingController();
  final TextEditingController _addressEditingController = TextEditingController();
  final TextEditingController _taxCodeEditingController = TextEditingController();
  final TextEditingController _phoneCompanyEditingController = TextEditingController();
  final TextEditingController _emailCompanyEditingController = TextEditingController();
  bool isCreate = true;

  @override
  void initState() {
    super.initState();
    dashBoardCubit = BlocProvider.of<DashBoardCubit>(context);
    cubit = CreateGroupFormCubit();
    isCreate = dashBoardCubit.state.groupModel == null;

    if (!isCreate) {
      final _groupModel = dashBoardCubit.state.groupModel;
      cubit.initCubitState(dashBoardCubit.state.groupModel);
      _nameEditingController.text = _groupModel?.name ?? '';
      _phoneEditingController.text = _groupModel?.contact ?? '';
      _addressEditingController.text = _groupModel?.address ?? '';
      _taxCodeEditingController.text = _groupModel?.taxCode ?? '';
      _phoneCompanyEditingController.text = _groupModel?.enterprisePhone ?? '';
      _emailCompanyEditingController.text = _groupModel?.enterpriseEmail ?? '';
    }
  }

  @override
  void dispose() {
    super.dispose();
    _nameEditingController.dispose();
    _phoneEditingController.dispose();
    _addressEditingController.dispose();
    _taxCodeEditingController.dispose();
    _phoneCompanyEditingController.dispose();
    _emailCompanyEditingController.dispose();
  }

  void onPressSave() async {
    bool _isEnterprise = cubit.state.isCompany;
    if (isCreate) {
      bool? result = await cubit.createGroup(CreateGroupParams(
        name: _nameEditingController.text,
        contact: _phoneEditingController.text,
        address: _addressEditingController.text,
        isEnterprise: _isEnterprise,
        taxCode: _isEnterprise ? _taxCodeEditingController.text : '',
        enterprisePhone: _isEnterprise ? _phoneCompanyEditingController.text : '',
        enterpriseMail: _isEnterprise ? _emailCompanyEditingController.text : '',
      ));
      if (result == true) {
        showDialog<void>(
          context: context,
          barrierDismissible: false,
          builder: (_) => const SuccessAlertDialog(message: 'Bạn đã tạo nhóm thành công'),
        );
        dashBoardCubit.fetchGroupInfo();
      }
    } else {
      final result = await cubit.updateGroupInfo(CreateGroupParams(
        name: _nameEditingController.text,
        contact: _phoneEditingController.text,
        address: _addressEditingController.text,
        isEnterprise: _isEnterprise,
        taxCode: _isEnterprise == true ? _taxCodeEditingController.text : '',
        enterprisePhone: _isEnterprise == true ? _phoneCompanyEditingController.text : '',
        enterpriseMail: _isEnterprise == true ? _emailCompanyEditingController.text : '',
      ));
      if (result == true) {
        showDialog<void>(
          context: context,
          barrierDismissible: false,
          builder: (_) => const SuccessAlertDialog(message: 'Bạn đã cập nhật thành công'),
        );
        dashBoardCubit.fetchGroupInfo();
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    return BlocProvider.value(
      value: cubit,
      child: GestureDetector(
        onTap: () {
          FocusScope.of(context).unfocus();
        },
        child: SingleChildScrollView(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Row(
                children: [
                  InkWell(
                    onTap: () {
                      if (dashBoardCubit.state.groupModel != null) {
                        dashBoardCubit.selectGroupInfoType(GroupInfoType.profile);
                      } else {
                        dashBoardCubit.selectGroupInfoType(GroupInfoType.introduction);
                      }
                    },
                    child: Icon(
                      Platform.isIOS ? Icons.arrow_back_ios : Icons.arrow_back,
                      color: AppColors.primary,
                    ),
                  ),
                  const SizedBox(width: 15),
                  Text(
                    dashBoardCubit.state.groupModel != null ? 'Sửa thông tin nhóm' : 'Tạo nhóm',
                    style: const TextStyle(fontSize: 24, color: AppColors.primary, fontWeight: FontWeight.w700),
                  ),
                ],
              ),
              const SizedBox(height: 30),
              Form(
                key: _formKey,
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    AppTextInput(
                      controller: _nameEditingController,
                      labelText: 'Tên nhóm / Công ty',
                      validateType: ValidateType.nameGroup,
                      keyboardType: TextInputType.text,
                    ),
                    const SizedBox(height: AppDimension.kTextFormFieldMargin),
                    AppTextInput(
                      controller: _phoneEditingController,
                      labelText: 'Số điện thoại',
                      keyboardType: TextInputType.phone,
                      validateType: ValidateType.phone,
                    ),
                    const SizedBox(height: AppDimension.kTextFormFieldMargin),
                    AppTextInput(
                      controller: _addressEditingController,
                      labelText: 'Địa chỉ',
                      validateType: ValidateType.address,
                      keyboardType: TextInputType.text,
                    ),
                    const SizedBox(height: AppDimension.kTextFormFieldMargin),
                    BlocSelector<CreateGroupFormCubit, CreateGroupFormState, bool?>(
                      selector: (state) => state.isCompany,
                      builder: (context, isCompany) {
                        return Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            _buildCheckBox(),
                            const SizedBox(height: AppDimension.kTextFormFieldMargin),
                            AppTextInput(
                              controller: _taxCodeEditingController,
                              labelText: 'Mã số thuế',
                              keyboardType: TextInputType.name,
                              validateType: isCompany == true ? ValidateType.taxCode : null,
                              enable: isCompany,
                            ),
                            const SizedBox(height: AppDimension.kTextFormFieldMargin),
                            AppTextInput(
                              controller: _phoneCompanyEditingController,
                              labelText: 'Số điện thoại',
                              keyboardType: TextInputType.phone,
                              validateType: isCompany == true ? ValidateType.phone : null,
                              enable: isCompany,
                            ),
                            const SizedBox(height: AppDimension.kTextFormFieldMargin),
                            AppTextInput(
                              controller: _emailCompanyEditingController,
                              labelText: 'Email liên hệ',
                              keyboardType: TextInputType.name,
                              validateType: isCompany == true ? ValidateType.email : null,
                              enable: isCompany,
                            ),
                          ],
                        );
                      },
                    ),
                    const SizedBox(height: AppDimension.kTextFormFieldMargin + 10),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        BlocSelector<CreateGroupFormCubit, CreateGroupFormState, ApiCallStatus>(
                            selector: (state) => state.apiCallStatus,
                            builder: (context, apiCallStatus) {
                              return AppElevatedButton(
                                text: 'Lưu thông tin',
                                onPressed: () {
                                  if (_formKey.currentState!.validate()) {
                                    onPressSave();
                                  }
                                },
                                radius: AppDimension.kButtonBorderRadius,
                                loading: apiCallStatus == ApiCallStatus.loading,
                              );
                            }),
                      ],
                    ),
                    const SizedBox(height: AppDimension.kTextFormFieldMargin),
                  ],
                ),
              )
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildCheckBox() {
    return BlocSelector<CreateGroupFormCubit, CreateGroupFormState, bool>(
        selector: (state) => state.isCompany,
        builder: (context, isCompany) {
          return InkWell(
            splashColor: Colors.transparent,
            highlightColor: Colors.transparent,
            onTap: () {
              cubit.onToggleIsCompany();
            },
            child: Wrap(
              crossAxisAlignment: WrapCrossAlignment.center,
              children: [
                Container(
                  width: 22,
                  height: 22,
                  margin: const EdgeInsets.symmetric(vertical: 5),
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(4.0),
                    border: isCompany ? null : Border.all(color: AppColors.primary, width: 2),
                    color: isCompany ? AppColors.primary : null,
                  ),
                  child: isCompany
                      ? const Icon(
                          Icons.check,
                          size: 20.0,
                          color: Colors.white,
                        )
                      : null,
                ),
                const SizedBox(width: 12),
                Text(
                  'Chúng tôi là doanh nghiệp',
                  style: TextStyle(
                    color: Colors.black,
                    fontSize: AppTextStyle.smallFontSize,
                  ),
                ),
              ],
            ),
          );
        });
  }
}
