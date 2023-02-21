import 'package:bds_hoan_mobile/bloc_global/app_bloc.dart';
import 'package:bds_hoan_mobile/presentation/shared_widgets/buttons/widget.dart';
import 'package:flutter/material.dart';

class ConfirmOutGroupDialog extends StatelessWidget {
  const ConfirmOutGroupDialog({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return AlertDialog(
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(10)),
      title: Text(
        'Bạn chắc chắn thoát khỏi nhóm?',
        style: AppBloc.applicationCubit.appTextStyle.normalBold,
        textAlign: TextAlign.left,
      ),
      content: Text(
        'Sau khi rời khỏi nhóm, các sản phẩm của bạn sẽ được xoá khỏi nhóm.',
        style: AppBloc.applicationCubit.appTextStyle.normal,
        textAlign: TextAlign.left,
      ),
      actions: <Widget>[
        Container(
          margin: const EdgeInsets.only(
            bottom: 15,
            left: 15,
            right: 15,
          ),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Expanded(
                child: AppElevatedButton(
                  buttonHeight: 40,
                  elevation: 0,
                  text: 'Thoát nhóm',
                  onPressed: () => Navigator.pop(context, true),
                  buttonBgColor: const Color(0xffDC1515),
                  textStyle: AppBloc.applicationCubit.appTextStyle.smallBold.copyWith(color: Colors.white),
                  radius: 8,
                ),
              ),
              const SizedBox(width: 15),
              Expanded(
                child: AppElevatedButton(
                  buttonHeight: 40,
                  elevation: 0,
                  text: 'Đóng',
                  onPressed: () => Navigator.pop(context, false),
                  buttonBgColor: const Color(0xFFE7E7E7),
                  textStyle: AppBloc.applicationCubit.appTextStyle.smallBold.copyWith(color: const Color(0xFF787878)),
                  radius: 8,
                ),
              ),
            ],
          ),
        ),
      ],
    );
  }
}
