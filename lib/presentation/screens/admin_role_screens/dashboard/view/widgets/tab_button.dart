import 'package:bds_hoan_mobile/bloc_global/app_bloc.dart';
import 'package:bds_hoan_mobile/configs/app_colors.dart';
import 'package:flutter/material.dart';

class TabButton extends StatelessWidget {
  final String? text;
  final BorderRadiusGeometry? borderRadius;
  final bool? isSelected;
  final VoidCallback onTap;

  const TabButton({
    Key? key,
    required this.text,
    required this.borderRadius,
    required this.isSelected,
    required this.onTap,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: onTap,
      child: Container(
        padding: const EdgeInsets.symmetric(vertical: 10),
        decoration: BoxDecoration(
          color: isSelected == true ? AppColors.primary : null,
          borderRadius: borderRadius,
          border: Border.all(color: AppColors.primary),
        ),
        alignment: Alignment.center,
        child: Text(
          text ?? '',
          style: AppBloc.applicationCubit.appTextStyle.normal.copyWith(
            color: isSelected == true ? Colors.white : AppColors.primary,
          ),
        ),
      ),
    );
  }
}
