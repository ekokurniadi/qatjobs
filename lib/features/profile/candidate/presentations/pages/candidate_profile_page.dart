import 'dart:io';

import 'package:auto_route/auto_route.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/svg.dart';
import 'package:qatjobs/core/auto_route/auto_route.gr.dart';
import 'package:qatjobs/core/constant/app_constant.dart';
import 'package:qatjobs/core/constant/assets_constant.dart';
import 'package:qatjobs/core/helpers/dio_helper.dart';
import 'package:qatjobs/core/helpers/global_helper.dart';
import 'package:qatjobs/core/styles/color_name_style.dart';
import 'package:qatjobs/core/styles/resolution_style.dart';
import 'package:qatjobs/core/styles/text_name_style.dart';
import 'package:qatjobs/core/widget/card_menu_item.dart';
import 'package:qatjobs/core/widget/confirm_dialog_bottom_sheet.dart';
import 'package:qatjobs/core/widget/custom_appbar_widget.dart';
import 'package:qatjobs/core/widget/custom_cached_image_network.dart';
import 'package:qatjobs/core/widget/dialog_logout.dart';
import 'package:qatjobs/core/widget/image_picker_source_dialog.dart';
import 'package:qatjobs/core/widget/loading_dialog_widget.dart';
import 'package:qatjobs/core/widget/pull_to_refresh_widget.dart';
import 'package:qatjobs/features/company/presentations/pages/following_companies_page.dart';
import 'package:qatjobs/features/job/presentations/bloc/bloc/jobs_bloc.dart';
import 'package:qatjobs/features/layouts/presentations/cubit/bottom_nav_cubit.dart';
import 'package:qatjobs/features/profile/candidate/domain/usecases/candidate_update_profile_usecase.dart';
import 'package:qatjobs/features/profile/candidate/presentations/bloc/profile_candidate_bloc.dart';
import 'package:qatjobs/features/users/presentations/bloc/user_bloc.dart';
import 'package:qatjobs/injector.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:zoom_tap_animation/zoom_tap_animation.dart';

class CandidateProfilePage extends StatefulWidget {
  const CandidateProfilePage({super.key});

  @override
  State<CandidateProfilePage> createState() => _CandidateProfilePageState();
}

class _CandidateProfilePageState extends State<CandidateProfilePage> {
  final ValueNotifier<File?> imageProfile = ValueNotifier(null);

