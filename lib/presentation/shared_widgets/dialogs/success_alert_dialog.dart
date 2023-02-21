import 'package:bds_hoan_mobile/presentation/shared_widgets/buttons/widget.dart';
import 'package:flutter/material.dart';
import 'package:bds_hoan_mobile/presentation/shared_widgets/utils/_utils.dart';

class SuccessAlertDialog extends StatelessWidget {
  final String? message;

  const SuccessAlertDialog({
    Key? key,
    this.message,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return AlertDialog(
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(5)),
      title: Row(
        mainAxisAlignment: MainAxisAlignment.start,
        children: <Widget>[
          Container(
            padding: const EdgeInsets.all(3.0),
            decoration: const BoxDecoration(
              color: Colors.green,
              shape: BoxShape.circle,
            ),
            child: const Icon(
              Icons.check,
              color: Colors.white,
              size: 20,
            ),
          ),
          const SizedBox(width: 8),
          const Text(
            'Thành công',
            style: TextStyle(color: Colors.green, fontWeight: FontWeight.bold),
          ),
        ],
      ),
      titlePadding: const EdgeInsets.fromLTRB(18.0, 20.0, 24.0, 0),
      content: Text(UtilString.capitalize(message) ?? ''),
      contentPadding: const EdgeInsets.fromLTRB(24.0, 20.0, 24.0, 24.0),
      actions: <Widget>[
        Container(
          margin: const EdgeInsets.only(bottom: 10),
          child: AppTextButton(
            text: 'Đóng',
            onPressed: () => Navigator.pop(context, true),
          ),
        )
      ],
    );
  }
}
