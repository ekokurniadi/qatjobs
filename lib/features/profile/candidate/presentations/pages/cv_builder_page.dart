import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:path/path.dart' as path;
import 'package:permission_handler/permission_handler.dart';
import 'package:qatjobs/core/constant/assets_constant.dart';
import 'package:qatjobs/core/helpers/date_helper.dart';
import 'package:qatjobs/core/helpers/file_downloader_helper.dart';
import 'package:qatjobs/core/helpers/global_helper.dart';
import 'package:qatjobs/core/helpers/notification_helper.dart';
import 'package:qatjobs/core/styles/color_name_style.dart';
import 'package:qatjobs/core/styles/resolution_style.dart';
import 'package:qatjobs/core/styles/text_name_style.dart';
import 'package:qatjobs/core/widget/custom_appbar_widget.dart';
import 'package:qatjobs/core/widget/custom_cached_image_network.dart';
import 'package:qatjobs/core/widget/loading_dialog_widget.dart';
import 'package:qatjobs/core/widget/pull_to_refresh_widget.dart';
import 'package:qatjobs/core/widget/section_title_widget.dart';
import 'package:qatjobs/core/widget/vertical_space_widget.dart';
import 'package:qatjobs/features/profile/candidate/data/models/cv_builder_models.codegen.dart';
import 'package:qatjobs/features/profile/candidate/presentations/bloc/profile_candidate_bloc.dart';
import 'package:qatjobs/features/profile/candidate/presentations/pages/cv_builder_pdf_preview.dart';
import 'package:qatjobs/features/profile/candidate/presentations/pages/cv_pdf_generator.dart';
import 'package:screenshot/screenshot.dart';
import 'package:zoom_tap_animation/zoom_tap_animation.dart';

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

  Future<void> exportCV(
    BuildContext parentcontext,
    String mode,
    CvBuilderResponseModels data,
  ) async {
    LoadingDialog.show(message: 'Loading ...');
    final result = await CvPdfGenerator().generate(
      data,
      parentcontext,
    );
    LoadingDialog.dismiss();
    if (mode == 'preview') {
      if (result != null) {
        LoadingDialog.dismiss();
        Navigator.push(
          context,
          MaterialPageRoute(
            builder: (parentcontext) {
              return CVBuilderPdfPreview(document: result);
            },
          ),
        );
      }
    } else if (mode == 'export') {
      NotificationService().showNotification(
        id: 2,
        title: 'CV Builder',
        body: 'Exporting your CV',
      );

      var status = await Permission.storage.status;
      if (!status.isGranted) {
        await Permission.storage.request();
      }
      final basePath = await FileDownloaderHelper.getDownloadPath();
      String savePath = path.join(
        basePath ?? '',
        '${DateTime.now().millisecondsSinceEpoch}.pdf',
      );
      final file = File(savePath);
      final savedFile = await file.writeAsBytes(result!);
      NotificationService().showNotification(
        id: 2,
        title: 'CV Builder',
        body: 'Exporting your CV Complete',
        payLoad: savedFile.path,
      );
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
                          padding: defaultPadding,
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
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    Row(
                                      mainAxisAlignment:
                                          MainAxisAlignment.start,
                                      children: [
                                        Container(
                                          decoration: BoxDecoration(
                                            shape: BoxShape.circle,
                                            border: Border.all(
                                              color: AppColors.neutral,
                                            ),
                                          ),
                                          child: ClipOval(
                                            child: CustomImageNetwork(
                                              width: 90.w,
                                              fit: BoxFit.cover,
                                              imageUrl:
                                                  data.candidate.user?.avatar ??
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
                                        ),
                                        SizedBox(width: 16.w),
                                        Expanded(
                                          child: Column(
                                            crossAxisAlignment:
                                                CrossAxisAlignment.start,
                                            children: [
                                              SectionTitleWidget(
                                                title: data.candidate.user
                                                        ?.fullName ??
                                                    '',
                                              ),
                                              SocialMediaCardInfo(
                                                icon: FaIcon(
                                                  FontAwesomeIcons.envelope,
                                                  color: AppColors.warning,
                                                  size: 12.sp,
                                                ),
                                                title: '',
                                                value: data.candidate.user
                                                        ?.email ??
                                                    '-',
                                                boldValue: false,
                                              ),
                                              SocialMediaCardInfo(
                                                icon: FaIcon(
                                                  FontAwesomeIcons.phone,
                                                  color: AppColors.warning,
                                                  size: 12.sp,
                                                ),
                                                title: '',
                                                value: data.candidate.user
                                                        ?.phone ??
                                                    '-',
                                                boldValue: false,
                                              ),
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
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    const SectionTitleWidget(
                                      title: 'Skill',
                                      textColor: AppColors.primary,
                                    ),
                                    const Divider(),
                                    if (GlobalHelper.isEmptyList(
                                        data.candidateSkill))
                                      IText.set(
                                        text:
                                            'No data show here, please add your skill',
                                      ),
                                    if (!GlobalHelper.isEmptyList(
                                        data.candidateSkill))
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
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    const SectionTitleWidget(
                                      title: 'Education',
                                      textColor: AppColors.primary,
                                    ),
                                    const Divider(),
                                    if (GlobalHelper.isEmptyList(
                                        data.candidate.educations))
                                      IText.set(
                                        text:
                                            'No data show here, please add your educations',
                                      ),
                                    if (!GlobalHelper.isEmptyList(
                                        data.candidate.educations))
                                      ListView.builder(
                                        physics:
                                            const NeverScrollableScrollPhysics(),
                                        shrinkWrap: true,
                                        itemCount:
                                            data.candidate.educations?.length,
                                        itemBuilder: (context, index) {
                                          return Padding(
                                            padding:
                                                EdgeInsets.only(bottom: 8.h),
                                            child: SizedBox(
                                              width: double.infinity,
                                              child: Row(
                                                crossAxisAlignment:
                                                    CrossAxisAlignment.start,
                                                children: [
                                                  Padding(
                                                    padding: EdgeInsets.only(
                                                      top: 4.h,
                                                    ),
                                                    child: Icon(
                                                      Icons.circle,
                                                      color: AppColors.warning,
                                                      size: 12.sp,
                                                    ),
                                                  ),
                                                  SizedBox(width: 8.w),
                                                  Column(
                                                    crossAxisAlignment:
                                                        CrossAxisAlignment
                                                            .start,
                                                    children: [
                                                      Row(
                                                        children: [
                                                          IText.set(
                                                            text:
                                                                'Institute : ',
                                                          ),
                                                          IText.set(
                                                            text: data
                                                                    .candidate
                                                                    .educations?[
                                                                        index]
                                                                    .institute ??
                                                                '',
                                                          ),
                                                        ],
                                                      ),
                                                      Row(
                                                        children: [
                                                          IText.set(
                                                            text:
                                                                'Degree Level : ',
                                                          ),
                                                          IText.set(
                                                            text: data
                                                                    .candidate
                                                                    .educations?[
                                                                        index]
                                                                    .degreeLevel
                                                                    ?.name ??
                                                                '',
                                                          ),
                                                        ],
                                                      ),
                                                      Row(
                                                        children: [
                                                          IText.set(
                                                            text: 'Result : ',
                                                          ),
                                                          IText.set(
                                                            text: data
                                                                    .candidate
                                                                    .educations?[
                                                                        index]
                                                                    .result ??
                                                                '',
                                                          ),
                                                        ],
                                                      ),
                                                      Row(
                                                        children: [
                                                          IText.set(
                                                            text: 'Year : ',
                                                          ),
                                                          IText.set(
                                                            text: (data
                                                                        .candidate
                                                                        .educations?[
                                                                            index]
                                                                        .year ??
                                                                    0)
                                                                .toString(),
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
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    const SectionTitleWidget(
                                      title: 'Experiences',
                                      textColor: AppColors.primary,
                                    ),
                                    const Divider(),
                                    if (GlobalHelper.isEmptyList(
                                        data.candidate.experiences))
                                      IText.set(
                                        text:
                                            'No data show here, please add your experiences',
                                      ),
                                    if (!GlobalHelper.isEmptyList(
                                        data.candidate.experiences))
                                      ListView.builder(
                                        physics:
                                            const NeverScrollableScrollPhysics(),
                                        shrinkWrap: true,
                                        itemCount:
                                            data.candidate.experiences!.length,
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
                                                            .experiences![index]
                                                            .experienceTitle,
                                                        styleName:
                                                            TextStyleName.bold,
                                                      ),
                                                      IText.set(
                                                        text: data
                                                            .candidate
                                                            .experiences![index]
                                                            .company,
                                                      ),
                                                      Row(
                                                        children: [
                                                          IText.set(
                                                            text: DateHelper
                                                                .formatdMy(
                                                              data
                                                                  .candidate
                                                                  .experiences![
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
                                                                    .experiences![
                                                                        index]
                                                                    .currentlyWorking
                                                                ? 'Present'
                                                                : DateHelper
                                                                    .formatdMy(
                                                                    data
                                                                        .candidate
                                                                        .experiences![
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
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    const SectionTitleWidget(
                                      title: 'Social Media',
                                      textColor: AppColors.primary,
                                    ),
                                    const Divider(),
                                    SocialMediaCardInfo(
                                      icon: FaIcon(
                                        FontAwesomeIcons.facebook,
                                        color: AppColors.warning,
                                        size: 28.sp,
                                      ),
                                      title: 'Facebook',
                                      value: data.candidate.user?.facebookUrl ??
                                          '-',
                                    ),
                                    const SpaceWidget(),
                                    SocialMediaCardInfo(
                                      icon: FaIcon(
                                        FontAwesomeIcons.linkedin,
                                        color: AppColors.warning,
                                        size: 28.sp,
                                      ),
                                      title: 'Linkedin',
                                      value: data.candidate.user?.linkedinUrl ??
                                          '-',
                                    ),
                                    const SpaceWidget(),
                                    SocialMediaCardInfo(
                                      icon: FaIcon(
                                        FontAwesomeIcons.xTwitter,
                                        color: AppColors.warning,
                                        size: 28.sp,
                                      ),
                                      title: 'Twitter',
                                      value: data.candidate.user?.twitterUrl ??
                                          '-',
                                    ),
                                    const SpaceWidget(),
                                    SocialMediaCardInfo(
                                      icon: FaIcon(
                                        FontAwesomeIcons.googlePlus,
                                        color: AppColors.warning,
                                        size: 28.sp,
                                      ),
                                      title: 'Google+',
                                      value:
                                          data.candidate.user?.googlePlusUrl ??
                                              '-',
                                    ),
                                    const SpaceWidget(),
                                    SocialMediaCardInfo(
                                      icon: FaIcon(
                                        FontAwesomeIcons.pinterest,
                                        color: AppColors.warning,
                                        size: 28.sp,
                                      ),
                                      title: 'Pinterest',
                                      value:
                                          data.candidate.user?.pinterestUrl ??
                                              '-',
                                    ),
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
      bottomNavigationBar:
          BlocBuilder<ProfileCandidateBloc, ProfileCandidateState>(
        builder: (context, state) {
          return state.cvBuilder.fold(() => const SizedBox(), (a) {
            return a.fold(
              (l) => const SizedBox(),
              (data) {
                return Container(
                  padding: defaultPadding,
                  decoration: BoxDecoration(
                    color: AppColors.bg200,
                    boxShadow: AppColors.defaultShadow,
                  ),
                  child: Row(
                    children: [
                      Expanded(
                        child: SizedBox(
                          height: 50.h,
                          child: ElevatedButton(
                            style: ElevatedButton.styleFrom(
                              backgroundColor: AppColors.secondary,
                            ),
                            onPressed: () async {
                              await exportCV(
                                context,
                                'preview',
                                data,
                              );
                            },
                            child: IText.set(
                              text: 'PREVIEW',
                              styleName: TextStyleName.semiBold,
                              color: AppColors.textPrimary100,
                            ),
                          ),
                        ),
                      ),
                      SizedBox(width: 8.w),
                      Expanded(
                        child: SizedBox(
                          height: 50.h,
                          child: ElevatedButton(
                            onPressed: () async {
                              await exportCV(
                                context,
                                'export',
                                data,
                              );
                            },
                            child: const Text('EXPORT'),
                          ),
                        ),
                      ),
                    ],
                  ),
                );
              },
            );
          });
        },
      ),
    );
  }
}

class SocialMediaCardInfo extends StatelessWidget {
  const SocialMediaCardInfo({
    super.key,
    required this.icon,
    required this.title,
    required this.value,
    this.onTap,
    this.boldValue = true,
  });

  final FaIcon icon;
  final String title;
  final String value;
  final VoidCallback? onTap;
  final bool? boldValue;

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        SizedBox(
          width: double.infinity,
          child: Row(
            children: [
              icon,
              SizedBox(width: 8.w),
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  if (title != '')
                    IText.set(
                      text: title,
                      styleName: TextStyleName.regular,
                      typeName: TextTypeName.headline3,
                      color: AppColors.textPrimary100,
                    ),
                  ZoomTapAnimation(
                    onTap: onTap,
                    child: Row(
                      children: [
                        IText.set(
                          text: value,
                          styleName: boldValue!
                              ? TextStyleName.bold
                              : TextStyleName.regular,
                          typeName: TextTypeName.headline3,
                          color: AppColors.textPrimary,
                        ),
                        if (onTap != null) ...[
                          SizedBox(width: 8.w),
                          FaIcon(
                            FontAwesomeIcons.externalLink,
                            size: 16.sp,
                          )
                        ],
                      ],
                    ),
                  ),
                ],
              ),
            ],
          ),
        )
      ],
    );
  }
}