  @override
  void initState() {
    context
        .read<ProfileCandidateBloc>()
        .add(const ProfileCandidateEvent.getGeneralProfile());
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return BlocListener<ProfileCandidateBloc, ProfileCandidateState>(
      listener: (context, state) {
        if (state.status == ProfileCandidateStatus.loading) {
          LoadingDialog.show(message: 'Loading ...');
        } else if (state.status ==
            ProfileCandidateStatus.updateProfileSuccess) {
          LoadingDialog.dismiss();
          LoadingDialog.showSuccess(
            message: state.message,
          );
          context.read<ProfileCandidateBloc>().add(
                const ProfileCandidateEvent.getGeneralProfile(),
              );
        } else if (state.status == ProfileCandidateStatus.failure) {
          LoadingDialog.dismiss();
          LoadingDialog.showError(
            message: state.message,
          );
        } else {
          LoadingDialog.dismiss();
        }
      },
      child: Scaffold(
        resizeToAvoidBottomInset: false,
        backgroundColor: AppColors.bg300,
        appBar: const CustomAppBar(
          title: 'Account',
        ),
        body: PullToRefreshWidget(
          onRefresh: () async {
            context
                .read<ProfileCandidateBloc>()
                .add(const ProfileCandidateEvent.getGeneralProfile());
          },
          child: Container(
            width: MediaQuery.sizeOf(context).width,
            height: MediaQuery.sizeOf(context).height,
            padding: defaultPadding,
            child: SingleChildScrollView(
              physics: const AlwaysScrollableScrollPhysics(),
              child: Column(
                children: [
                  BlocBuilder<ProfileCandidateBloc, ProfileCandidateState>(
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
                                  onTap: () async {
                                    final result =
                                        await showModalBottomSheet<File?>(
                                      shape: const RoundedRectangleBorder(
                                        borderRadius: BorderRadius.only(
                                          topRight: Radius.circular(32),
                                          topLeft: Radius.circular(32),
                                        ),
                                      ),
                                      context: context,
                                      builder: (context) {
                                        return ImagePickerDialogBottomSheet(
                                          title: 'Change Profile Picture',
                                          caption: 'Select Source',
                                          onTapCancel: () {},
                                        );
                                      },
                                    );

                                    if (result != null) {
                                      imageProfile.value = result;
                                      context.read<ProfileCandidateBloc>().add(
                                            ProfileCandidateEvent.updateProfile(
                                              ChangeProfileRequestParams(
                                                firstName: userState
                                                        .generalProfile
                                                        .user
                                                        ?.firstName ??
                                                    '',
                                                lastName: userState
                                                        .generalProfile
                                                        .user
                                                        ?.lastName ??
                                                    '',
                                                email: userState.generalProfile
                                                        .user?.email ??
                                                    '',
                                                image: imageProfile.value,
                                                phone: userState.generalProfile
                                                        .user?.phone ??
                                                    '',
                                              ),
                                            ),
                                          );
                                    }
                                  },
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
                                            width: 90.w,
                                            height: 90.w,
                                            fit: BoxFit.cover,
                                            imageUrl: userState.generalProfile
                                                    .user?.avatar ??
                                                '',
                                            customErrorWidget: Center(
                                              child: SvgPicture.asset(
                                                AssetsConstant.svgAssetsPicture,
                                              ),
                                            ),
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
                                              boxShadow:
                                                  AppColors.defaultShadow,
                                              color: AppColors.warning50,
                                            ),
                                            child: Icon(
                                              GlobalHelper.isEmpty(userState
                                                      .generalProfile
                                                      .user
                                                      ?.avatar)
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
                                      text: userState
                                              .generalProfile.user?.fullName ??
                                          '',
                                      typeName: TextTypeName.headline2,
                                      styleName: TextStyleName.bold,
                                    ),
                                    IText.set(
                                      text: userState
                                              .generalProfile.user?.email ??
                                          '',
                                    ),
                                    IText.set(
                                      text: userState
                                              .generalProfile.user?.phone ??
                                          '',
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
                    onTap: () {
                      Navigator.push(
                        context,
                        MaterialPageRoute(
                          builder: (context) => const FollowingCompanyPage(),
                        ),
                      );
                    },
                  ),
                  CardMenuItem(
                    title: 'Applied Jobs',
                    icon: AssetsConstant.svgAssetsWorkExperience,
                    onTap: () {
                      context
                          .read<JobsBloc>()
                          .add(const JobsEvent.getAppliedJob());
                      AutoRouter.of(context).push(
                        const AppliedJobsRoute(),
                      );
                    },
                  ),
                  CardMenuItem(
                    title: 'Job Alert',
                    icon: AssetsConstant.svgAssetsBottomNavNotification,
                    onTap: () {
                      AutoRouter.of(context).push(const JobAlertRoute());
                    },
                  ),
                  CardMenuItem(
                    title: 'About Us',
                    icon: AssetsConstant.svgAssetsBottomNavProfile,
                    onTap: () {
                      AutoRouter.of(context).push(const AboutUsRoute());
                    },
                  ),
                  CardMenuItem(
                    title: 'Change Password',
                    icon: AssetsConstant.svgAssetsPassword,
                    onTap: () {
                      AutoRouter.of(context)
                          .push(const CandidateChangePasswordRoute());
                    },
                    showIconArrow: false,
                  ),
                  CardMenuItem(
                    title: 'Logout',
                    icon: AssetsConstant.svgAssetsLogout,
                    onTap: () async {
                      final result = await DialogLogout.show(
                        context,
                        onOk: () => Navigator.pop(context, true),
                        onCancel: () => Navigator.pop(context),
                      );

                      if (result == true) {
                        await getIt<SharedPreferences>().remove(
                          AppConstant.prefKeyUserLogin,
                        );

                        await getIt<SharedPreferences>().remove(
                          AppConstant.prefKeyToken,
                        );

                        DioHelper.setDioHeader(null);

                        await getIt<SharedPreferences>().remove(
                          AppConstant.prefKeyRole,
                        );

                        context.read<BottomNavCubit>().setSelectedMenuIndex(0);
                        context
                            .read<UserBloc>()
                            .add(const UserEvent.getLogedinUser());
                      }
                    },
                    showIconArrow: false,
                  ),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}
