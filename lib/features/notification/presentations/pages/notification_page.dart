import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:qatjobs/core/constant/assets_constant.dart';
import 'package:qatjobs/core/styles/color_name_style.dart';
import 'package:qatjobs/core/styles/text_name_style.dart';
import 'package:qatjobs/core/widget/vertical_space_widget.dart';

class NotificationPage extends StatelessWidget {
  const NotificationPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        backgroundColor: AppColors.bg300,
        appBar: AppBar(
          title: IText.set(
            text: 'Notifications',
            textAlign: TextAlign.left,
            styleName: TextStyleName.bold,
            typeName: TextTypeName.headline2,
            color: AppColors.textPrimary,
          ),
          backgroundColor: AppColors.bg200,
          elevation: 0.5,
        ),
        body: Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              SvgPicture.asset(AssetsConstant.illusJobEmpty),
              const SpaceWidget(),
              IText.set(
                text: 'Notification is empty',
                textAlign: TextAlign.left,
                styleName: TextStyleName.medium,
                typeName: TextTypeName.large,
                color: AppColors.textPrimary,
                lineHeight: 1.2.h,
              ),
              const SpaceWidget(),
              IText.set(
                text: 'You currently have no incoming messages',
                textAlign: TextAlign.left,
                styleName: TextStyleName.regular,
                typeName: TextTypeName.caption1,
                color: AppColors.textPrimary100,
              )
            ],
          ),
        ));
  }
}
