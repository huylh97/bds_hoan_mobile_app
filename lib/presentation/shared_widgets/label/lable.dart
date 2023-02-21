import 'package:bds_hoan_mobile/bloc_global/app_bloc.dart';
import 'package:flutter/material.dart';

class Lable extends StatelessWidget {
  final Color? backgroundColor;
  final Color? textColor;
  final String? text;
  final FontWeight? fontWeight;
  final double? radius;
  final EdgeInsetsGeometry? padding;
  final TextStyle? textStyle;
  final double? height;

  const Lable({
    Key? key,
    this.text,
    this.textColor,
    this.backgroundColor,
    this.fontWeight,
    this.radius,
    this.padding,
    this.textStyle,
    this.height,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      height: height,
      alignment: Alignment.center,
      padding: padding ?? const EdgeInsets.symmetric(vertical: 3, horizontal: 10),
      decoration: BoxDecoration(borderRadius: BorderRadius.circular(radius ?? 0), color: backgroundColor),
      child: Text(
        text ?? '',
        style: textStyle ?? AppBloc.applicationCubit.appTextStyle.smallBold.copyWith(color: textColor),
      ),
    );
  }
}
