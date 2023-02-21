import 'package:auto_size_text/auto_size_text.dart';
import 'package:bds_hoan_mobile/bloc_global/application/app_text_style.dart';
import 'package:bds_hoan_mobile/configs/app_colors.dart';
import 'package:flutter/material.dart';

class CheckboxTitle extends StatefulWidget {
  final VoidCallback onTap;
  final String? title;
  final double? verticalMargin;
  final bool value;
  final int? maxLine;

  const CheckboxTitle({
    Key? key,
    required this.onTap,
    required this.title,
    required this.value,
    this.verticalMargin,
    this.maxLine,
  }) : super(key: key);

  @override
  State<CheckboxTitle> createState() => _CheckboxTitleState();
}

class _CheckboxTitleState extends State<CheckboxTitle> {
  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return InkWell(
      splashColor: Colors.transparent,
      onTap: () {
        widget.onTap.call();
      },
      child: Row(
        children: [
          Container(
            width: 22,
            height: 22,
            margin: EdgeInsets.symmetric(vertical: widget.verticalMargin ?? 0),
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(4.0),
              border: widget.value ? null : Border.all(color: AppColors.primary, width: 2),
              color: widget.value ? AppColors.primary : null,
            ),
            child: widget.value
                ? const Icon(
                    Icons.check,
                    size: 20.0,
                    color: Colors.white,
                  )
                : null,
          ),
          const SizedBox(width: 12),
          Expanded(
            child: AutoSizeText(
              widget.title ?? '',
              style: TextStyle(
                color: AppColors.kTextColor,
                fontSize: AppTextStyle.normalFontSize,
              ),
              maxLines: widget.maxLine ?? 1,
            ),
          )
        ],
      ),
    );
  }
}
