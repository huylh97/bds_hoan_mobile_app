import 'package:bds_hoan_mobile/bloc_global/app_bloc.dart';
import 'package:bds_hoan_mobile/bloc_global/application/app_text_style.dart';
import 'package:bds_hoan_mobile/bloc_global/authentication/authentication_cubit.dart';
import 'package:bds_hoan_mobile/configs/app_colors.dart';
import 'package:bds_hoan_mobile/configs/app_dimension.dart';
import 'package:bds_hoan_mobile/presentation/screens/register/cubit/register_cubit.dart';
import 'package:bds_hoan_mobile/presentation/screens/register/cubit/register_state.dart';
import 'package:bds_hoan_mobile/presentation/shared_widgets/buttons/widget.dart';
import 'package:bds_hoan_mobile/presentation/shared_widgets/dialogs/success_alert_dialog.dart';
import 'package:bds_hoan_mobile/presentation/shared_widgets/text_input/app_text_input.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:bds_hoan_mobile/presentation/shared_widgets/utils/_utils.dart';
import 'package:url_launcher/url_launcher.dart';

class RegisterFormWidget extends StatefulWidget {
  const RegisterFormWidget({Key? key}) : super(key: key);

  @override
  State<RegisterFormWidget> createState() => _RegisterFormWidgetState();
}

class _RegisterFormWidgetState extends State<RegisterFormWidget> {
  final _formKey = GlobalKey<FormState>();
  final TextEditingController _phoneEditingController = TextEditingController();
  final TextEditingController _nameEditingController = TextEditingController();
  final TextEditingController _passwordEditingController = TextEditingController();
  final TextEditingController _confirmPasswordEditingController = TextEditingController();
  late final RegisterCubit cubit;

  @override
  void initState() {
    cubit = BlocProvider.of<RegisterCubit>(context);
    super.initState();
  }

  @override
  void dispose() {
    super.dispose();
    _phoneEditingController.dispose();
    _nameEditingController.dispose();
    _passwordEditingController.dispose();
    _confirmPasswordEditingController.dispose();
  }

  Future<void> onRegister() async {
    final isSuccess = await cubit.onRegister(
      phoneNumber: _phoneEditingController.text,
      name: _nameEditingController.text,
      password: _passwordEditingController.text,
      confirmPassword: _confirmPasswordEditingController.text,
    );
    if (isSuccess == true) {
      await showDialog<void>(
        context: context,
        barrierDismissible: false,
        builder: (_) => const SuccessAlertDialog(message: 'Bạn đã đăng ký thành công'),
      );
      await Future.delayed(const Duration(milliseconds: 500));
      AppBloc.authenticationCubit.onChangeAuthenticationState(AuthenticationState.onLogin);
    }
  }

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<RegisterCubit, RegisterState>(
      builder: (context, state) {
        return Form(
          key: _formKey,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: <Widget>[
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Text(
                    'Đăng ký',
                    style: TextStyle(
                      fontSize: AppTextStyle.extraLargeFontSize + 5,
                      color: AppColors.primary,
                      fontWeight: FontWeight.w700,
                    ),
                  ),
                ],
              ),
              const SizedBox(height: AppDimension.kLargeSizedBoxHeight),
              AppTextInput(
                controller: _phoneEditingController,
                hintText: 'Nhập số điện thoại',
                labelText: 'Số điện thoại',
                keyboardType: TextInputType.phone,
                validateType: ValidateType.phone,
              ),
              const SizedBox(height: AppDimension.kTextFormFieldMargin),
              AppTextInput(
                controller: _nameEditingController,
                hintText: 'Nhập họ tên',
                labelText: 'Họ tên',
                keyboardType: TextInputType.name,
                validateType: ValidateType.name,
              ),
              const SizedBox(height: AppDimension.kTextFormFieldMargin),
              AppTextInput(
                controller: _passwordEditingController,
                labelText: 'Mật khẩu',
                hintText: 'Nhập mật khẩu',
                obscureText: true,
                maxLines: 1,
                validateType: ValidateType.password,
              ),
              const SizedBox(height: AppDimension.kTextFormFieldMargin),
              AppTextInput(
                controller: _confirmPasswordEditingController,
                labelText: 'Xác nhận mật khẩu',
                hintText: 'Nhập lại mật khẩu',
                obscureText: true,
                maxLines: 1,
                validateType: ValidateType.confirmPassword,
                validateExtraContronller: _passwordEditingController,
              ),
              const SizedBox(height: AppDimension.kTextFormFieldMargin),
              _buildCheckBox(),
              const SizedBox(height: AppDimension.kTextFormFieldMargin),
              AppElevatedButton(
                text: 'Đăng ký',
                onPressed: () {
                  if (_formKey.currentState!.validate()) {
                    onRegister();
                  }
                },
                radius: AppDimension.kButtonBorderRadius,
                loading: state.loadingStatus == RegisterLoadingStatus.loading,
                disabled: state.confirmPrivacy == false || state.loadingStatus == RegisterLoadingStatus.loading,
              ),
              const SizedBox(height: AppDimension.kTextFormFieldMargin),
              Padding(
                padding: const EdgeInsets.only(left: 2.0),
                child: InkWell(
                  onTap: () {
                    AppBloc.authenticationCubit.onChangeAuthenticationState(AuthenticationState.onLogin);
                  },
                  child: Text(
                    'Đã có tài khoản? Đăng nhập',
                    style: TextStyle(
                      fontSize: AppTextStyle.smallFontSize,
                      color: AppColors.primary,
                      decoration: TextDecoration.underline,
                    ),
                  ),
                ),
              ),
              const SizedBox(height: 16),
            ],
          ),
        );
      },
    );
  }

  Widget _buildCheckBox() {
    return BlocSelector<RegisterCubit, RegisterState, bool>(
        selector: (state) => state.confirmPrivacy,
        builder: (context, _confirmPrivacy) {
          return InkWell(
            splashColor: Colors.transparent,
            highlightColor: Colors.transparent,
            onTap: () {
              cubit.onToggleConfirmPrivacy();
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
                    border: _confirmPrivacy ? null : Border.all(color: AppColors.primary, width: 2),
                    color: _confirmPrivacy ? AppColors.primary : null,
                  ),
                  child: _confirmPrivacy
                      ? const Icon(
                          Icons.check,
                          size: 20.0,
                          color: Colors.white,
                        )
                      : null,
                ),
                const SizedBox(width: 12),
                Text(
                  'Tôi đã đọc và đồng ý với ',
                  style: TextStyle(
                    color: AppColors.kTextColor,
                    fontSize: AppTextStyle.smallFontSize,
                  ),
                ),
                InkWell(
                  splashColor: Colors.transparent,
                  highlightColor: Colors.transparent,
                  onTap: () async {
                    final Uri toLaunch = Uri(scheme: 'https', host: 'www.google.com');
                    if (!await launchUrl(
                      toLaunch,
                      mode: LaunchMode.externalApplication,
                    )) {
                      throw 'Could not launch $toLaunch';
                    }
                  },
                  child: Text(
                    'Điều khoản sử dụng',
                    style: TextStyle(
                      color: AppColors.primary,
                      fontSize: AppTextStyle.smallFontSize,
                      decoration: TextDecoration.underline,
                    ),
                  ),
                ),
              ],
            ),
          );
        });
  }
}
