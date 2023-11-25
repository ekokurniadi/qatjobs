import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/svg.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:qatjobs/core/constant/assets_constant.dart';
import 'package:qatjobs/core/helpers/date_helper.dart';
import 'package:qatjobs/core/helpers/global_helper.dart';
import 'package:qatjobs/core/styles/color_name_style.dart';
import 'package:qatjobs/core/styles/resolution_style.dart';
import 'package:qatjobs/core/styles/text_name_style.dart';
import 'package:qatjobs/core/widget/custom_appbar_widget.dart';
import 'package:qatjobs/core/widget/custom_cached_image_network.dart';
import 'package:qatjobs/core/widget/loading_dialog_widget.dart';
import 'package:qatjobs/core/widget/section_title_widget.dart';
import 'package:qatjobs/core/widget/vertical_space_widget.dart';
import 'package:qatjobs/core/widget/widget_chip.dart';
import 'package:qatjobs/features/profile/candidate/data/models/profile_candidate_models.codegen.dart';
import 'package:qatjobs/features/profile/employer/presentations/cubit/employer_cubit.dart';
import 'package:qatjobs/features/users/data/models/users_model.codegen.dart';

class CandidateDetailPage extends StatefulWidget {
  const CandidateDetailPage({
    super.key,
    required this.userModel,
  });

  final ProfileCandidateModels userModel;

  @override
  State<CandidateDetailPage> createState() => _CandidateDetailPageState();
}

