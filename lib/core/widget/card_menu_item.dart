import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:qatjobs/core/styles/color_name_style.dart';
import 'package:qatjobs/core/styles/resolution_style.dart';
import 'package:qatjobs/core/styles/text_name_style.dart';

class CardMenuItem extends StatelessWidget {
  const CardMenuItem({
    super.key,
    required this.title,
    required this.icon,
    required this.onTap,
    this.showIconArrow = true,
  });
  final String title;
  final String icon;
  final void Function()? onTap;
  final bool showIconArrow;

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: onTap,
      child: Container(
        width: double.infinity,
        padding: defaultPadding,
        margin: EdgeInsets.only(top: 16.h),
        decoration: BoxDecoration(
          boxShadow: AppColors.defaultShadow,
          color: AppColors.bg200,
          borderRadius: defaultRadius,
        ),
        child: Row(
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            Expanded(
              child: SizedBox(
                child: Row(
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    SvgPicture.asset(
                      icon,
                      width: 24.w,
                      color: AppColors.warning,
                    ),
                    SizedBox(width: 12.w),
                    IText.set(
                      text: title,
                      styleName: TextStyleName.bold,
                    ),
                  ],
                ),
              ),
            ),
            if (showIconArrow)
              Container(
                width: 24.w,
                height: 24.w,
                decoration: BoxDecoration(
                  shape: BoxShape.circle,
                  boxShadow: AppColors.defaultShadow,
                  color: AppColors.warning50,
                ),
                child: Icon(
                  Icons.arrow_forward_ios_rounded,
                  size: 14.sp,
                  color: AppColors.warning,
                ),
              )
          ],
        ),
      ),
    );
  }
}
