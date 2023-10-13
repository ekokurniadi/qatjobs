import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:qatjobs/core/constant/assets_constant.dart';
import 'package:qatjobs/core/styles/color_name_style.dart';
import 'package:qatjobs/core/styles/text_name_style.dart';
import 'package:qatjobs/core/widget/vertical_space_widget.dart';
import 'package:qatjobs/features/home/presentations/widgets/header_home_profile.dart';
import 'package:qatjobs/core/widget/section_title_widget.dart';

class HomePage extends StatelessWidget {
  const HomePage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      resizeToAvoidBottomInset: false,
      body: Container(
        width: double.infinity,
        height: MediaQuery.sizeOf(context).height,
        padding: const EdgeInsets.all(16),
        child: const SingleChildScrollView(
          child: Column(
            children: [
              SpaceWidget(),
              HeaderHomeProfile(),
              SpaceWidget(),
              SectionTitleWidget(
                title: 'Find Your Job',
              ),
              SpaceWidget(),
              _SectionCounterWidget(),
              SpaceWidget(),
              SectionTitleWidget(
                title: 'Popular Categories',
              ),
              _SectionPopularCategory(),
              SpaceWidget(),
              SectionTitleWidget(
                title: 'Latest Jobs',
              ),
              SpaceWidget(),
              _SectionLatestJobs()
            ],
          ),
        ),
      ),
    );
  }
}

class _SectionLatestJobs extends StatelessWidget {
  const _SectionLatestJobs();

  @override
  Widget build(BuildContext context) {
    return ListView.builder(
      physics: const NeverScrollableScrollPhysics(),
      scrollDirection: Axis.vertical,
      shrinkWrap: true,
      itemCount: 5,
      itemBuilder: (context, index) {
        if (index > 3) {
          return TextButton(
            onPressed: () {},
            child: Container(
              padding: const EdgeInsets.all(16),
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(8.r),
                color: AppColors.secondary,
              ),
              child: IText.set(
                text: 'Browse All',
                styleName: TextStyleName.bold,
                typeName: TextTypeName.headline3,
                color: AppColors.textPrimary100,
              ),
            ),
          );
        } else {
          return Container(
            width: MediaQuery.sizeOf(context).width,
            padding: const EdgeInsets.all(16),
            margin: EdgeInsets.symmetric(
              horizontal: 1.w,
              vertical: 8.h,
            ),
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
                SizedBox(
                  width: 80.w,
                  height: 80.w,
                  child: SvgPicture.asset(
                    AssetsConstant.illusJobEmpty,
                    fit: BoxFit.cover,
                  ),
                ),
                SizedBox(width: 16.w),
                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    SizedBox(
                      width: MediaQuery.sizeOf(context).width * 0.60,
                      child: Row(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Expanded(
                            child: IText.set(
                              text: 'Senior Flutter Developer',
                              styleName: TextStyleName.bold,
                              typeName: TextTypeName.headline3,
                              color: AppColors.textPrimary,
                            ),
                          ),
                          SizedBox(width: 8.w),
                          Container(
                            padding: const EdgeInsets.all(4),
                            decoration: BoxDecoration(
                              color: AppColors.danger50,
                              borderRadius: BorderRadius.circular(
                                4.r,
                              ),
                            ),
                            child: IText.set(
                              text: 'Day Shift',
                              styleName: TextStyleName.regular,
                              typeName: TextTypeName.caption1,
                              color: AppColors.danger100,
                            ),
                          )
                        ],
                      ),
                    ),
                    IText.set(
                      text: '8000 - 12500',
                      styleName: TextStyleName.regular,
                      typeName: TextTypeName.caption1,
                      color: AppColors.textPrimary100,
                    ),
                  ],
                )
              ],
            ),
          );
        }
      },
    );
  }
}

class _SectionPopularCategory extends StatelessWidget {
  const _SectionPopularCategory();

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: 120.h,
      child: ListView.builder(
        padding: EdgeInsets.symmetric(
          vertical: 16.h,
        ),
        scrollDirection: Axis.horizontal,
        shrinkWrap: true,
        itemCount: 5,
        itemBuilder: (context, index) {
          if (index > 3) {
            return Container(
              width: MediaQuery.sizeOf(context).width * 0.40,
              padding: const EdgeInsets.all(16),
              margin: EdgeInsets.symmetric(horizontal: 4.w),
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
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  IText.set(
                    text: 'Browse All',
                    styleName: TextStyleName.bold,
                    typeName: TextTypeName.headline3,
                    color: AppColors.textPrimary,
                  ),
                  SpaceWidget(
                    space: 8.h,
                  ),
                  Container(
                    width: 24.w,
                    height: 24.w,
                    decoration: const BoxDecoration(
                      shape: BoxShape.circle,
                      color: AppColors.primary,
                    ),
                    child: Icon(
                      Icons.arrow_forward,
                      color: AppColors.bg200,
                      size: 20.sp,
                    ),
                  )
                ],
              ),
            );
          } else {
            return Container(
              width: MediaQuery.sizeOf(context).width * 0.75,
              padding: const EdgeInsets.all(16),
              margin: EdgeInsets.only(right: 16.w),
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
                  Expanded(
                    child: SvgPicture.asset(
                      AssetsConstant.illusWelcomeScreen,
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
                          text: 'IT & Software',
                          styleName: TextStyleName.bold,
                          typeName: TextTypeName.headline3,
                          color: AppColors.textPrimary,
                        ),
                        IText.set(
                          text: '1 Open Position',
                          styleName: TextStyleName.regular,
                          typeName: TextTypeName.caption1,
                          color: AppColors.textPrimary100,
                        ),
                      ],
                    ),
                  )
                ],
              ),
            );
          }
        },
      ),
    );
  }
}

class _SectionCounterWidget extends StatelessWidget {
  const _SectionCounterWidget();

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: double.infinity,
      height: 200.h,
      child: const Row(
        children: [
          Expanded(
            child: Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                Flexible(
                  child: _DataCountWidget(
                    boxColor: AppColors.success,
                    value: '68.8K',
                    title: 'Jobs',
                  ),
                ),
                SpaceWidget(),
                Flexible(
                  child: _DataCountWidget(
                    boxColor: AppColors.secondary,
                    value: '127.9K',
                    title: 'Candidate',
                  ),
                ),
              ],
            ),
          ),
          SizedBox(width: 16),
          Expanded(
            child: Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                Flexible(
                  child: _DataCountWidget(
                    boxColor: AppColors.warning50,
                    value: '18K',
                    title: 'Companies',
                  ),
                ),
                SpaceWidget(),
                Flexible(
                  child: _DataCountWidget(
                    boxColor: AppColors.danger50,
                    value: '189K',
                    title: 'Resume',
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}

class _DataCountWidget extends StatelessWidget {
  const _DataCountWidget({
    this.boxColor = AppColors.success,
    required this.title,
    required this.value,
  });

  final Color boxColor;
  final String title;
  final String value;

  @override
  Widget build(BuildContext context) {
    return Container(
      width: double.infinity,
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(8.r),
        color: boxColor,
      ),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          IText.set(
            text: value,
            styleName: TextStyleName.bold,
            typeName: TextTypeName.headline1,
            color: AppColors.textPrimary,
          ),
          IText.set(
            text: title,
            styleName: TextStyleName.regular,
            typeName: TextTypeName.headline2,
            color: AppColors.textPrimary,
          ),
        ],
      ),
    );
  }
}
