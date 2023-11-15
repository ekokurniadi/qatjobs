import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/svg.dart';
import 'package:image_picker/image_picker.dart';
import 'package:qatjobs/core/constant/assets_constant.dart';
import 'package:qatjobs/core/helpers/image_picker_helper.dart';
import 'package:qatjobs/core/styles/color_name_style.dart';
import 'package:qatjobs/core/styles/resolution_style.dart';
import 'package:qatjobs/core/styles/text_name_style.dart';
import 'package:qatjobs/core/widget/vertical_space_widget.dart';

class ImagePickerDialogBottomSheet extends StatelessWidget {
  const ImagePickerDialogBottomSheet({
    super.key,
    required this.title,
    required this.caption,
    required this.onTapCancel,
  });
  final String title;
  final String caption;
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
          ),
          SpaceWidget(space: 32.h),
          SizedBox(
            width: double.infinity,
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Expanded(
                  child: SizedBox(
                    width: double.infinity,
                    height: 60.h,
                    child: ElevatedButton(
                      onPressed: () async {
                        final result = await ImagePickerHelper.pickImage(
                            source: ImageSource.camera);
                        if (result != null) {
                          Navigator.pop(context, result);
                        }
                      },
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          SvgPicture.asset(AssetsConstant.svgAssetsCamera),
                          IText.set(
                            text: 'Camera',
                            styleName: TextStyleName.semiBold,
                            color: AppColors.bg100,
                          ),
                        ],
                      ),
                    ),
                  ),
                ),
                const SpaceWidget(
                  direction: Direction.horizontal,
                ),
                Expanded(
                  child: SizedBox(
                      width: double.infinity,
                      height: 60.h,
                      child: ElevatedButton(
                        onPressed: () async {
                          final result = await ImagePickerHelper.pickImage(
                              source: ImageSource.gallery);
                          if (result != null) {
                            Navigator.pop(context, result);
                          }
                        },
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            SvgPicture.asset(AssetsConstant.svgAssetsPicture),
                            IText.set(
                              text: 'Galery',
                              styleName: TextStyleName.semiBold,
                              color: AppColors.bg100,
                            ),
                          ],
                        ),
                      )),
                ),
              ],
            ),
          ),
          const SpaceWidget(),
          SizedBox(
            width: double.infinity,
            height: 60.h,
            child: ElevatedButton(
              style: ElevatedButton.styleFrom(
                backgroundColor: AppColors.danger100,
              ),
              onPressed: () async {
                Navigator.pop(context);
              },
              child: Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  IText.set(
                    text: 'Cancel',
                    styleName: TextStyleName.semiBold,
                    color: AppColors.bg100,
                  ),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
}
