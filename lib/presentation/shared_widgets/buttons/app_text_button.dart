import 'package:bds_hoan_mobile/bloc_global/application/app_text_style.dart';
import 'package:flutter/material.dart';
import 'package:bds_hoan_mobile/configs/_config.dart';

class AppTextButton extends StatelessWidget {
  final String? text;
  final VoidCallback onPressed;
  final Color? bgColor;
  final Color? textColor;
  final double? fontSize;
  final double? borderRadius;
  final EdgeInsets? padding;

  const AppTextButton({
    Key? key,
    this.text,
    required this.onPressed,
    this.bgColor,
    this.textColor,
    this.fontSize,
    this.borderRadius,
    this.padding,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return DefaultTextStyle(
      style: TextStyle(
        color: AppColors.primary,
        fontSize: AppTextStyle.normalFontSize,
        fontWeight: FontWeight.bold,
      ),
      child: InkWell(
        onTap: onPressed,
        splashColor: Colors.transparent,
        highlightColor: Colors.transparent,
        child: Container(
          alignment: Alignment.center,
          padding: padding ?? const EdgeInsets.all(0),
          decoration: BoxDecoration(color: bgColor, borderRadius: BorderRadius.circular(borderRadius ?? 0.0)),
          child: Text(text ?? '', style: TextStyle(color: textColor, fontSize: fontSize)),
        ),
      ),
    );
  }
}
