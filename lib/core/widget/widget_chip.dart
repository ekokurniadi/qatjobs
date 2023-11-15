import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:qatjobs/core/styles/color_name_style.dart';
import 'package:qatjobs/core/styles/text_name_style.dart';

class WidgetChip extends StatelessWidget {
  const WidgetChip({
    super.key,
    required this.content,
    this.backgroundColor,
    this.textColor,
  });

  final String content;
  final Color? backgroundColor;
  final Color? textColor;

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.symmetric(vertical: 4.h, horizontal: 8.w),
      decoration: BoxDecoration(
        color: backgroundColor ?? AppColors.danger50,
        boxShadow: AppColors.defaultShadow,
        borderRadius: BorderRadius.circular(
          4.r,
        ),
      ),
      child: IText.set(
        text: content,
        styleName: TextStyleName.regular,
        typeName: TextTypeName.caption1,
        color: textColor ?? AppColors.danger100,
      ),
    );
  }
}
