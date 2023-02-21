import 'package:bds_hoan_mobile/bloc_global/app_bloc.dart';
import 'package:bds_hoan_mobile/configs/_config.dart';
import 'package:bds_hoan_mobile/presentation/shared_widgets/buttons/app_elevated_button.dart';
import 'package:bds_hoan_mobile/presentation/shared_widgets/common/default_divider.dart';
import 'package:bds_hoan_mobile/presentation/shared_widgets/text_input/app_text_input.dart';
import 'package:bds_hoan_mobile/presentation/shared_widgets/utils/util_validate.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../cubit/change_password_cubit.dart';
import '../cubit/change_password_state.dart';

class ChangePasswordView extends StatefulWidget {
  const ChangePasswordView({Key? key}) : super(key: key);

  @override
  _ChangePasswordViewState createState() {
    return _ChangePasswordViewState();
  }
}

class _ChangePasswordViewState extends State<ChangePasswordView> {
  late final ChangePasswordCubit cubit;
  final _formKey = GlobalKey<FormState>();
  final TextEditingController _passwordEditingController = TextEditingController();
  final TextEditingController _newPasswordEditingController = TextEditingController();
  final TextEditingController _confirmNewPasswordEditingController = TextEditingController();

  @override
  void initState() {
    cubit = BlocProvider.of<ChangePasswordCubit>(context);
    super.initState();
  }

  @override
  void dispose() {
    super.dispose();
  }

  void changePassword() async {
    cubit.changePassword(
      password: _passwordEditingController.text,
      newPassword: _newPasswordEditingController.text,
      confirmNewPassword: _confirmNewPasswordEditingController.text,
    );
  }

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        FocusScope.of(context).requestFocus(FocusNode());
      },
      child: Scaffold(
        backgroundColor: AppColors.scaffoldBgColor,
        appBar: _buildAppBar(context),
        body: SingleChildScrollView(
          child: Padding(
            padding: const EdgeInsets.symmetric(horizontal: AppDimension.kScaffoldHorPadding),
            child: Column(
              children: [
                Form(
                  key: _formKey,
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: <Widget>[
                      const SizedBox(height: 10),
                      const Padding(padding: EdgeInsets.symmetric(horizontal: 40), child: DefaultDivider()),
                      const SizedBox(height: AppDimension.kLargeSizedBoxHeight),
                      Padding(
                        padding: const EdgeInsets.only(left: 8.0),
                        child: Text('Mật khẩu', style: AppBloc.applicationCubit.appTextStyle.normalBold),
                      ),
                      const SizedBox(height: AppDimension.kSizedBoxHeight),
                      AppTextInput(
                        controller: _passwordEditingController,
                        hintText: 'Nhập mật khẩu',
                        obscureText: true,
                        maxLines: 1,
                        validateType: ValidateType.password,
                      ),
                      const SizedBox(height: AppDimension.kTextFormFieldMargin),
                      Padding(
                        padding: const EdgeInsets.only(left: 8.0),
                        child: Text('Mật khẩu mới', style: AppBloc.applicationCubit.appTextStyle.normalBold),
                      ),
                      const SizedBox(height: AppDimension.kSizedBoxHeight),
                      AppTextInput(
                        controller: _newPasswordEditingController,
                        hintText: 'Nhập mật khẩu mới',
                        obscureText: true,
                        maxLines: 1,
                        validateType: ValidateType.password,
                      ),
                      const SizedBox(height: AppDimension.kTextFormFieldMargin),
                      Padding(
                        padding: const EdgeInsets.only(left: 8.0),
                        child: Text('Xác nhận mật khẩu mới', style: AppBloc.applicationCubit.appTextStyle.normalBold),
                      ),
                      const SizedBox(height: AppDimension.kSizedBoxHeight),
                      AppTextInput(
                        controller: _confirmNewPasswordEditingController,
                        hintText: 'Nhập lại mật khẩu mới',
                        obscureText: true,
                        maxLines: 1,
                        validateType: ValidateType.confirmPassword,
                        validateExtraContronller: _newPasswordEditingController,
                      ),
                      const SizedBox(height: AppDimension.kTextFormFieldMargin),
                      const SizedBox(height: AppDimension.kTextFormFieldMargin),
                      BlocBuilder<ChangePasswordCubit, ChangePasswordState>(builder: (context, state) {
                        return AppElevatedButton(
                          text: 'Lưu thông tin',
                          onPressed: () {
                            FocusScope.of(context).requestFocus(FocusNode());
                            if (_formKey.currentState!.validate()) {
                              changePassword();
                            }
                          },
                          radius: AppDimension.kButtonBorderRadius,
                          loading: state.loadingStatus == ChangePasswordLoadingStatus.loading,
                          disabled: state.loadingStatus == ChangePasswordLoadingStatus.loading,
                        );
                      }),
                      const SizedBox(height: 16),
                    ],
                  ),
                )
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
        'Thay đổi mật khẩu',
        style: AppBloc.applicationCubit.appTextStyle.mediumBold,
      ),
    );
  }
}
