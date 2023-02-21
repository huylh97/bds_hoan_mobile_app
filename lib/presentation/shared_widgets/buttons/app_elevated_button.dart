import 'package:bds_hoan_mobile/bloc_global/app_bloc.dart';
import 'package:flutter/material.dart';
import 'package:bds_hoan_mobile/configs/_config.dart';

class AppElevatedButton extends StatelessWidget {
  final String? text;
  final VoidCallback onPressed;
  final Color? buttonBgColor;
  final Color? disableButtonBgColor;
  final bool loading;
  final bool disabled;
  final double? buttonHeight;
  final double? buttonWidth;
  final double? radius;
  final TextStyle? textStyle;
  final TextStyle? disableTextStyle;
  final double? elevation;

  const AppElevatedButton({
    Key? key,
    this.text,
    required this.onPressed,
    this.buttonBgColor,
    this.disableButtonBgColor,
    this.disabled = false,
    this.loading = false,
    this.buttonHeight,
    this.buttonWidth,
    this.radius,
    this.textStyle,
    this.disableTextStyle,
    this.elevation,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: buttonHeight ?? AppDimension.kButtonHeight,
      child: MaterialButton(
        elevation: elevation,
        onPressed: disabled ? null : onPressed,
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(radius ?? 0)),
        color: buttonBgColor ?? AppColors.primary,
        disabledColor: disableButtonBgColor ?? AppColors.btnDisableBgColor,
        child: Row(
          crossAxisAlignment: CrossAxisAlignment.center,
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            disabled
                ? Text(
                    text ?? '',
                    style: disableTextStyle ??
                        TextStyle(
                            color: AppColors.btnDisableTextColor,
                            fontSize: AppBloc.applicationCubit.appTextStyle.normal.fontSize,
                            fontWeight: FontWeight.bold),
                  )
                : Text(
                    text ?? '',
                    style: textStyle ??
                        TextStyle(color: Colors.white, fontSize: AppBloc.applicationCubit.appTextStyle.normal.fontSize, fontWeight: FontWeight.w700),
                  ),
            buildLoading(AppColors.btnDisableTextColor)
          ],
        ),
      ),
    );
  }

  Widget buildLoading(Color color) {
    if (!loading) return Container();
    return Row(
      children: [
        const SizedBox(width: 10),
        SizedBox(
          width: 15,
          height: 15,
          child: CircularProgressIndicator(
            strokeWidth: 1.5,
            color: color,
          ),
        )
      ],
    );
  }
}
