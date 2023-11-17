import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:qatjobs/core/styles/color_name_style.dart';
import 'package:qatjobs/core/styles/resolution_style.dart';
import 'package:qatjobs/core/styles/text_name_style.dart';
import 'package:qatjobs/core/widget/vertical_space_widget.dart';

class ConfirmDialogBottomSheet extends StatelessWidget {
  const ConfirmDialogBottomSheet({
    super.key,
    required this.title,
    required this.caption,
    required this.onTapContinue,
    required this.onTapCancel,
  });
  final String title;
  final String caption;
  final VoidCallback onTapContinue;
  final VoidCallback onTapCancel;

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: defaultPadding,
      child: Column(
        mainAxisSize: MainAxisSize.min,
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          const SpaceWidget(),
          Container(
            width: 80.w,
            height: 5,
            decoration: BoxDecoration(
              color: AppColors.textPrimary100,
              borderRadius: defaultRadius,
            ),
          ),
          SpaceWidget(
            space: 32.h,
          ),
          IText.set(
            text: title,
            styleName: TextStyleName.semiBold,
            typeName: TextTypeName.headline3,
            overflow: TextOverflow.ellipsis,
          ),
          SpaceWidget(space: 16.h),
          IText.set(
              text: caption,
              styleName: TextStyleName.regular,
              color: AppColors.textPrimary100,
              textAlign: TextAlign.center),
          SpaceWidget(space: 32.h),
          SizedBox(
            width: double.infinity,
            height: 60.h,
            child: ElevatedButton(
              onPressed: onTapContinue,
              child: IText.set(
                text: 'CONTINUE',
                styleName: TextStyleName.semiBold,
                color: AppColors.bg100,
              ),
            ),
          ),
          const SpaceWidget(),
          SizedBox(
              width: double.infinity,
              height: 60.h,
              child: ElevatedButton(
                style: ElevatedButton.styleFrom(
                  backgroundColor: AppColors.secondary,
                ),
                onPressed: onTapCancel,
                child: IText.set(
                  text: 'UNDO CHANGES',
                  styleName: TextStyleName.semiBold,
                  color: AppColors.textPrimary100,
                ),
              )),
        ],
      ),
    );
  }
}
