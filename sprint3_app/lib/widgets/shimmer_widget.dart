import 'package:flutter/material.dart';
import 'package:shimmer/shimmer.dart';

class ShimmerWidget extends StatelessWidget {
  final double width;
  final double height;
  final double borderRadius;
  final BoxShape shape;

  const ShimmerWidget.rectangular({
    super.key,
    this.width = double.infinity,
    this.height = double.infinity,
    this.borderRadius = 8,
  }) : shape = BoxShape.rectangle;

  const ShimmerWidget.circular({
    super.key,
    required double radius,
  }) : width = radius * 2,
       height = radius * 2,
       borderRadius = 0,
       shape = BoxShape.circle;

  @override
  Widget build(BuildContext context) {
    return Shimmer.fromColors(
      baseColor: Colors.grey[300]!,
      highlightColor: Colors.grey[100]!,
      child: Container(
        width: width,
        height: height,
        decoration: BoxDecoration(
          color: Colors.grey,
          shape: shape,
          borderRadius: shape == BoxShape.rectangle
              ? BorderRadius.circular(borderRadius)
              : null,
        ),
      ),
    );
  }
}