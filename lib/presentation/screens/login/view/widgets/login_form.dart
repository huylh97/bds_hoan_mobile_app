import 'package:bds_hoan_mobile/bloc_global/app_bloc.dart';
import 'package:bds_hoan_mobile/bloc_global/application/app_text_style.dart';
import 'package:bds_hoan_mobile/bloc_global/bloc.dart';
import 'package:bds_hoan_mobile/configs/app_colors.dart';
import 'package:bds_hoan_mobile/configs/app_dimension.dart';
import 'package:bds_hoan_mobile/presentation/shared_widgets/buttons/widget.dart';
import 'package:bds_hoan_mobile/presentation/shared_widgets/text_input/app_text_input.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:bds_hoan_mobile/presentation/screens/login/cubit/login_cubit.dart';
import 'package:bds_hoan_mobile/presentation/screens/login/cubit/login_state.dart';
import 'package:bds_hoan_mobile/presentation/shared_widgets/utils/_utils.dart';
import 'package:fluttertoast/fluttertoast.dart';

class LoginFormWidget extends StatefulWidget {
  const LoginFormWidget({Key? key}) : super(key: key);

  @override
  State<LoginFormWidget> createState() => _LoginFormWidgetState();
}

class _LoginFormWidgetState extends State<LoginFormWidget> {
  final _formKey = GlobalKey<FormState>();
  final TextEditingController _phoneEditingController = TextEditingController();
  final TextEditingController _passwordEditingController = TextEditingController();
  late final LoginCubit cubit;

  @override
  void initState() {
    cubit = BlocProvider.of<LoginCubit>(context);
    super.initState();
  }

  Future<void> onLogin() async {
    cubit.onLogin(phoneNumber: _phoneEditingController.text, password: _passwordEditingController.text);
  }

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<LoginCubit, LoginState>(
      buildWhen: (previous, current) => previous.status != current.status,
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
                    'Đăng nhập',
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
                hintText: 'Nhập số điện thoại ',
                labelText: 'Số điện thoại',
                keyboardType: TextInputType.phone,
                validateType: ValidateType.phone,
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
              Padding(
                padding: const EdgeInsets.only(left: 2.0),
                child: InkWell(
                  onTap: () {
                    Fluttertoast.showToast(
                      msg: "Vui lòng liên hệ admin để lấy lại mật khẩu",
                      toastLength: Toast.LENGTH_SHORT,
                      gravity: ToastGravity.BOTTOM,
                      timeInSecForIosWeb: 1,
                      textColor: Colors.white,
                      fontSize: 16.0,
                    );
                  },
                  child: Text(
                    'Quên mật khẩu?',
                    style: TextStyle(
                      fontSize: AppTextStyle.smallFontSize,
                      color: AppColors.primary,
                      decoration: TextDecoration.underline,
                    ),
                  ),
                ),
              ),
              const SizedBox(height: AppDimension.kTextFormFieldMargin),
              AppElevatedButton(
                text: 'Đăng nhập',
                onPressed: () {
                  if (_formKey.currentState!.validate()) {
                    onLogin();
                  }
                },
                radius: AppDimension.kButtonBorderRadius,
                loading: state.status == LoginStateStatus.loading,
                disabled: state.status == LoginStateStatus.loading,
              ),
              const SizedBox(height: AppDimension.kTextFormFieldMargin),
              Padding(
                padding: const EdgeInsets.only(left: 2.0),
                child: InkWell(
                  onTap: () => AppBloc.authenticationCubit.onChangeAuthenticationState(AuthenticationState.onRegister),
                  child: Text(
                    'Chưa có tài khoản? Đăng ký',
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
}
