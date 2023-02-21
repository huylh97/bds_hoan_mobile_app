import 'package:bds_hoan_mobile/bloc_global/application/app_text_style.dart';
import 'package:flutter/material.dart';

class AppTextIconButoon extends StatelessWidget {
  final String text;
  final TextStyle? textStyle;
  final Widget? leadIcon;
  final double? leadPadding;
  final Widget? tailIcon;
  final double? tailPadding;
  final VoidCallback onPressed;
  final Color? bgColor;
  final EdgeInsetsGeometry? padding;
  final double? radius;

  const AppTextIconButoon({
    Key? key,
    required this.text,
    this.textStyle,
    this.leadIcon,
    this.leadPadding,
    this.tailIcon,
    this.tailPadding,
    required this.onPressed,
    this.bgColor,
    this.padding,
    this.radius,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return DefaultTextStyle(
      style: TextStyle(
        color: Theme.of(context).primaryColor,
        fontSize: AppTextStyle.normalFontSize,
        fontWeight: FontWeight.bold,
      ),
      child: InkWell(
        onTap: onPressed,
        splashColor: Colors.transparent,
        child: Container(
          padding: padding,
          decoration: BoxDecoration(
            color: bgColor,
            borderRadius: BorderRadius.circular(radius ?? 0.0),
          ),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.center,
            mainAxisSize: MainAxisSize.min,
            children: [
              leadIcon ?? const SizedBox(),
              leadIcon != null ? SizedBox(width: leadPadding ?? 8) : const SizedBox(),
              Text(text, style: textStyle),
              tailIcon != null ? SizedBox(width: tailPadding ?? 8) : const SizedBox(),
              tailIcon ?? const SizedBox(),
            ],
          ),
        ),
      ),
    );
  }
}
