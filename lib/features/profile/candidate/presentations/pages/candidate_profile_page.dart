import 'package:auto_route/auto_route.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:qatjobs/core/auto_route/auto_route.gr.dart';
import 'package:qatjobs/core/constant/app_constant.dart';
import 'package:qatjobs/core/constant/assets_constant.dart';
import 'package:qatjobs/core/helpers/dio_helper.dart';
import 'package:qatjobs/core/helpers/global_helper.dart';
import 'package:qatjobs/core/styles/color_name_style.dart';
import 'package:qatjobs/core/styles/resolution_style.dart';
import 'package:qatjobs/core/styles/text_name_style.dart';
import 'package:qatjobs/core/widget/card_menu_item.dart';
import 'package:qatjobs/core/widget/custom_appbar_widget.dart';
import 'package:qatjobs/core/widget/custom_cached_image_network.dart';
import 'package:qatjobs/features/job/presentations/bloc/bloc/jobs_bloc.dart';
import 'package:qatjobs/features/layouts/presentations/cubit/bottom_nav_cubit.dart';
import 'package:qatjobs/features/users/presentations/bloc/user_bloc.dart';
import 'package:qatjobs/injector.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:zoom_tap_animation/zoom_tap_animation.dart';

class CandidateProfilePage extends StatelessWidget {
  const CandidateProfilePage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      resizeToAvoidBottomInset: false,
      backgroundColor: AppColors.bg300,
      appBar: const CustomAppBar(
        title: 'Account',
      ),
      body: Container(
        width: MediaQuery.sizeOf(context).width,
        height: MediaQuery.sizeOf(context).height,
        padding: defaultPadding,
        child: SingleChildScrollView(
          child: Column(
            children: [
              BlocBuilder<UserBloc, UserState>(
                builder: (context, userState) {
                  return Container(
                    padding: defaultPadding,
                    width: MediaQuery.sizeOf(context).width,
                    decoration: BoxDecoration(
                      color: AppColors.bg200,
                      boxShadow: AppColors.defaultShadow,
                      borderRadius: defaultRadius,
                    ),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Row(
                          children: [
                            ZoomTapAnimation(
                              onTap: () {},
                              child: Container(
                                width: 90.w,
                                height: 90.w,
                                decoration: BoxDecoration(
                                  shape: BoxShape.circle,
                                  boxShadow: AppColors.defaultShadow,
                                  color: AppColors.bg200,
                                ),
                                child: Stack(
                                  children: [
                                    ClipOval(
                                      child: CustomImageNetwork(
                                        imageUrl: userState.user?.avatar ?? '',
                                        customErrorWidget:
                                            const Icon(Icons.people),
                                        isLoaderShimmer: true,
                                      ),
                                    ),
                                    Positioned(
                                      bottom: 0,
                                      right: 0,
                                      child: Container(
                                        width: 34.w,
                                        height: 34.w,
                                        decoration: BoxDecoration(
                                          shape: BoxShape.circle,
                                          boxShadow: AppColors.defaultShadow,
                                          color: AppColors.warning50,
                                        ),
                                        child: Icon(
                                          GlobalHelper.isEmpty(
                                                  userState.user?.avatar)
                                              ? Icons.upload
                                              : Icons.edit,
                                          size: 21.sp,
                                          color: AppColors.warning,
                                        ),
                                      ),
                                    )
                                  ],
                                ),
                              ),
                            ),
                            SizedBox(width: 16.w),
                            Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                IText.set(
                                  text: userState.user?.fullName ?? '',
                                  typeName: TextTypeName.headline2,
                                  styleName: TextStyleName.bold,
                                ),
                                IText.set(
                                  text: userState.user?.email ?? '',
                                ),
                                IText.set(
                                  text: userState.user?.phone ?? '',
                                ),
                              ],
                            ),
                          ],
                        ),
                      ],
                    ),
                  );
                },
              ),
              CardMenuItem(
                title: 'Profile',
                icon: AssetsConstant.svgAssetsBottomNavProfile,
                onTap: () {
                  AutoRouter.of(context).push(
                    const CandidateProfileDetailRoute(),
                  );
                },
              ),
              CardMenuItem(
                title: 'Favorite Jobs',
                icon: AssetsConstant.svgAssetsSaveJobs,
                onTap: () {
                  AutoRouter.of(context).push(
                    const FavoriteJobRoute(),
                  );
                },
              ),
              CardMenuItem(
                title: 'Followings',
                icon: AssetsConstant.svgAssetsAppreciate,
                onTap: () {},
              ),
              CardMenuItem(
                title: 'Applied Jobs',
                icon: AssetsConstant.svgAssetsWorkExperience,
                onTap: () {},
              ),
              CardMenuItem(
                title: 'Job Alert',
                icon: AssetsConstant.svgAssetsBottomNavNotification,
                onTap: () {},
              ),
              CardMenuItem(
                title: 'About Us',
                icon: AssetsConstant.svgAssetsBottomNavProfile,
                onTap: () {},
              ),
              CardMenuItem(
                title: 'Change Password',
                icon: AssetsConstant.svgAssetsPassword,
                onTap: () {},
                showIconArrow: false,
              ),
              CardMenuItem(
                title: 'Logout',
                icon: AssetsConstant.svgAssetsLogout,
                onTap: () async {
                  await getIt<SharedPreferences>().remove(
                    AppConstant.prefKeyUserLogin,
                  );

                  await getIt<SharedPreferences>().remove(
                    AppConstant.prefKeyToken,
                  );

                  DioHelper.setDioHeader('');

                  await getIt<SharedPreferences>().remove(
                    AppConstant.prefKeyRole,
                  );

                  context.read<BottomNavCubit>().setSelectedMenuIndex(0);
                  context
                      .read<UserBloc>()
                      .add(const UserEvent.getLogedinUser());
                },
                showIconArrow: false,
              ),
            ],
          ),
        ),
      ),
    );
  }
}
