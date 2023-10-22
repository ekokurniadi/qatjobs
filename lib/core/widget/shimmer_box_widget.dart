import 'package:flutter/material.dart';
import 'package:qatjobs/core/styles/color_name_style.dart';
import 'package:qatjobs/core/styles/resolution_style.dart';
import 'package:shimmer/shimmer.dart';

class ShimmerBoxWidget extends StatelessWidget {
  const ShimmerBoxWidget({
    super.key,
    required this.width,
    required this.height,
  });

  final double width;
  final double height;

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: width,
      height: height,
      child: Shimmer.fromColors(
        baseColor: AppColors.neutral,
        highlightColor: AppColors.bg200,
        child: Container(
          width: double.infinity,
          height: height,
          decoration: BoxDecoration(
            borderRadius: defaultRadius,
            color: Colors.white,
          ),
        ),
      ),
    );
  }
}
