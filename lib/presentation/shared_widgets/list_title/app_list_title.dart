import 'package:bds_hoan_mobile/bloc_global/app_bloc.dart';
import 'package:flutter/material.dart';
import 'package:bds_hoan_mobile/configs/_config.dart';

class AppListTitle extends StatelessWidget {
  final String title;
  final String? subtitle;
  final Widget? leading;
  final Widget? trailing;
  final VoidCallback? onPressed;
  final VoidCallback? onLongPressed;
  final bool border;

  const AppListTitle({
    Key? key,
    required this.title,
    this.subtitle,
    this.leading,
    this.trailing,
    this.onPressed,
    this.onLongPressed,
    this.border = true,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    Border? borderWidget;
    Widget subTitle = Container();
    Widget leadingWidget = const SizedBox(width: AppDimension.kScaffoldHorPadding);
    if (leading != null) {
      leadingWidget = Padding(
        padding: const EdgeInsets.only(left: AppDimension.kScaffoldHorPadding, right: AppDimension.kScaffoldHorPadding),
        child: leading,
      );
    }
    if (subtitle != null) {
      subTitle = Padding(
        padding: const EdgeInsets.only(top: 5),
        child: Text(
          subtitle!,
          style: AppBloc.applicationCubit.appTextStyle.normal,
          overflow: TextOverflow.ellipsis,
          maxLines: 1,
        ),
      );
    }
    if (border) {
      borderWidget = const Border(
        bottom: BorderSide(width: 1, color: AppColors.boxBorder),
      );
    }
    return InkWell(
      onTap: onPressed,
      onLongPress: onLongPressed,
      child: Container(
        color: Theme.of(context).cardColor,
        child: Row(
          children: [
            leadingWidget,
            Expanded(
              child: Container(
                decoration: BoxDecoration(
                  border: borderWidget,
                ),
                child: Row(
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: <Widget>[
                    Expanded(
                      child: Padding(
                        padding: const EdgeInsets.only(top: 13, bottom: 13),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(
                              title,
                              style: AppBloc.applicationCubit.appTextStyle.normalBold,
                            ),
                            subTitle
                          ],
                        ),
                      ),
                    ),
                    Padding(
                      padding: const EdgeInsets.only(left: 13, right: 13),
                      child: trailing ?? Container(),
                    )
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
