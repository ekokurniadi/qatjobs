import 'package:auto_route/auto_route.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:qatjobs/core/auto_route/auto_route.gr.dart';
import 'package:qatjobs/core/constant/assets_constant.dart';
import 'package:qatjobs/core/styles/color_name_style.dart';
import 'package:qatjobs/core/styles/text_name_style.dart';
import 'package:zoom_tap_animation/zoom_tap_animation.dart';

class WelcomeScreenPage extends StatelessWidget {
  const WelcomeScreenPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.bg200,
      body: Container(
        height: MediaQuery.sizeOf(context).height,
        width: double.infinity,
        padding: const EdgeInsets.all(32),
        child: SingleChildScrollView(
          child: Column(
            children: [
              SizedBox(
                height: 51.h,
              ),
              SizedBox(
                width: double.infinity,
                child: IText.set(
                  text: 'QatJobs',
                  textAlign: TextAlign.right,
                  styleName: TextStyleName.bold,
                  typeName: TextTypeName.headline2,
                ),
              ),
              SizedBox(
                height: 93.h,
              ),
              SvgPicture.asset(AssetsConstant.illusWelcomeScreen),
              SizedBox(
                height: 78.h,
              ),
              SizedBox(
                width: double.infinity,
                child: IText.set(
                  text: 'Find Your',
                  textAlign: TextAlign.left,
                  styleName: TextStyleName.bold,
                  typeName: TextTypeName.extraLarge,
                  lineHeight: 1.2.h,
                ),
              ),
              SizedBox(
                width: double.infinity,
                child: IText.set(
                  text: 'Dream Job',
                  textAlign: TextAlign.left,
                  styleName: TextStyleName.bold,
                  typeName: TextTypeName.extraLarge,
                  color: AppColors.warning,
                  textDecoration: TextDecoration.underline,
                  lineHeight: 1.2.h,
                ),
              ),
              SizedBox(
                width: double.infinity,
                child: IText.set(
                  text: 'Here!',
                  textAlign: TextAlign.left,
                  styleName: TextStyleName.bold,
                  typeName: TextTypeName.extraLarge,
                  lineHeight: 1.2.h,
                ),
              ),
              SizedBox(
                height: 22.h,
              ),
              SizedBox(
                width: double.infinity,
                child: IText.set(
                  text:
                      'Explore all the most exciting job roles based\non your interest and study major.',
                  textAlign: TextAlign.left,
                  styleName: TextStyleName.regular,
                  typeName: TextTypeName.caption1,
                  color: AppColors.textPrimary100,
                ),
              ),
              Container(
                alignment: Alignment.centerRight,
                width: double.infinity,
                child: ZoomTapAnimation(
                  onTap: () {
                    AutoRouter.of(context).push(const LayoutsRoute());
                  },
                  child: Container(
                    width: 60.w,
                    height: 60.w,
                    decoration: const BoxDecoration(
                      shape: BoxShape.circle,
                      color: AppColors.primary,
                    ),
                    child: Icon(
                      Icons.arrow_forward,
                      color: AppColors.bg200,
                      size: 24.sp,
                    ),
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
