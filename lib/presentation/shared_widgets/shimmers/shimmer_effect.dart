import 'package:flutter/material.dart';
import 'package:shimmer/shimmer.dart';

class ShimmerEffect extends StatelessWidget {
  final double? width;
  final double? height;
  final ShapeBorder shapeBorder;

  const ShimmerEffect.rectangular({Key? key, this.width = double.infinity, this.height = 50, this.shapeBorder = const RoundedRectangleBorder()})
      : super(key: key);

  const ShimmerEffect.circular({Key? key, this.width = double.infinity, this.height = 50, this.shapeBorder = const CircleBorder()}) : super(key: key);

  @override
  Widget build(BuildContext context) => Shimmer.fromColors(
        baseColor: Colors.black12,
        highlightColor: Colors.white,
        period: const Duration(seconds: 3),
        child: Container(
          width: width,
          height: height,
          decoration: ShapeDecoration(
            color: Colors.grey,
            shape: shapeBorder,
          ),
        ),
      );
}
