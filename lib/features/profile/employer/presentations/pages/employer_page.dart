import 'dart:io';

import 'package:auto_route/auto_route.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/flutter_svg.dart';
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
import 'package:qatjobs/features/layouts/presentations/cubit/bottom_nav_cubit.dart';
import 'package:qatjobs/features/profile/employer/domain/usecases/update_profile_usecase.dart';
import 'package:qatjobs/features/profile/employer/presentations/cubit/employer_cubit.dart';
import 'package:qatjobs/features/profile/employer/presentations/pages/employer_followers_page.dart';
import 'package:qatjobs/features/users/presentations/bloc/user_bloc.dart';
import 'package:qatjobs/injector.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:zoom_tap_animation/zoom_tap_animation.dart';

class EmployerPage extends StatefulWidget {
  const EmployerPage({super.key});

  @override
  State<EmployerPage> createState() => _EmployerPageState();
}

class _EmployerPageState extends State<EmployerPage> {
  final ValueNotifier<File?> imageProfile = ValueNotifier(null);

  @override
  void initState() {
    context.read<EmployerCubit>().getProfile();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return BlocListener<EmployerCubit, EmployerState>(
      listener: (context, state) {
        if (state.status == EmployerStatus.failure) {
          LoadingDialog.dismiss();
          LoadingDialog.showError(message: state.message);
        } else if (state.status == EmployerStatus.loading) {
          LoadingDialog.show(message: 'Loading ...');
        } else if (state.status == EmployerStatus.updateProfileSuccess) {
          LoadingDialog.dismiss();
          LoadingDialog.showSuccess(message: state.message);

          context.read<EmployerCubit>().getProfile();
        } else {
          LoadingDialog.dismiss();
        }
      },
      child: Scaffold(
        appBar: const CustomAppBar(title: 'Account'),
        body: PullToRefreshWidget(
          onRefresh: () async {
            context.read<EmployerCubit>().getProfile();
          },
          child: Container(
            width: MediaQuery.sizeOf(context).width,
            height: MediaQuery.sizeOf(context).height,
            padding: defaultPadding,
            child: SingleChildScrollView(
              physics: const AlwaysScrollableScrollPhysics(),
              child: Column(
                children: [
                  BlocBuilder<EmployerCubit, EmployerState>(
                    builder: (context, state) {
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
                                      context
                                          .read<EmployerCubit>()
                                          .updateProfile(
                                            EmployerProfileRequestParams(
                                              firstName: state.companyModel.user
                                                      ?.firstName ??
                                                  '',
                                              email: state.companyModel.user
                                                      ?.email ??
                                                  '',
                                              phone: state
                                                  .companyModel.user?.phone,
                                              image: imageProfile.value,
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
                                            loaderWidget:
                                                const CircularProgressIndicator(),
                                            width: 90.w,
                                            fit: BoxFit.cover,
                                            imageUrl: state.companyModel.user
                                                    ?.avatar ??
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
                                              GlobalHelper.isEmpty(
                                                state.companyModel.user?.avatar,
                                              )
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
                                      text: state.companyModel.user?.fullName ??
                                          '',
                                      typeName: TextTypeName.headline2,
                                      styleName: TextStyleName.bold,
                                    ),
                                    IText.set(
                                      text:
                                          state.companyModel.user?.email ?? '',
                                    ),
                                    IText.set(
                                      text:
                                          state.companyModel.user?.phone ?? '',
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
                      AutoRouter.of(context).push(const ProfileRoute());
                    },
                  ),
                  CardMenuItem(
                    title: 'Jobs',
                    icon: AssetsConstant.svgAssetsSaveJobs,
                    onTap: () {
                      AutoRouter.of(context).push(const EmployerJobRoute());
                    },
                  ),
                  CardMenuItem(
                    title: 'Job Stages',
                    icon: AssetsConstant.svgAssetsWorkExperience,
                    onTap: () {
                      AutoRouter.of(context).push(JobStagesListRoute());
                    },
                  ),
                  CardMenuItem(
                    title: 'Followers',
                    icon: AssetsConstant.svgAssetsAppreciate,
                    onTap: () {
                      Navigator.push(
                        context,
                        MaterialPageRoute(
                          builder: (context) => const EmployerFollowersPage(),
                        ),
                      );
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
                          .push(const EmployerChangePasswordRoute());
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
