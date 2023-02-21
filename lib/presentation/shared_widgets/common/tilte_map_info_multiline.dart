import 'package:bds_hoan_mobile/bloc_global/app_bloc.dart';
import 'package:flutter/material.dart';

class TitleMapInfoMultiline extends StatelessWidget {
  final String? title;
  final String? info;
  final TextStyle? titleStyle;
  final TextStyle? infoStyle;

  const TitleMapInfoMultiline({
    Key? key,
    this.title,
    this.info,
    this.infoStyle,
    this.titleStyle,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 4),
      child: RichText(
        text: TextSpan(
          text: title,
          style: titleStyle ?? AppBloc.applicationCubit.appTextStyle.normal,
          children: <TextSpan>[
            TextSpan(
                text: info == null || info == '' ? '-' : info!,
                style: titleStyle ?? AppBloc.applicationCubit.appTextStyle.normalBold.copyWith(height: 1.4)),
          ],
        ),
      ),
    );
  }
}
