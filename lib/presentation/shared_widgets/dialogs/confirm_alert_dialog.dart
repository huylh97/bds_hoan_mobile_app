import 'package:bds_hoan_mobile/bloc_global/app_bloc.dart';
import 'package:bds_hoan_mobile/presentation/shared_widgets/buttons/widget.dart';
import 'package:flutter/material.dart';
import 'package:bds_hoan_mobile/presentation/shared_widgets/utils/_utils.dart';

class ConfirmAlertDialog extends StatelessWidget {
  final String? message;
  final String? title;
  final VoidCallback? onTapCloseButton;
  final VoidCallback? onTapConfirmButton;
  final bool isCapitalizeContent;

  const ConfirmAlertDialog({Key? key, this.message, this.title, this.onTapCloseButton, this.onTapConfirmButton, this.isCapitalizeContent = true})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return AlertDialog(
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(5)),
      title: Text(
        title ?? 'Xác nhận',
        style: AppBloc.applicationCubit.appTextStyle.mediumBold,
      ),
      content: Text(
        isCapitalizeContent ? UtilString.capitalize(message) ?? '' : message ?? '',
        style: AppBloc.applicationCubit.appTextStyle.normal,
      ),
      actions: <Widget>[
        Container(
          margin: const EdgeInsets.only(bottom: 10),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              AppTextButton(
                text: 'Đóng',
                onPressed: onTapCloseButton ?? () => Navigator.pop(context, false),
              ),
              const SizedBox(width: 30),
              AppTextButton(
                text: 'Xác nhận',
                onPressed: onTapConfirmButton ?? () => Navigator.pop(context, true),
              ),
            ],
          ),
        ),
      ],
    );
  }
}
