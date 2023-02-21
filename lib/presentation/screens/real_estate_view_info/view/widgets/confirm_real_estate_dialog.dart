import 'package:bds_hoan_mobile/bloc_global/app_bloc.dart';
import 'package:bds_hoan_mobile/presentation/shared_widgets/buttons/widget.dart';
import 'package:flutter/material.dart';

class ConfirmRealEstateDialog extends StatelessWidget {
  const ConfirmRealEstateDialog({Key? key, required this.title})
      : super(key: key);

  final String title;

  @override
  Widget build(BuildContext context) {
    return AlertDialog(
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(10)),
      title: Text(
        'Xác nhận',
        style: AppBloc.applicationCubit.appTextStyle.mediumBold,
      ),
      content: Text(
        title,
        style: AppBloc.applicationCubit.appTextStyle.normal,
        textAlign: TextAlign.justify,
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
                  elevation: 0,
                  text: 'Xác nhận',
                  onPressed: () => Navigator.pop(context, true),
                  buttonBgColor: const Color(0xffDC1515),
                  textStyle: AppBloc.applicationCubit.appTextStyle.normal
                      .copyWith(color: Colors.white),
                  radius: 8,
                ),
              ),
              const SizedBox(width: 15),
              Expanded(
                child: AppElevatedButton(
                  elevation: 0,
                  text: 'Đóng',
                  onPressed: () => Navigator.pop(context, false),
                  buttonBgColor: const Color(0xFFE7E7E7),
                  textStyle: AppBloc.applicationCubit.appTextStyle.normal
                      .copyWith(color: const Color(0xFF787878)),
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
