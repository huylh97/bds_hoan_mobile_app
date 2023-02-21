import 'package:flutter/material.dart';
import 'package:shimmer/shimmer.dart';

class OrderShimmerItem extends StatelessWidget {
  const OrderShimmerItem({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Shimmer.fromColors(
      baseColor: Colors.black12,
      highlightColor: Colors.white,
      period: const Duration(seconds: 3),
      child: SizedBox(
        width: double.infinity,
        height: 70,
        child: Row(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: <Widget>[
            Container(
              width: 60.0,
              height: 60.0,
              color: Colors.white,
            ),
            const Padding(padding: EdgeInsets.symmetric(horizontal: 8.0)),
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: <Widget>[
                  Container(width: double.infinity, height: 17.0, color: Colors.white),
                  const Padding(padding: EdgeInsets.symmetric(vertical: 5.0)),
                  Container(width: double.infinity, height: 12.0, color: Colors.white),
                  const Padding(padding: EdgeInsets.symmetric(vertical: 5.0)),
                  Container(width: 80.0, height: 12.0, color: Colors.white),
                ],
              ),
            )
          ],
        ),
      ),
    );
  }
}
