import 'dart:developer';

import 'package:auto_route/auto_route.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:qatjobs/core/auto_route/auto_route.gr.dart';
import 'package:qatjobs/core/constant/app_constant.dart';
import 'package:qatjobs/core/constant/assets_constant.dart';
import 'package:qatjobs/core/styles/color_name_style.dart';
import 'package:qatjobs/core/styles/text_name_style.dart';
import 'package:qatjobs/features/layouts/presentations/cubit/bottom_nav_cubit.dart';
import 'package:qatjobs/injector.dart';
import 'package:shared_preferences/shared_preferences.dart';

class SplashScreenPage extends StatefulWidget {
  const SplashScreenPage({super.key});

  @override
  State<SplashScreenPage> createState() => _SplashScreenPageState();
}

class _SplashScreenPageState extends State<SplashScreenPage> {
  @override
  void initState() {
    checkIsFreshInstall();
    super.initState();
  }

  Future<void> checkIsFreshInstall() async {
    final isFreshInstall =
        getIt<SharedPreferences>().getBool(AppConstant.prefKeyisFreshInstall);
    if (isFreshInstall == null) {
      Future.delayed(
        const Duration(seconds: 3),
        () {
          AutoRouter.of(context).replace(const WelcomeScreenRoute());
        },
      );
    } else {
      Future.delayed(
        const Duration(seconds: 3),
        () {
          context.read<BottomNavCubit>().setSelectedMenuIndex(0);
          AutoRouter.of(context).replace(const LayoutsRoute());
        },
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.primary,
      body: SizedBox(
        width: double.infinity,
        height: MediaQuery.sizeOf(context).height,
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          mainAxisSize: MainAxisSize.max,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            SvgPicture.asset(AssetsConstant.svgAssetsLogoApp),
            SizedBox(height: 16.h),
            IText.set(
              text: 'QatJobs',
              typeName: TextTypeName.display2,
              styleName: TextStyleName.bold,
              color: AppColors.bg100,
            )
          ],
        ),
      ),
    );
  }
}
