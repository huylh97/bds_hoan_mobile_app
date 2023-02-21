import 'package:flutter/material.dart';
import 'package:bds_hoan_mobile/configs/app_colors.dart';

class Avatar extends StatelessWidget {
  final String url;
  final bool isSelected;

  const Avatar({Key? key, required this.url, this.isSelected = false}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Stack(clipBehavior: Clip.none, children: [
      Container(
        width: 43,
        height: 43,
        decoration: const BoxDecoration(
          shape: BoxShape.circle,
          color: AppColors.third,
        ),
      ),
      isSelected
          ? Positioned(
              bottom: 0,
              right: -3,
              child: Container(
                alignment: Alignment.center,
                width: 18,
                height: 18,
                decoration: const BoxDecoration(
                  shape: BoxShape.circle,
                  color: Color(0xFF2BC92B),
                ),
                child: const Icon(Icons.check, size: 12, color: Colors.white),
              ),
            )
          : const SizedBox(),
    ]);
  }
}
