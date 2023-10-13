import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:qatjobs/core/constant/assets_constant.dart';
import 'package:qatjobs/core/styles/color_name_style.dart';
import 'package:qatjobs/core/styles/text_name_style.dart';

class HeaderHomeProfile extends StatelessWidget {
  const HeaderHomeProfile({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        Expanded(
          child: Row(
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              IText.set(
                text: 'Hi,',
                styleName: TextStyleName.medium,
                typeName: TextTypeName.headline2,
                color: AppColors.bg100,
              ),
              IText.set(
                text: ' Username',
                styleName: TextStyleName.medium,
                typeName: TextTypeName.headline2,
                color: AppColors.bg100,
              ),
            ],
          ),
        ),
        Expanded(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.end,
            children: [
              Container(
                width: 56.w,
                height: 56.w,
                decoration: const BoxDecoration(
                  shape: BoxShape.circle,
                  color: AppColors.secondary100,
                ),
                child: SvgPicture.asset(
                  AssetsConstant.svgAssetsBottomNavProfile,
                  color: AppColors.textPrimary,
                ),
              )
            ],
          ),
        )
      ],
    );
  }
}
