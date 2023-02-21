import 'dart:io';

import 'package:bds_hoan_mobile/bloc_global/app_bloc.dart';
import 'package:flutter/material.dart';

class DefaultAppBar {
  static AppBar buildWidget({
    required BuildContext context,
    required String title,
    double? elevation,
    List<Widget>? actions,
    bool showBuildBackButton = true,
    void Function()? onPressedBackButton,
  }) {
    Widget buildBackButton(BuildContext context) {
      if (Platform.isIOS) {
        return IconButton(icon: const Icon(Icons.arrow_back_ios), onPressed: onPressedBackButton ?? () => Navigator.of(context).pop());
      }
      return IconButton(icon: const Icon(Icons.arrow_back), onPressed: onPressedBackButton ?? () => Navigator.of(context).pop());
    }

    return AppBar(
      centerTitle: true,
      title: Text(title),
      elevation: elevation ?? 0.5,
      leading: showBuildBackButton ? buildBackButton(context) : null,
      actions: actions,
      titleTextStyle: AppBloc.applicationCubit.appTextStyle.largeBold,
    );
  }
}
