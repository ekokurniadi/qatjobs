

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:image_gallery_saver/image_gallery_saver.dart';
import 'package:open_file/open_file.dart';
import 'package:qatjobs/core/constant/assets_constant.dart';
import 'package:qatjobs/core/helpers/date_helper.dart';
import 'package:qatjobs/core/styles/color_name_style.dart';
import 'package:qatjobs/core/styles/resolution_style.dart';
import 'package:qatjobs/core/styles/text_name_style.dart';
import 'package:qatjobs/core/widget/custom_appbar_widget.dart';
import 'package:qatjobs/core/widget/custom_cached_image_network.dart';
import 'package:qatjobs/core/widget/loading_dialog_widget.dart';
import 'package:qatjobs/core/widget/pull_to_refresh_widget.dart';
import 'package:qatjobs/core/widget/section_title_widget.dart';
import 'package:qatjobs/core/widget/vertical_space_widget.dart';
import 'package:qatjobs/features/profile/candidate/presentations/bloc/profile_candidate_bloc.dart';
import 'package:screenshot/screenshot.dart';

class CvBuilderPage extends StatefulWidget {
  const CvBuilderPage({super.key});

  @override
  State<CvBuilderPage> createState() => _CvBuilderPageState();
}

class _CvBuilderPageState extends State<CvBuilderPage> {
  ScreenshotController screenshotController = ScreenshotController();
  Widget? capturedWidget;
  @override
  void initState() {
    context
        .read<ProfileCandidateBloc>()
        .add(const ProfileCandidateEvent.getCVBuilder());
    super.initState();
  }

