import 'package:bds_hoan_mobile/bloc_global/app_bloc.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class TitleMapInfo extends StatelessWidget {
  final String? title;
  final String? info;
  final TextStyle? titleStyle;
  final TextStyle? infoStyle;
  final double? verticalPadding;
  final double? leftPadding;
  final double? rightPadding;
  final bool showDottedLine;
  final CrossAxisAlignment? rowCrossAxisAlignment;
  final bool alignLeft;

  const TitleMapInfo({
    Key? key,
    this.title,
    this.info,
    this.infoStyle,
    this.titleStyle,
    this.verticalPadding,
    this.leftPadding,
    this.rightPadding,
    this.showDottedLine = false,
    this.rowCrossAxisAlignment,
    this.alignLeft = false,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.fromLTRB(leftPadding ?? 0, 4, rightPadding ?? 0, 4),
      child: Row(
        crossAxisAlignment: rowCrossAxisAlignment ?? CrossAxisAlignment.center,
        children: [
          ConstrainedBox(
            constraints: BoxConstraints(maxWidth: 0.65.sw),
            child: Text(
              title ?? '',
              style: titleStyle ?? AppBloc.applicationCubit.appTextStyle.normal.copyWith(color: const Color(0xFF9F9F9F)),
            ),
          ),
          Text(
            info == null || info == '' ? '-' : info!,
            style: infoStyle ?? AppBloc.applicationCubit.appTextStyle.normalBold,
          ),
        ],
      ),
    );
  }
}