class _CandidateDetailPageState extends State<CandidateDetailPage> {
  @override
  void initState() {
    context.read<EmployerCubit>().getDetailCandidate(widget.userModel.id);
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.bg300,
      appBar: const CustomAppBar(
        title: 'Candidate Detail',
        showLeading: true,
      ),
      body: BlocListener<EmployerCubit, EmployerState>(
        listener: (context, state) {
          if (state.status == EmployerStatus.loading) {
            LoadingDialog.show(message: 'Loading ...');
          } else {
            LoadingDialog.dismiss();
          }
        },
        child: BlocBuilder<EmployerCubit, EmployerState>(
          builder: (context, state) {
            return SingleChildScrollView(
              child: Container(
                padding: defaultPadding,
                child: Column(
                  children: [
                    Container(
                      padding: defaultPadding,
                      decoration: BoxDecoration(
                        borderRadius: defaultRadius,
                        boxShadow: AppColors.defaultShadow,
                        color: AppColors.bg200,
                      ),
                      width: double.infinity,
                      child: Row(
                        children: [
                          Container(
                            width: 90.w,
                            height: 90.w,
                            decoration:
                                const BoxDecoration(shape: BoxShape.circle),
                            child: ClipOval(
                              child: CustomImageNetwork(
                                imageUrl: state.candidateDetail.candidateDetails
                                        ?.user?.avatar ??
                                    '',
                                fit: BoxFit.cover,
                              ),
                            ),
                          ),
                          SizedBox(width: 16.w),
                          Expanded(
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                IText.set(
                                  text: state.candidateDetail.candidateDetails
                                          ?.user?.fullName ??
                                      '',
                                  styleName: TextStyleName.semiBold,
                                  typeName: TextTypeName.headline3,
                                ),
                                Row(
                                  children: [
                                    FaIcon(
                                      FontAwesomeIcons.briefcase,
                                      color: AppColors.warning,
                                      size: 21.sp,
                                    ),
                                    SizedBox(width: 8.w),
                                    Expanded(
                                      child: IText.set(
                                        text: state
                                                .candidateDetail
                                                .candidateDetails
                                                ?.functionalArea
                                                ?.name ??
                                            '',
                                        overflow: TextOverflow.ellipsis,
                                      ),
                                    ),
                                  ],
                                ),
                                Row(
                                  children: [
                                    FaIcon(
                                      FontAwesomeIcons.envelope,
                                      color: AppColors.warning,
                                      size: 21.sp,
                                    ),
                                    SizedBox(width: 8.w),
                                    IText.set(
                                      text: state.candidateDetail
                                              .candidateDetails?.user?.email ??
                                          '',
                                    ),
                                  ],
                                ),
                              ],
                            ),
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
                        children: [
                          const SectionTitleWidget(title: 'Educations'),
                          const SpaceWidget(),
                          if (!GlobalHelper.isEmptyList(
                              state.candidateDetail.candidateEducations))
                            ...List.generate(
                              state.candidateDetail.candidateEducations!.length,
                              (index) => Row(
                                crossAxisAlignment: CrossAxisAlignment.center,
                                children: [
                                  Icon(
                                    Icons.circle,
                                    size: 12.sp,
                                    color: AppColors.warning,
                                  ),
                                  SizedBox(width: 8.w),
                                  Column(
                                    crossAxisAlignment:
                                        CrossAxisAlignment.start,
                                    children: [
                                      IText.set(
                                        text: state
                                                .candidateDetail
                                                .candidateEducations![index]
                                                .degreeLevel
                                                ?.name ??
                                            '',
                                        styleName: TextStyleName.semiBold,
                                      ),
                                      Row(
                                        children: [
                                          IText.set(
                                            text: state
                                                    .candidateDetail
                                                    .candidateEducations![index]
                                                    .institute ??
                                                '',
                                          ),
                                          IText.set(
                                            text: ' - ',
                                          ),
                                          IText.set(
                                            text: (state
                                                        .candidateDetail
                                                        .candidateEducations![
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
                            ).toList()
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
                        children: [
                          const SectionTitleWidget(title: 'Work & Experiences'),
                          const SpaceWidget(),
                          if (!GlobalHelper.isEmptyList(
                              state.candidateDetail.candidateExperiences))
                            ...List.generate(
                              state
                                  .candidateDetail.candidateExperiences!.length,
                              (index) => Row(
                                crossAxisAlignment: CrossAxisAlignment.center,
                                children: [
                                  Icon(
                                    Icons.circle,
                                    size: 12.sp,
                                    color: AppColors.warning,
                                  ),
                                  SizedBox(width: 8.w),
                                  Column(
                                    crossAxisAlignment:
                                        CrossAxisAlignment.start,
                                    children: [
                                      IText.set(
                                        text: state
                                                .candidateDetail
                                                .candidateExperiences![index]
                                                .experienceTitle ??
                                            '',
                                        styleName: TextStyleName.semiBold,
                                      ),
                                      IText.set(
                                        text: state
                                                .candidateDetail
                                                .candidateExperiences![index]
                                                .company ??
                                            '',
                                      ),
                                      IText.set(
                                        text:
                                            '${DateHelper.formatdMy(state.candidateDetail.candidateExperiences![index].startDate)} - ${(state.candidateDetail.candidateExperiences![index].currentlyWorking ?? false) ? 'Present' : DateHelper.formatdMy(
                                                state
                                                    .candidateDetail
                                                    .candidateExperiences![
                                                        index]
                                                    .endDate,
                                              )}',
                                      ),
                                    ],
                                  )
                                ],
                              ),
                            ).toList()
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
                        children: [
                          const SectionTitleWidget(title: 'Skills'),
                          const SpaceWidget(),
                          if (!GlobalHelper.isEmptyList(state.candidateDetail
                              .candidateDetails?.user?.candidateSkill))
                            ...List.generate(
                              state.candidateDetail.candidateDetails!.user!
                                  .candidateSkill!.length,
                              (index) => Row(
                                crossAxisAlignment: CrossAxisAlignment.center,
                                children: [
                                  Icon(
                                    Icons.circle,
                                    size: 12.sp,
                                    color: AppColors.warning,
                                  ),
                                  SizedBox(width: 8.w),
                                  Column(
                                    crossAxisAlignment:
                                        CrossAxisAlignment.start,
                                    children: [
                                      IText.set(
                                        text: state
                                                .candidateDetail
                                                .candidateDetails!
                                                .user!
                                                .candidateSkill![index]
                                                .name ??
                                            '',
                                        styleName: TextStyleName.semiBold,
                                      ),
                                    ],
                                  )
                                ],
                              ),
                            ).toList()
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
                        children: [
                          const SectionTitleWidget(title: 'Social Media'),
                          const SpaceWidget(),
                          Row(
                            crossAxisAlignment: CrossAxisAlignment.center,
                            children: [
                              FaIcon(
                                FontAwesomeIcons.facebook,
                                size: 21.sp,
                                color: AppColors.warning,
                              ),
                              SizedBox(width: 8.w),
                              Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  IText.set(
                                    text: state.candidateDetail.candidateDetails
                                            ?.user?.facebookUrl ??
                                        '-',
                                    styleName: TextStyleName.semiBold,
                                  ),
                                ],
                              )
                            ],
                          ),
                          SizedBox(height: 8.h),
                          Row(
                            crossAxisAlignment: CrossAxisAlignment.center,
                            children: [
                              FaIcon(
                                FontAwesomeIcons.xTwitter,
                                size: 21.sp,
                                color: AppColors.warning,
                              ),
                              SizedBox(width: 8.w),
                              Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  IText.set(
                                    text: state.candidateDetail.candidateDetails
                                            ?.user?.twitterUrl ??
                                        '-',
                                    styleName: TextStyleName.semiBold,
                                  ),
                                ],
                              )
                            ],
                          ),
                          SizedBox(height: 8.h),
                          Row(
                            crossAxisAlignment: CrossAxisAlignment.center,
                            children: [
                              FaIcon(
                                FontAwesomeIcons.linkedin,
                                size: 21.sp,
                                color: AppColors.warning,
                              ),
                              SizedBox(width: 8.w),
                              Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  IText.set(
                                    text: state.candidateDetail.candidateDetails
                                            ?.user?.linkedinUrl ??
                                        '-',
                                    styleName: TextStyleName.semiBold,
                                  ),
                                ],
                              )
                            ],
                          ),
                          SizedBox(height: 8.h),
                          Row(
                            crossAxisAlignment: CrossAxisAlignment.center,
                            children: [
                              FaIcon(
                                FontAwesomeIcons.pinterest,
                                size: 21.sp,
                                color: AppColors.warning,
                              ),
                              SizedBox(width: 8.w),
                              Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  IText.set(
                                    text: state.candidateDetail.candidateDetails
                                            ?.user?.pinterestUrl ??
                                        '-',
                                    styleName: TextStyleName.semiBold,
                                  ),
                                ],
                              )
                            ],
                          ),
                          SizedBox(height: 8.h),
                          Row(
                            crossAxisAlignment: CrossAxisAlignment.center,
                            children: [
                              FaIcon(
                                FontAwesomeIcons.googlePlus,
                                size: 21.sp,
                                color: AppColors.warning,
                              ),
                              SizedBox(width: 8.w),
                              Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  IText.set(
                                    text: state.candidateDetail.candidateDetails
                                            ?.user?.googlePlusUrl ??
                                        '-',
                                    styleName: TextStyleName.semiBold,
                                  ),
                                ],
                              )
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
                        children: [
                          Row(
                            crossAxisAlignment: CrossAxisAlignment.center,
                            children: [
                              FaIcon(
                                FontAwesomeIcons.briefcase,
                                size: 21.sp,
                                color: AppColors.warning,
                              ),
                              SizedBox(width: 8.w),
                              Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  IText.set(
                                    text: 'Experiences',
                                  ),
                                  IText.set(
                                    text:
                                        '${state.candidateDetail.candidateDetails?.experience ?? 0} Years',
                                    styleName: TextStyleName.semiBold,
                                  ),
                                ],
                              )
                            ],
                          ),
                          SizedBox(height: 8.w),
                          Row(
                            crossAxisAlignment: CrossAxisAlignment.center,
                            children: [
                              FaIcon(
                                FontAwesomeIcons.venus,
                                size: 24.sp,
                                color: AppColors.warning,
                              ),
                              SizedBox(width: 8.w),
                              Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  IText.set(
                                    text: 'Gender',
                                  ),
                                  IText.set(
                                    text: state.candidateDetail.candidateDetails
                                                ?.user?.gender ==
                                            0
                                        ? 'Male'
                                        : 'Female',
                                    styleName: TextStyleName.semiBold,
                                  ),
                                ],
                              )
                            ],
                          ),
                          SizedBox(height: 8.w),
                          Row(
                            crossAxisAlignment: CrossAxisAlignment.center,
                            children: [
                              FaIcon(
                                FontAwesomeIcons.wallet,
                                size: 21.sp,
                                color: AppColors.warning,
                              ),
                              SizedBox(width: 8.w),
                              Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  IText.set(
                                    text: 'Current Salary',
                                  ),
                                  IText.set(
                                    text: (state
                                                .candidateDetail
                                                .candidateDetails
                                                ?.currentSalary ??
                                            0)
                                        .toString(),
                                    styleName: TextStyleName.semiBold,
                                  ),
                                ],
                              )
                            ],
                          ),
                          SizedBox(height: 8.w),
                          Row(
                            crossAxisAlignment: CrossAxisAlignment.center,
                            children: [
                              FaIcon(
                                FontAwesomeIcons.wallet,
                                size: 21.sp,
                                color: AppColors.warning,
                              ),
                              SizedBox(width: 8.w),
                              Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  IText.set(
                                    text: 'Expected Salary',
                                  ),
                                  IText.set(
                                    text: (state
                                                .candidateDetail
                                                .candidateDetails
                                                ?.expectedSalary ??
                                            0)
                                        .toString(),
                                    styleName: TextStyleName.semiBold,
                                  ),
                                ],
                              )
                            ],
                          ),
                        ],
                      ),
                    ),
                  ],
                ),
              ),
            );
          },
        ),
      ),
    );
  }
}
