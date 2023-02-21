import 'package:bds_hoan_mobile/bloc_global/app_bloc.dart';
import 'package:bds_hoan_mobile/presentation/shared_widgets/buttons/widget.dart';
import 'package:flutter/material.dart';

class CanNotOutGroupDialog extends StatelessWidget {
  const CanNotOutGroupDialog({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return AlertDialog(
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(5)),
      title: Text(
        'Bạn không thể thoát khỏi nhóm',
        style: AppBloc.applicationCubit.appTextStyle.mediumBold,
      ),
      content: Text(
        'Bạn đang là trưởng nhóm. Cần phải xoá các thành viên trước khi rời nhóm.',
        style: AppBloc.applicationCubit.appTextStyle.normal,
      ),
      actions: <Widget>[
        Container(
          margin: const EdgeInsets.only(bottom: 10),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              AppElevatedButton(
                text: 'Đóng',
                onPressed: () => Navigator.pop(context, false),
                buttonBgColor: const Color(0xFFE7E7E7),
                textStyle: AppBloc.applicationCubit.appTextStyle.normal,
                radius: 8,
              ),
            ],
          ),
        ),
      ],
    );
  }
}
