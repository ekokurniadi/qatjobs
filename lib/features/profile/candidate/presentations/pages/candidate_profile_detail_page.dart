import 'package:auto_route/auto_route.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:qatjobs/core/auto_route/auto_route.gr.dart';
import 'package:qatjobs/core/constant/assets_constant.dart';
import 'package:qatjobs/core/styles/color_name_style.dart';
import 'package:qatjobs/core/widget/card_menu_item.dart';
import 'package:qatjobs/core/widget/custom_appbar_widget.dart';

class CandidateProfileDetailPage extends StatelessWidget {
  const CandidateProfileDetailPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      resizeToAvoidBottomInset: false,
      backgroundColor: AppColors.bg300,
      appBar: const CustomAppBar(
        title: 'Profile',
        showLeading: true,
      ),
      body: Container(
        width: double.infinity,
        height: MediaQuery.sizeOf(context).height,
        padding: EdgeInsets.symmetric(horizontal: 16.w),
        child: Column(
          children: [
            CardMenuItem(
              title: 'General Profile',
              icon: AssetsConstant.svgAssetsAboutMe,
              onTap: () {
                AutoRouter.of(context).push(
                  const CandidateGeneralProfileRoute(),
                );
              },
            ),
            CardMenuItem(
              title: 'Resume',
              icon: AssetsConstant.svgAssetsResume,
              onTap: () {},
            ),
            CardMenuItem(
              title: 'Career Information',
              icon: AssetsConstant.svgAssetsWorkExperience,
              onTap: () {},
            ),
            CardMenuItem(
              title: 'CV Builder',
              icon: AssetsConstant.svgAssetsPDF,
              onTap: () {},
            )
          ],
        ),
      ),
    );
  }
}
