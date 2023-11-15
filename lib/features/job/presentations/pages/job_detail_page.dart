import 'package:auto_route/auto_route.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:qatjobs/core/auto_route/auto_route.gr.dart';
import 'package:qatjobs/core/constant/app_constant.dart';
import 'package:qatjobs/core/constant/assets_constant.dart';
import 'package:qatjobs/core/helpers/date_helper.dart';
import 'package:qatjobs/core/helpers/global_helper.dart';
import 'package:qatjobs/core/helpers/url_launcher_helper.dart';
import 'package:qatjobs/core/styles/color_name_style.dart';
import 'package:qatjobs/core/styles/resolution_style.dart';
import 'package:qatjobs/core/styles/text_name_style.dart';
import 'package:qatjobs/core/widget/custom_cached_image_network.dart';
import 'package:qatjobs/core/widget/loading_dialog_widget.dart';
import 'package:qatjobs/core/widget/section_title_widget.dart';
import 'package:qatjobs/core/widget/vertical_space_widget.dart';
import 'package:qatjobs/features/company/presentations/pages/company_detail_page.dart';
import 'package:qatjobs/features/job/data/models/job_model.codegen.dart';
import 'package:qatjobs/features/job/domain/usecases/save_to_favorite_job_usecase.dart';
import 'package:qatjobs/features/job/presentations/bloc/bloc/jobs_bloc.dart';
import 'package:qatjobs/features/profile/candidate/presentations/bloc/profile_candidate_bloc.dart';
import 'package:qatjobs/features/users/presentations/bloc/user_bloc.dart';
import 'package:timeago/timeago.dart' as timeago;
import 'package:flutter_html/flutter_html.dart';
import 'package:zoom_tap_animation/zoom_tap_animation.dart';

class JobDetailPage extends StatefulWidget {
  const JobDetailPage({
    super.key,
    required this.jobModel,
    this.isShowFavoriteButton = true,
  });
  final JobModel jobModel;
  final bool isShowFavoriteButton;

  @override
  State<JobDetailPage> createState() => _JobDetailPageState();
}

