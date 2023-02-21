import 'package:flutter/material.dart';
import 'package:shimmer/shimmer.dart';

class TextShimmer extends StatelessWidget {
  final double? width;
  const TextShimmer({Key? key, this.width}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Shimmer.fromColors(
      baseColor: Colors.black12,
      highlightColor: Colors.white,
      period: const Duration(seconds: 1),
      child: Container(
        width: width ?? 120,
        height: 30,
        color: Colors.white,
      ),
    );
  }
}
