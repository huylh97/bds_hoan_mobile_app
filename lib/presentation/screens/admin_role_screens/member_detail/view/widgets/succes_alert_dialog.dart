import 'package:bds_hoan_mobile/bloc_global/app_bloc.dart';
import 'package:bds_hoan_mobile/presentation/shared_widgets/buttons/widget.dart';
import 'package:flutter/material.dart';

class SuccessAlertDialog extends StatelessWidget {
  final String? message;
  const SuccessAlertDialog({Key? key, required this.message}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return AlertDialog(
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(5)),
      title: Row(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Text(
            'Thành công',
            style: AppBloc.applicationCubit.appTextStyle.mediumBold,
          ),
        ],
      ),
      content: SelectableText(
        message ?? '',
        style: AppBloc.applicationCubit.appTextStyle.normal,
        textAlign: TextAlign.center,
      ),
      actions: <Widget>[
        Container(
          margin: const EdgeInsets.only(bottom: 10),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              AppElevatedButton(
                text: 'Đóng',
                onPressed: () => Navigator.pop(context, true),
                buttonBgColor: const Color(0xFFE7E7E7),
                textStyle: AppBloc.applicationCubit.appTextStyle.normal.copyWith(color: const Color(0xFF787878)),
                radius: 8,
                elevation: 0,
              ),
            ],
          ),
        ),
      ],
    );
  }
}
