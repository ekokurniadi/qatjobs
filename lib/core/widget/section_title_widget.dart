import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:qatjobs/core/styles/color_name_style.dart';
import 'package:qatjobs/core/styles/text_name_style.dart';

class SectionTitleWidget extends StatelessWidget {
  const SectionTitleWidget({
    super.key,
    required this.title,
  });
  final String title;

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: double.infinity,
      child: IText.set(
        text: title,
        textAlign: TextAlign.left,
        styleName: TextStyleName.bold,
        typeName: TextTypeName.headline2,
        color: AppColors.textPrimary,
        lineHeight: 1.2.h,
      ),
    );
  }
}
