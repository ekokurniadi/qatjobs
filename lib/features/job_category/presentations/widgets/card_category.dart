import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:qatjobs/core/styles/color_name_style.dart';
import 'package:qatjobs/core/styles/text_name_style.dart';
import 'package:qatjobs/core/widget/custom_cached_image_network.dart';
import 'package:qatjobs/core/widget/shimmer_box_widget.dart';
import 'package:qatjobs/features/job_category/data/models/job_category_model.codegen.dart';

class CardCategory extends StatelessWidget {
  const CardCategory({
    super.key,
    required this.categoryModel,
    required this.isLoading,
  });
  final JobCategoryModel categoryModel;
  final bool isLoading;

  @override
  Widget build(BuildContext context) {
    return Container(
      width: MediaQuery.sizeOf(context).width * 0.75,
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(8.r),
        color: AppColors.bg200,
        boxShadow: const [
          BoxShadow(
            color: AppColors.neutral,
            spreadRadius: 0.1,
            blurRadius: 0.1,
          ),
          BoxShadow(
            color: AppColors.neutral,
            spreadRadius: 0.1,
            blurRadius: 0.1,
          )
        ],
      ),
      child: Row(
        children: [
          if (isLoading) ...[
            Expanded(
              child: ShimmerBoxWidget(
                width: double.infinity,
                height: 80.h,
              ),
            ),
            SizedBox(width: 16.w),
            Expanded(
              flex: 3,
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  ShimmerBoxWidget(
                    width: 100.w,
                    height: 20.h,
                  ),
                  SizedBox(height: 8.h),
                  ShimmerBoxWidget(
                    width: 150.w,
                    height: 20.h,
                  )
                ],
              ),
            )
          ] else ...[
            Expanded(
              child: CustomImageNetwork(
                imageUrl: categoryModel.imageUrl ?? '',
              ),
            ),
            SizedBox(width: 16.w),
            Expanded(
              flex: 3,
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  IText.set(
                    text: categoryModel.name,
                    styleName: TextStyleName.bold,
                    typeName: TextTypeName.headline3,
                    color: AppColors.textPrimary,
                  ),
                  IText.set(
                    text: '${categoryModel.jobsCount ?? 0} Open Position',
                    styleName: TextStyleName.regular,
                    typeName: TextTypeName.caption1,
                    color: AppColors.textPrimary100,
                  ),
                ],
              ),
            )
          ],
        ],
      ),
    );
  }
}
