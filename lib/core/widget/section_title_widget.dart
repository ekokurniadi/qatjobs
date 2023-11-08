import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:qatjobs/core/styles/color_name_style.dart';
import 'package:qatjobs/core/styles/text_name_style.dart';

class SectionTitleWidget extends StatelessWidget {
  const SectionTitleWidget({
    super.key,
    required this.title,
    this.showMoreWidget,
    this.onTap,
  });
  final String title;
  final bool? showMoreWidget;
  final VoidCallback? onTap;

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: double.infinity,
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          IText.set(
            text: title,
            textAlign: TextAlign.left,
            styleName: TextStyleName.bold,
            typeName: TextTypeName.headline2,
            color: AppColors.textPrimary,
            lineHeight: 1.2.h,
          ),
          if (showMoreWidget ?? false)
            TextButton(
              onPressed: onTap,
              child: IText.set(
                text: 'View All',
                textAlign: TextAlign.left,
                styleName: TextStyleName.regular,
                typeName: TextTypeName.caption1,
                color: AppColors.textPrimary,
                lineHeight: 1.2.h,
              ),
            ),
        ],
      ),
    );
  }
}