class _JobDetailPageState extends State<JobDetailPage> {
  @override
  void initState() {
    context
        .read<ProfileCandidateBloc>()
        .add(const ProfileCandidateEvent.getResume());
    context.read<JobsBloc>().add(const JobsEvent.getAppliedJob());
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.bg300,
      appBar: AppBar(
        automaticallyImplyLeading: true,
        title: IText.set(
          text: 'Job Detail',
          textAlign: TextAlign.left,
          styleName: TextStyleName.bold,
          typeName: TextTypeName.headline2,
          color: AppColors.textPrimary,
        ),
        backgroundColor: AppColors.bg200,
        elevation: 0.5,
      ),
      body: SizedBox(
        width: double.infinity,
        height: MediaQuery.sizeOf(context).height,
        child: SingleChildScrollView(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Container(
                width: double.infinity,
                height: 200.h,
                color: Colors.white,
                child: Stack(
                  children: [
                    Column(
                      children: [
                        Flexible(
                          flex: 2,
                          child: Container(
                            width: double.infinity,
                            color: Colors.white,
                          ),
                        ),
                        Flexible(
                          flex: 3,
                          child: Container(
                            width: double.infinity,
                            color: AppColors.neutral300,
                          ),
                        )
                      ],
                    ),
                    Positioned(
                      top: 15.h,
                      left: 0,
                      right: 0,
                      child: Column(
                        children: [
                          SizedBox(
                            width: double.infinity,
                            height: 100.h,
                            child: ZoomTapAnimation(
                              onTap: () {
                                if(widget.jobModel.company != null){
                                  Navigator.push(
                                  context,
                                  MaterialPageRoute(
                                    builder: (context) =>
                                        CompanyDetailPage(company: widget.jobModel.company!),
                                  ),
                                );
                                }
                                
                              },
                              child: Container(
                                width: 100.w,
                                height: 100.w,
                                decoration: BoxDecoration(
                                  color: AppColors.success,
                                  shape: BoxShape.circle,
                                  boxShadow: AppColors.defaultShadow,
                                ),
                                child: Center(
                                  child: ClipOval(
                                    child: CustomImageNetwork(
                                      width: 100.w,
                                      fit: BoxFit.cover,
                                      imageUrl:
                                          widget.jobModel.company?.companyUrl ??
                                              '',
                                      customErrorWidget: SvgPicture.asset(
                                        AssetsConstant.svgAssetsPicture,
                                      ),
                                    ),
                                  ),
                                ),
                              ),
                            ),
                          ),
                          SpaceWidget(
                            space: 8.h,
                          ),
                          IText.set(
                            text: widget.jobModel.jobTitle ?? '',
                            styleName: TextStyleName.bold,
                            typeName: TextTypeName.headline3,
                            color: AppColors.textPrimary,
                          ),
                          IText.set(
                            text: widget.jobModel.company?.user?.fullName ?? '',
                            styleName: TextStyleName.regular,
                            typeName: TextTypeName.headline3,
                            color: AppColors.textPrimary,
                          ),
                          IText.set(
                            text: timeago.format(DateTime.parse(
                                widget.jobModel.createdAt ??
                                    DateTime.now().toString())),
                            styleName: TextStyleName.regular,
                            typeName: TextTypeName.headline4,
                            color: AppColors.textPrimary100,
                          ),
                        ],
                      ),
                    ),
                  ],
                ),
              ),
              Padding(
                padding: defaultPadding.copyWith(top: 16.h, bottom: 0),
                child: const SectionTitleWidget(title: 'Job Description'),
              ),
              Padding(
                padding: defaultPadding.copyWith(top: 16.h, bottom: 0),
                child: Wrap(
                  children: List.generate(
                    (widget.jobModel.jobsTag ?? []).length,
                    (i) => Container(
                      decoration: BoxDecoration(
                        color: AppColors.secondary,
                        boxShadow: AppColors.defaultShadow,
                        borderRadius: BorderRadius.circular(
                          8.r,
                        ),
                      ),
                      margin: EdgeInsets.only(right: 8.w, bottom: 8.w),
                      padding: const EdgeInsets.all(8),
                      child: IText.set(
                        text: widget.jobModel.jobsTag?[i].name ?? '',
                        textAlign: TextAlign.left,
                        styleName: TextStyleName.regular,
                        typeName: TextTypeName.caption2,
                        color: AppColors.textPrimary,
                      ),
                    ),
                  ).toList(),
                ),
              ),
              Padding(
                padding: defaultPadding.copyWith(top: 0, bottom: 0),
                child: Html(
                  data: widget.jobModel.description,
                ),
              ),
              const Divider(),
              Padding(
                padding: defaultPadding.copyWith(top: 16.h, bottom: 0),
                child: const SectionTitleWidget(title: 'Job Category'),
              ),
              Padding(
                padding: defaultPadding.copyWith(top: 0, bottom: 0),
                child: IText.set(
                  text: widget.jobModel.jobCategory?.name ?? '-',
                  styleName: TextStyleName.regular,
                  typeName: TextTypeName.headline3,
                  color: AppColors.textPrimary100,
                ),
              ),
              Padding(
                padding: defaultPadding.copyWith(top: 16.h, bottom: 0),
                child: const SectionTitleWidget(title: 'Freelance Job'),
              ),
              Padding(
                padding: defaultPadding.copyWith(top: 0, bottom: 0),
                child: IText.set(
                  text: (widget.jobModel.isFreelance ?? false) ? 'Yes' : 'No',
                  styleName: TextStyleName.regular,
                  typeName: TextTypeName.headline3,
                  color: AppColors.textPrimary100,
                ),
              ),
              Padding(
                padding: defaultPadding.copyWith(top: 16.h, bottom: 0),
                child: const SectionTitleWidget(title: 'Job Shift'),
              ),
              Padding(
                padding: defaultPadding.copyWith(top: 0, bottom: 0),
                child: Container(
                  padding: const EdgeInsets.all(8),
                  decoration: BoxDecoration(
                    color: AppColors.danger50,
                    borderRadius: defaultRadius,
                  ),
                  child: IText.set(
                    text: widget.jobModel.jobShift?.shift ?? '-',
                    styleName: TextStyleName.regular,
                    typeName: TextTypeName.headline3,
                    color: AppColors.danger100,
                  ),
                ),
              ),
              Padding(
                padding: defaultPadding.copyWith(top: 16.h, bottom: 0),
                child: const SectionTitleWidget(title: 'Job Skill'),
              ),
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: List.generate(
                  (widget.jobModel.jobsSkill ?? []).length,
                  (index) => Padding(
                    padding: defaultPadding.copyWith(top: 0, bottom: 0),
                    child: Row(
                      children: [
                        IText.set(
                          text: '${index + 1}.',
                          styleName: TextStyleName.regular,
                          typeName: TextTypeName.headline3,
                          color: AppColors.textPrimary100,
                        ),
                        SizedBox(width: 4.w),
                        Expanded(
                          child: IText.set(
                            text: widget.jobModel.jobsSkill?[index].name ?? '-',
                            styleName: TextStyleName.regular,
                            typeName: TextTypeName.headline3,
                            color: AppColors.textPrimary100,
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
              ),
              Padding(
                padding: defaultPadding.copyWith(top: 16.h, bottom: 0),
                child: const SectionTitleWidget(title: 'Functional Area'),
              ),
              Padding(
                padding: defaultPadding.copyWith(top: 0, bottom: 0),
                child: IText.set(
                  text: widget.jobModel.functionalArea?.name ?? '',
                  styleName: TextStyleName.regular,
                  typeName: TextTypeName.headline3,
                  color: AppColors.textPrimary100,
                ),
              ),
              Padding(
                padding: defaultPadding.copyWith(top: 16.h, bottom: 0),
                child: const SectionTitleWidget(title: 'Degree Level'),
              ),
              Padding(
                padding: defaultPadding.copyWith(top: 0, bottom: 0),
                child: IText.set(
                  text: widget.jobModel.degreeLevel?.name ?? '-',
                  styleName: TextStyleName.regular,
                  typeName: TextTypeName.headline3,
                  color: AppColors.textPrimary100,
                ),
              ),
              Padding(
                padding: defaultPadding.copyWith(top: 16.h, bottom: 0),
                child: const SectionTitleWidget(title: 'Career Level'),
              ),
              Padding(
                padding: defaultPadding.copyWith(top: 0, bottom: 0),
                child: IText.set(
                  text: widget.jobModel.careerLevel?.levelName ?? '',
                  styleName: TextStyleName.regular,
                  typeName: TextTypeName.headline3,
                  color: AppColors.textPrimary100,
                ),
              ),
              Padding(
                padding: defaultPadding.copyWith(top: 16.h, bottom: 0),
                child: const SectionTitleWidget(title: 'Experiences'),
              ),
              Padding(
                padding: defaultPadding.copyWith(top: 0, bottom: 0),
                child: IText.set(
                  text: '${widget.jobModel.experience ?? 0} Year',
                  styleName: TextStyleName.regular,
                  typeName: TextTypeName.headline3,
                  color: AppColors.textPrimary100,
                ),
              ),
              Padding(
                padding: defaultPadding.copyWith(top: 16.h, bottom: 0),
                child: const SectionTitleWidget(title: 'Salary Period'),
              ),
              Padding(
                padding: defaultPadding.copyWith(top: 0, bottom: 0),
                child: IText.set(
                  text: widget.jobModel.salaryPeriod?.period ?? '',
                  styleName: TextStyleName.regular,
                  typeName: TextTypeName.headline3,
                  color: AppColors.textPrimary100,
                ),
              ),
              if (!(widget.jobModel.hideSalary ?? true)) ...[
                Padding(
                  padding: defaultPadding.copyWith(top: 16.h, bottom: 0),
                  child: const SectionTitleWidget(title: 'Salary'),
                ),
                Padding(
                  padding: defaultPadding.copyWith(top: 0, bottom: 0),
                  child: Row(
                    children: [
                      IText.set(
                        text: widget.jobModel.currency?.currencyIcon ?? '',
                        styleName: TextStyleName.regular,
                        typeName: TextTypeName.headline3,
                        color: AppColors.textPrimary100,
                      ),
                      IText.set(
                        text:
                            ' ${widget.jobModel.salaryFrom ?? 0} - ${widget.jobModel.salaryTo ?? 0}',
                        styleName: TextStyleName.regular,
                        typeName: TextTypeName.headline3,
                        color: AppColors.textPrimary100,
                      ),
                    ],
                  ),
                ),
              ],
              Padding(
                padding: defaultPadding.copyWith(top: 16.h, bottom: 0),
                child: const SectionTitleWidget(title: 'Job Expired'),
              ),
              Padding(
                padding: defaultPadding.copyWith(top: 0, bottom: 0),
                child: IText.set(
                  text: DateHelper.formatdMy(widget.jobModel.jobExpiryDate),
                  styleName: TextStyleName.regular,
                  typeName: TextTypeName.headline3,
                  color: AppColors.textPrimary100,
                ),
              ),
              const Divider(),
              Padding(
                padding: defaultPadding.copyWith(top: 16.h, bottom: 0),
                child: const SectionTitleWidget(title: 'About Company'),
              ),
              Padding(
                padding: defaultPadding.copyWith(top: 0, bottom: 0),
                child: Html(
                  data: widget.jobModel.company?.details ?? '-',
                ),
              ),
              Padding(
                padding: defaultPadding.copyWith(top: 16.h, bottom: 0),
                child: const SectionTitleWidget(title: 'Website'),
              ),
              Padding(
                padding: defaultPadding.copyWith(top: 0, bottom: 0),
                child: Row(
                  children: [
                    ZoomTapAnimation(
                      onTap: () async {
                        if (!GlobalHelper.isEmpty(
                            widget.jobModel.company?.website)) {
                          await UrlLauncherHelper.openUrl(
                            widget.jobModel.company!.website!,
                          );
                        }
                      },
                      child: Row(
                        children: [
                          IText.set(
                            text: widget.jobModel.company?.website ?? '-',
                            styleName: TextStyleName.regular,
                            typeName: TextTypeName.headline3,
                            color: AppColors.secondary200,
                            textDecoration: TextDecoration.underline,
                          ),
                          SizedBox(width: 8.w),
                          FaIcon(
                            FontAwesomeIcons.externalLink,
                            size: 16.sp,
                          )
                        ],
                      ),
                    ),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
      bottomNavigationBar: MultiBlocListener(
        listeners: [
          BlocListener<JobsBloc, JobsState>(
            listener: (context, state) {
              if (state.status == JobStatus.loading) {
                LoadingDialog.show(message: 'Loading...');
              } else if (state.status == JobStatus.insertFavJob ||
                  state.status == JobStatus.deleted) {
                LoadingDialog.dismiss();
                LoadingDialog.showSuccess(message: state.message);
                context.read<JobsBloc>().add(const JobsEvent.getFavoriteJob());
              } else {
                LoadingDialog.dismiss();
              }
            },
          ),
          BlocListener<UserBloc, UserState>(
            listener: (context, state) {
              if (!GlobalHelper.isEmpty(state.user)) {
                context.read<JobsBloc>().add(const JobsEvent.getFavoriteJob());
                context.read<JobsBloc>().add(const JobsEvent.getAppliedJob());
              }
            },
          ),
        ],
        child: BlocBuilder<JobsBloc, JobsState>(
          builder: (context, jobState) {
            return BlocBuilder<UserBloc, UserState>(
              builder: (context, userState) {
                return Container(
                  padding: defaultPadding,
                  decoration: BoxDecoration(
                    color: AppColors.bg200,
                    boxShadow: AppColors.defaultShadow,
                  ),
                  child: Row(
                    children: [
                      if (widget.isShowFavoriteButton) ...[
                        SizedBox(
                          width: 50.w,
                          height: 50.h,
                          child: ElevatedButton(
                            style: ElevatedButton.styleFrom(
                              backgroundColor: AppColors.bg200,
                              shadowColor: AppColors.bg200,
                            ),
                            onPressed: jobState.favoriteJobs.any((element) =>
                                    element.job.id == widget.jobModel.id)
                                ? () {
                                    if (userState.user == null ||
                                        userState.user?.id == 0) {
                                      LoadingDialog.showError(
                                        message:
                                            'Please login for save job to favorite',
                                      );
                                      AutoRouter.of(context)
                                          .push(const LoginRoute());
                                    } else {
                                      context.read<JobsBloc>().add(
                                            JobsEvent.deleteFavoriteJob(
                                              jobState.favoriteJobs
                                                  .where((element) =>
                                                      element.job.id ==
                                                      widget.jobModel.id)
                                                  .first
                                                  .id,
                                            ),
                                          );
                                    }
                                  }
                                : () {
                                    if (userState.user == null ||
                                        userState.user?.id == 0) {
                                      LoadingDialog.showError(
                                        message:
                                            'Please login for save job to favorite',
                                      );
                                      AutoRouter.of(context)
                                          .push(const LoginRoute());
                                    } else {
                                      context.read<JobsBloc>().add(
                                            JobsEvent.saveFavoriteJob(
                                              FavoriteJobRequestParams(
                                                jobId: widget.jobModel.id ?? 0,
                                                userId: userState.user?.id ?? 0,
                                              ),
                                            ),
                                          );
                                    }
                                  },
                            child: jobState.favoriteJobs.any((element) =>
                                        element.job.id == widget.jobModel.id) &&
                                    !GlobalHelper.isEmpty(userState.user)
                                ? const Icon(
                                    Icons.favorite,
                                    color: AppColors.danger100,
                                  )
                                : const Icon(
                                    Icons.favorite_border,
                                    color: AppColors.warning,
                                  ),
                          ),
                        ),
                        SpaceWidget(
                          direction: Direction.horizontal,
                          space: 16.w,
                        ),
                      ],
                      Expanded(
                        child: BlocBuilder<ProfileCandidateBloc,
                            ProfileCandidateState>(builder: (context, state) {
                          return SizedBox(
                            height: 50.h,
                            child: ElevatedButton(
                              onPressed: () {
                                if (jobState.appliedJobs.any((element) =>
                                    element.job.id == widget.jobModel.id)) {
                                  LoadingDialog.showError(
                                    message: 'This job Already applied',
                                  );
                                  return;
                                }

                                if (state.resumes.isEmpty) {
                                  LoadingDialog.showError(
                                    message:
                                        'Please add your resume before apply this jobs',
                                  );
                                  return;
                                }
                                if (userState.user == null ||
                                    userState.user?.id == 0) {
                                  LoadingDialog.showError(
                                    message:
                                        'Please login for save job to favorite',
                                  );
                                  AutoRouter.of(context)
                                      .push(const LoginRoute());
                                } else if (userState.user!.roles!.first.name
                                        .toLowerCase() ==
                                    AppConstant.roleCandidate) {
                                  AutoRouter.of(context).push(
                                    ApplyJobRoute(
                                      jobId: widget.jobModel.id ?? 0,
                                      jobTitle: widget.jobModel.jobTitle ?? '',
                                    ),
                                  );
                                }
                              },
                              child: const Text('Apply Now'),
                            ),
                          );
                        }),
                      ),
                    ],
                  ),
                );
              },
            );
          },
        ),
      ),
    );
  }
}