  Future<void> exportCV(BuildContext context) async {
    final image = await screenshotController.capture(
      delay: const Duration(milliseconds: 100),
    );

    if (image != null) {
      final result = await ImageGallerySaver.saveImage(image);
      if(result['isSuccess']){
        LoadingDialog.showSuccess(message: 'CV exported successfuly and saved on your galery');
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.bg300,
      appBar: const CustomAppBar(
        title: 'CV Builder',
        showLeading: true,
      ),
      body: PullToRefreshWidget(
        onRefresh: () async {
          context
              .read<ProfileCandidateBloc>()
              .add(const ProfileCandidateEvent.getCVBuilder());
        },
        child: SingleChildScrollView(
          physics: const AlwaysScrollableScrollPhysics(),
          child: Padding(
            padding: defaultPadding,
            child: BlocBuilder<ProfileCandidateBloc, ProfileCandidateState>(
              builder: (context, state) {
                return state.cvBuilder.fold(
                  () => const SizedBox(),
                  (a) {
                    return a.fold(
                      (l) => const SizedBox(),
                      (data) {
                        return Screenshot(
                          controller: screenshotController,
                          child: Container(
                            color: AppColors.bg300,
                            child: Column(
                              children: [
                                Container(
                                  width: double.infinity,
                                  padding: defaultPadding,
                                  decoration: BoxDecoration(
                                    borderRadius: defaultRadius,
                                    boxShadow: AppColors.defaultShadow,
                                    color: AppColors.bg200,
                                  ),
                                  child: Column(
                                    crossAxisAlignment:
                                        CrossAxisAlignment.start,
                                    children: [
                                      Row(
                                        mainAxisAlignment:
                                            MainAxisAlignment.start,
                                        children: [
                                          ClipOval(
                                            child: CustomImageNetwork(
                                              width: 90.w,
                                              fit: BoxFit.cover,
                                              imageUrl:
                                                  data.candidate.user.avatar ??
                                                      '',
                                              customErrorWidget: Center(
                                                child: SvgPicture.asset(
                                                  AssetsConstant
                                                      .svgAssetsPicture,
                                                ),
                                              ),
                                              isLoaderShimmer: true,
                                            ),
                                          ),
                                          SizedBox(width: 16.w),
                                          Expanded(
                                            child: Column(
                                              crossAxisAlignment:
                                                  CrossAxisAlignment.start,
                                              children: [
                                                SectionTitleWidget(
                                                  title: data.candidate.user
                                                          .fullName ??
                                                      '',
                                                ),
                                                IText.set(
                                                  text: data.candidate.user
                                                          .email ??
                                                      '',
                                                ),
                                                IText.set(
                                                  text: data.candidate.user
                                                          .phone ??
                                                      '',
                                                )
                                              ],
                                            ),
                                          ),
                                        ],
                                      ),
                                    ],
                                  ),
                                ),
                                const SpaceWidget(),
                                Container(
                                  width: double.infinity,
                                  padding: defaultPadding,
                                  decoration: BoxDecoration(
                                    borderRadius: defaultRadius,
                                    boxShadow: AppColors.defaultShadow,
                                    color: AppColors.bg200,
                                  ),
                                  child: Column(
                                    crossAxisAlignment:
                                        CrossAxisAlignment.start,
                                    children: [
                                      const SectionTitleWidget(
                                        title: 'Skill',
                                        textColor: AppColors.primary,
                                      ),
                                      const Divider(),
                                      ListView.builder(
                                        physics:
                                            const NeverScrollableScrollPhysics(),
                                        shrinkWrap: true,
                                        itemCount: data.candidateSkill.length,
                                        itemBuilder: (context, index) {
                                          return Padding(
                                            padding:
                                                EdgeInsets.only(bottom: 8.h),
                                            child: SizedBox(
                                              width: double.infinity,
                                              child: Row(
                                                children: [
                                                  Icon(
                                                    Icons.circle,
                                                    color: AppColors.warning,
                                                    size: 12.sp,
                                                  ),
                                                  SizedBox(width: 8.w),
                                                  IText.set(
                                                    text: data
                                                        .candidateSkill[index]
                                                        .name,
                                                  )
                                                ],
                                              ),
                                            ),
                                          );
                                        },
                                      )
                                    ],
                                  ),
                                ),
                                const SpaceWidget(),
                                Container(
                                  width: double.infinity,
                                  padding: defaultPadding,
                                  decoration: BoxDecoration(
                                    borderRadius: defaultRadius,
                                    boxShadow: AppColors.defaultShadow,
                                    color: AppColors.bg200,
                                  ),
                                  child: Column(
                                    crossAxisAlignment:
                                        CrossAxisAlignment.start,
                                    children: [
                                      const SectionTitleWidget(
                                        title: 'Education',
                                        textColor: AppColors.primary,
                                      ),
                                      const Divider(),
                                      ListView.builder(
                                        physics:
                                            const NeverScrollableScrollPhysics(),
                                        shrinkWrap: true,
                                        itemCount:
                                            data.candidate.educations.length,
                                        itemBuilder: (context, index) {
                                          return Padding(
                                            padding:
                                                EdgeInsets.only(bottom: 8.h),
                                            child: SizedBox(
                                              width: double.infinity,
                                              child: Row(
                                                children: [
                                                  Icon(
                                                    Icons.circle,
                                                    color: AppColors.warning,
                                                    size: 12.sp,
                                                  ),
                                                  SizedBox(width: 8.w),
                                                  IText.set(
                                                    text: data
                                                            .candidate
                                                            .educations[index]
                                                            .degreeLevel
                                                            ?.name ??
                                                        '',
                                                  )
                                                ],
                                              ),
                                            ),
                                          );
                                        },
                                      )
                                    ],
                                  ),
                                ),
                                const SpaceWidget(),
                                Container(
                                  width: double.infinity,
                                  padding: defaultPadding,
                                  decoration: BoxDecoration(
                                    borderRadius: defaultRadius,
                                    boxShadow: AppColors.defaultShadow,
                                    color: AppColors.bg200,
                                  ),
                                  child: Column(
                                    crossAxisAlignment:
                                        CrossAxisAlignment.start,
                                    children: [
                                      const SectionTitleWidget(
                                        title: 'Experiences',
                                        textColor: AppColors.primary,
                                      ),
                                      const Divider(),
                                      ListView.builder(
                                        physics:
                                            const NeverScrollableScrollPhysics(),
                                        shrinkWrap: true,
                                        itemCount:
                                            data.candidate.experiences.length,
                                        itemBuilder: (context, index) {
                                          return Padding(
                                            padding:
                                                EdgeInsets.only(bottom: 8.h),
                                            child: SizedBox(
                                              width: double.infinity,
                                              child: Row(
                                                crossAxisAlignment:
                                                    CrossAxisAlignment.center,
                                                children: [
                                                  Icon(
                                                    Icons.circle,
                                                    color: AppColors.warning,
                                                    size: 12.sp,
                                                  ),
                                                  SizedBox(width: 8.w),
                                                  Column(
                                                    crossAxisAlignment:
                                                        CrossAxisAlignment
                                                            .start,
                                                    mainAxisAlignment:
                                                        MainAxisAlignment.start,
                                                    children: [
                                                      IText.set(
                                                        text: data
                                                            .candidate
                                                            .experiences[index]
                                                            .experienceTitle,
                                                        styleName:
                                                            TextStyleName.bold,
                                                      ),
                                                      IText.set(
                                                        text: data
                                                            .candidate
                                                            .experiences[index]
                                                            .company,
                                                      ),
                                                      Row(
                                                        children: [
                                                          IText.set(
                                                            text: DateHelper
                                                                .formatdMy(
                                                              data
                                                                  .candidate
                                                                  .experiences[
                                                                      index]
                                                                  .startDate,
                                                            ),
                                                          ),
                                                          IText.set(
                                                            text: '-',
                                                          ),
                                                          IText.set(
                                                            text: data
                                                                    .candidate
                                                                    .experiences[
                                                                        index]
                                                                    .currentlyWorking
                                                                ? 'Present'
                                                                : DateHelper
                                                                    .formatdMy(
                                                                    data
                                                                        .candidate
                                                                        .experiences[
                                                                            index]
                                                                        .endDate,
                                                                  ),
                                                          ),
                                                        ],
                                                      ),
                                                    ],
                                                  )
                                                ],
                                              ),
                                            ),
                                          );
                                        },
                                      )
                                    ],
                                  ),
                                )
                              ],
                            ),
                          ),
                        );
                      },
                    );
                  },
                );
              },
            ),
          ),
        ),
      ),
      bottomNavigationBar: Container(
        decoration: BoxDecoration(
          color: AppColors.bg200,
          boxShadow: AppColors.defaultShadow,
        ),
        child: Container(
          width: double.infinity,
          height: 50.h,
          margin: defaultPadding,
          child: ElevatedButton(
            onPressed: () async {
              await exportCV(context);
            },
            child: const Text('EXPORT CV'),
          ),
        ),
      ),
    );
  }
}
