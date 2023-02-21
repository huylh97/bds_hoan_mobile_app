import 'package:bds_hoan_mobile/configs/_config.dart';
import 'package:flutter/material.dart';

class ToolButton extends StatelessWidget {
  final String iconPath;
  final bool? isSelected;
  final VoidCallback voidCallback;

  const ToolButton({Key? key, required this.iconPath, this.isSelected, required this.voidCallback}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: voidCallback,
      child: Container(
        padding: const EdgeInsets.all(8),
        decoration: BoxDecoration(
          border: Border.all(color: AppColors.boxBorder),
          borderRadius: BorderRadius.circular(10),
          color: isSelected == true ? AppColors.primary : null,
        ),
        child: Image.asset(iconPath, width: 20),
      ),
    );
  }
}
