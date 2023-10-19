import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:qatjobs/core/constant/app_constant.dart';
import 'package:qatjobs/core/constant/assets_constant.dart';
import 'package:qatjobs/core/styles/color_name_style.dart';
import 'package:qatjobs/core/styles/text_name_style.dart';
import 'package:qatjobs/core/widget/custom_cached_image_network.dart';
import 'package:qatjobs/features/home/presentations/bloc/home_bloc.dart';
import 'package:qatjobs/features/layouts/presentations/cubit/bottom_nav_cubit.dart';
import 'package:qatjobs/injector.dart';
import 'package:shared_preferences/shared_preferences.dart';

class HeaderHomeProfile extends StatefulWidget {
  const HeaderHomeProfile({
    super.key,
  });

  @override
  State<HeaderHomeProfile> createState() => _HeaderHomeProfileState();
}

class _HeaderHomeProfileState extends State<HeaderHomeProfile> {
  @override
  Widget build(BuildContext context) {
    return BlocBuilder<BottomNavCubit, BottomNavState>(
      builder: (context, state) {
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
                    color: AppColors.textPrimary100,
                  ),
                  IText.set(
                    text: ' ${state.user?.fullName ?? 'QatsJob'}',
                    styleName: TextStyleName.medium,
                    typeName: TextTypeName.headline2,
                    color: AppColors.textPrimary100,
                  ),
                ],
              ),
            ),
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.end,
                children: [
                  InkWell(
                    onTap: () async {
                      await getIt<SharedPreferences>()
                          .remove(AppConstant.prefKeyUserLogin);
                      setState(() {});
                    },
                    child: Container(
                      width: 56.w,
                      height: 56.w,
                      decoration: BoxDecoration(
                        shape: BoxShape.circle,
                        color: AppColors.bg200,
                        border: Border.all(
                          color: AppColors.secondary100,
                        ),
                      ),
                      child: ClipOval(
                        child: CustomImageNetwork(
                          imageUrl: state.user?.avatar ?? '',
                          fit: BoxFit.cover,
                          isLoaderShimmer: true,
                          customErrorWidget: SvgPicture.asset(
                            AssetsConstant.svgAssetsLogoApp,
                          ),
                        ),
                      ),
                    ),
                  )
                ],
              ),
            )
          ],
        );
      },
    );
  }
}
