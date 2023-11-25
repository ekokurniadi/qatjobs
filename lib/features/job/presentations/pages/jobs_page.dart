import 'package:auto_route/auto_route.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:lazy_load_scrollview/lazy_load_scrollview.dart';
import 'package:qatjobs/core/auto_route/auto_route.gr.dart';
import 'package:qatjobs/core/constant/app_constant.dart';
import 'package:qatjobs/core/constant/assets_constant.dart';
import 'package:qatjobs/core/helpers/global_helper.dart';
import 'package:qatjobs/core/styles/color_name_style.dart';
import 'package:qatjobs/core/styles/resolution_style.dart';
import 'package:qatjobs/core/styles/text_name_style.dart';
import 'package:qatjobs/core/widget/autocomplete_box_widget.dart';
import 'package:qatjobs/core/widget/custom_appbar_widget.dart';
import 'package:qatjobs/core/widget/custom_cached_image_network.dart';
import 'package:qatjobs/core/widget/loading_dialog_widget.dart';
import 'package:qatjobs/core/widget/pull_to_refresh_widget.dart';
import 'package:qatjobs/core/widget/shimmer_box_widget.dart';
import 'package:qatjobs/core/widget/vertical_space_widget.dart';
import 'package:qatjobs/core/widget/widget_chip.dart';
import 'package:qatjobs/features/job/data/models/job_filter.codegen.dart';
import 'package:qatjobs/features/job/presentations/bloc/bloc/jobs_bloc.dart';
import 'package:qatjobs/features/job/presentations/widgets/email_to_friend_dialog.dart';
import 'package:qatjobs/features/profile/candidate/presentations/bloc/profile_candidate_bloc.dart';
import 'package:qatjobs/features/users/presentations/bloc/user_bloc.dart';
import 'package:zoom_tap_animation/zoom_tap_animation.dart';
import 'package:timeago/timeago.dart' as timeago;

class JobsPage extends StatefulWidget {
  const JobsPage({super.key});

  @override
  State<JobsPage> createState() => _JobsPageState();
}

class _JobsPageState extends State<JobsPage> {
  @override
  void initState() {
    context.read<UserBloc>().add(const UserEvent.getLogedinUser());
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: CustomAppBar(
        title: 'Find Jobs',
        actionWidget: [
          BlocBuilder<JobsBloc, JobsState>(builder: (context, state) {
            return context.read<JobsBloc>().isJobFilterNotEmpty(state.jobFilter)
                ? TextButton(
                    onPressed: () {
                      context
                          .read<JobsBloc>()
                          .add(JobsEvent.getJobs(JobFilterModel(), false));
                    },
                    child: IText.set(
                      text: 'Reset Filter',
                      textAlign: TextAlign.left,
                      styleName: TextStyleName.regular,
                      typeName: TextTypeName.headline2,
                      color: AppColors.warning,
                    ),
                  )
                : const SizedBox.shrink();
          })
        ],
      ),
      body: BlocListener<UserBloc, UserState>(
        listener: (context, state) {
          if (state.user != null) {
            if (state.user!.roles!.isNotEmpty) {
              if (state.user!.roles!.first.name.toLowerCase() ==
                  AppConstant.roleCandidate) {
                context.read<JobsBloc>().add(const JobsEvent.getAppliedJob());
              }
            }
          }
        },
        child: Padding(
          padding: EdgeInsets.all(16.w),
          child: Column(
            children: [
              AutoCompleteBoxWidget(
                jobsBloc: context.read<JobsBloc>(),
              ),
              const SpaceWidget(),
              Flexible(
                child:
                    BlocBuilder<JobsBloc, JobsState>(builder: (context, state) {
                  return state.status == JobStatus.loading && state.jobs.isEmpty
                      ? ListView.builder(
                          itemCount: 3,
                          shrinkWrap: true,
                          itemBuilder: (context, index) {
                            return Container(
                              width: double.infinity,
                              padding: defaultPadding,
                              margin: EdgeInsets.only(bottom: 16.h),
                              decoration: BoxDecoration(
                                borderRadius: BorderRadius.circular(8.r),
                                color: AppColors.bg200,
                                boxShadow: AppColors.defaultShadow,
                              ),
                              child: ShimmerBoxWidget(
                                width: double.infinity,
                                height: 200.h,
                              ),
                            );
                          },
                        )
                      : state.jobs.isEmpty
                          ? Column(
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: [
                                SvgPicture.asset(AssetsConstant.illusJobEmpty),
                                const SpaceWidget(),
                                IText.set(
                                  text: 'Job is empty',
                                  textAlign: TextAlign.left,
                                  styleName: TextStyleName.medium,
                                  typeName: TextTypeName.large,
                                  color: AppColors.textPrimary,
                                  lineHeight: 1.2.h,
                                ),
                                const SpaceWidget(),
                                IText.set(
                                  text: 'Please check your keyword or filters',
                                  textAlign: TextAlign.left,
                                  styleName: TextStyleName.regular,
                                  typeName: TextTypeName.caption1,
                                  color: AppColors.textPrimary100,
                                )
                              ],
                            )
                          : LazyLoadScrollView(
                              onEndOfPage: () {
                                if (!state.hasMaxReached) {
                                  context.read<JobsBloc>().add(
                                        JobsEvent.getJobs(
                                          JobFilterModel(
                                              page: state.currentPage + 1),
                                          state.isFilterActive,
                                        ),
                                      );
                                }
                              },
                              child: PullToRefreshWidget(
                                onRefresh: () async {
                                  context.read<JobsBloc>().add(
                                        JobsEvent.getJobs(
                                          JobFilterModel(),
                                          true,
                                        ),
                                      );
                                },
                                child: ListView.builder(
                                  physics:
                                      const AlwaysScrollableScrollPhysics(),
                                  shrinkWrap: true,
                                  itemCount: state.jobs.length,
                                  itemBuilder: (context, index) {
                                    final data = state.jobs[index];
                                    final isAlreadyApplied = state.appliedJobs
                                        .any((element) =>
                                            element.job?.id == data.id);
                                    return ZoomTapAnimation(
                                      onTap: () {
                                        AutoRouter.of(context).push(
                                            JobDetailRoute(jobModel: data));
                                      },
                                      child: Container(
                                        width: double.infinity,
                                        padding: defaultPadding,
                                        margin: EdgeInsets.only(bottom: 16.h),
                                        decoration: BoxDecoration(
                                          borderRadius:
                                              BorderRadius.circular(8.r),
                                          color: AppColors.bg200,
                                          boxShadow: AppColors.defaultShadow,
                                        ),
                                        child: Column(
                                          crossAxisAlignment:
                                              CrossAxisAlignment.start,
                                          children: [
                                            SizedBox(
                                              width: double.infinity,
                                              child: Row(
                                                children: [
                                                  Container(
                                                    width: 80.w,
                                                    height: 80.w,
                                                    decoration:
                                                        const BoxDecoration(
                                                            shape: BoxShape
                                                                .circle),
                                                    child: ClipRRect(
                                                      borderRadius:
                                                          defaultRadius,
                                                      child: CustomImageNetwork(
                                                        width: 80.w,
                                                        imageUrl: data.company
                                                                ?.companyUrl ??
                                                            '',
                                                        customErrorWidget:
                                                            SvgPicture.asset(
                                                          AssetsConstant
                                                              .svgAssetsPicture,
                                                        ),
                                                      ),
                                                    ),
                                                  ),
                                                  const SpaceWidget(
                                                      direction:
                                                          Direction.horizontal),
                                                  Expanded(
                                                    child: Row(
                                                      children: [
                                                        Expanded(
                                                          flex: 2,
                                                          child: IText.set(
                                                            text: data
                                                                    .company
                                                                    ?.user
                                                                    ?.firstName ??
                                                                '',
                                                            textAlign:
                                                                TextAlign.left,
                                                            styleName:
                                                                TextStyleName
                                                                    .bold,
                                                            typeName:
                                                                TextTypeName
                                                                    .headline2,
                                                            color: AppColors
                                                                .textPrimary100,
                                                          ),
                                                        ),
                                                        SpaceWidget(
                                                          direction: Direction
                                                              .horizontal,
                                                          space: 8.w,
                                                        ),
                                                        if (!GlobalHelper
                                                            .isEmpty(
                                                          data.jobShift,
                                                        ))
                                                          Container(
                                                            padding:
                                                                const EdgeInsets
                                                                    .all(8),
                                                            decoration:
                                                                BoxDecoration(
                                                              borderRadius:
                                                                  BorderRadius
                                                                      .circular(
                                                                          8.r),
                                                              color: AppColors
                                                                  .danger50,
                                                            ),
                                                            child: IText.set(
                                                              text: data
                                                                      .jobShift
                                                                      ?.shift ??
                                                                  '',
                                                              textAlign:
                                                                  TextAlign
                                                                      .left,
                                                              styleName:
                                                                  TextStyleName
                                                                      .bold,
                                                              typeName:
                                                                  TextTypeName
                                                                      .caption2,
                                                              color: AppColors
                                                                  .danger100,
                                                            ),
                                                          ),
                                                      ],
                                                    ),
                                                  ),
                                                ],
                                              ),
                                            ),
                                            const SpaceWidget(),
                                            SizedBox(
                                              width: double.infinity,
                                              child: IText.set(
                                                text: state
                                                        .jobs[index].jobTitle ??
                                                    '-',
                                                textAlign: TextAlign.left,
                                                styleName:
                                                    TextStyleName.semiBold,
                                                typeName:
                                                    TextTypeName.headline3,
                                                color: AppColors.textPrimary100,
                                              ),
                                            ),
                                            if (!GlobalHelper.isEmpty(
                                                data.company?.location)) ...[
                                              SpaceWidget(
                                                space: 8.h,
                                              ),
                                              SizedBox(
                                                width: double.infinity,
                                                child: IText.set(
                                                  text:
                                                      '${data.company?.location ?? ''} ${data.company?.location2 ?? ''}',
                                                  textAlign: TextAlign.left,
                                                  styleName:
                                                      TextStyleName.regular,
                                                  typeName:
                                                      TextTypeName.caption1,
                                                  color:
                                                      AppColors.textPrimary100,
                                                ),
                                              ),
                                            ],
                                            if (!GlobalHelper.isEmptyList(
                                                data.jobsTag)) ...[
                                              SpaceWidget(
                                                space: 8.h,
                                              ),
                                              SizedBox(
                                                width: double.infinity,
                                                child: Wrap(
                                                  children: List.generate(
                                                    data.jobsTag!.length > 2
                                                        ? 3
                                                        : data.jobsTag!.length,
                                                    (i) => Container(
                                                      decoration: BoxDecoration(
                                                        color: AppColors.bg300,
                                                        boxShadow: AppColors
                                                            .defaultShadow,
                                                        borderRadius:
                                                            BorderRadius
                                                                .circular(
                                                          8.r,
                                                        ),
                                                      ),
                                                      margin: EdgeInsets.only(
                                                          right: 8.w,
                                                          bottom: 8.w),
                                                      padding:
                                                          const EdgeInsets.all(
                                                              8),
                                                      child: IText.set(
                                                        text: data
                                                            .jobsTag![i].name,
                                                        textAlign:
                                                            TextAlign.left,
                                                        styleName: TextStyleName
                                                            .regular,
                                                        typeName: TextTypeName
                                                            .caption2,
                                                        color: AppColors
                                                            .textPrimary,
                                                      ),
                                                    ),
                                                  ).toList(),
                                                ),
                                              ),
                                            ],
                                            if (!(data.hideSalary ?? true)) ...[
                                              SpaceWidget(
                                                space: 8.h,
                                              ),
                                              Row(
                                                children: [
                                                  IText.set(
                                                    text: data.currency
                                                            ?.currencyIcon ??
                                                        '',
                                                    textAlign: TextAlign.left,
                                                    styleName:
                                                        TextStyleName.regular,
                                                    typeName:
                                                        TextTypeName.caption1,
                                                    color:
                                                        AppColors.textPrimary,
                                                  ),
                                                  SpaceWidget(
                                                    direction:
                                                        Direction.horizontal,
                                                    space: 4.w,
                                                  ),
                                                  IText.set(
                                                    text: (data.salaryFrom ?? 0)
                                                        .toString(),
                                                    textAlign: TextAlign.left,
                                                    styleName:
                                                        TextStyleName.regular,
                                                    typeName:
                                                        TextTypeName.caption1,
                                                    color:
                                                        AppColors.textPrimary,
                                                  ),
                                                  IText.set(
                                                    text: '-',
                                                    textAlign: TextAlign.left,
                                                    styleName:
                                                        TextStyleName.regular,
                                                    typeName:
                                                        TextTypeName.caption1,
                                                    color:
                                                        AppColors.textPrimary,
                                                  ),
                                                  IText.set(
                                                    text: (data.salaryTo ?? 0)
                                                        .toString(),
                                                    textAlign: TextAlign.left,
                                                    styleName:
                                                        TextStyleName.regular,
                                                    typeName:
                                                        TextTypeName.caption1,
                                                    color:
                                                        AppColors.textPrimary,
                                                  )
                                                ],
                                              ),
                                            ],
                                            if (isAlreadyApplied) ...[
                                              const SpaceWidget(),
                                              const WidgetChip(
                                                content: 'Already Applied',
                                                backgroundColor:
                                                    AppColors.secondary,
                                                textColor:
                                                    AppColors.textPrimary100,
                                              ),
                                            ],
                                            const SpaceWidget(),
                                            Row(
                                              children: [
                                                Icon(
                                                  Icons.history,
                                                  size: 18.sp,
                                                  color: AppColors.neutral50,
                                                ),
                                                SpaceWidget(
                                                  direction:
                                                      Direction.horizontal,
                                                  space: 4.w,
                                                ),
                                                IText.set(
                                                  text: timeago.format(
                                                    DateTime.parse(
                                                      data.createdAt!,
                                                    ),
                                                  ),
                                                  textAlign: TextAlign.left,
                                                  styleName:
                                                      TextStyleName.regular,
                                                  typeName:
                                                      TextTypeName.caption2,
                                                  color: AppColors.neutral50,
                                                ),
                                                const Spacer(),
                                                BlocBuilder<UserBloc,
                                                    UserState>(
                                                  builder: (context, state) {
                                                    return state.user != null
                                                        ? Row(
                                                            mainAxisAlignment:
                                                                MainAxisAlignment
                                                                    .end,
                                                            children: [
                                                              BlocBuilder<
                                                                  ProfileCandidateBloc,
                                                                  ProfileCandidateState>(
                                                                builder: (context,
                                                                    profileState) {
                                                                  return PopupMenuButton(
                                                                    itemBuilder:
                                                                        (context) {
                                                                      return [
                                                                        PopupMenuItem(
                                                                          value:
                                                                              'email',
                                                                          child:
                                                                              Row(
                                                                            children: [
                                                                              IText.set(
                                                                                text: 'Email to friends',
                                                                                textAlign: TextAlign.left,
                                                                                styleName: TextStyleName.semiBold,
                                                                                typeName: TextTypeName.headline3,
                                                                                color: AppColors.textPrimary100,
                                                                              ),
                                                                            ],
                                                                          ),
                                                                        ),
                                                                      ];
                                                                    },
                                                                    icon: SvgPicture
                                                                        .asset(
                                                                      AssetsConstant
                                                                          .svgAssetsForward,
                                                                      color: AppColors
                                                                          .textPrimary100,
                                                                    ),
                                                                    onSelected:
                                                                        (value) async {
                                                                      switch (
                                                                          value) {
                                                                        default:
                                                                          await showDialog(
                                                                            context:
                                                                                context,
                                                                            builder:
                                                                                (context) {
                                                                              return EmailToFriendDialogBottomSheet(
                                                                                title: 'Email to Friend',
                                                                                caption: 'Send this job to your friend',
                                                                                jobId: data.id ?? 0,
                                                                              );
                                                                            },
                                                                          );
                                                                      }
                                                                    },
                                                                  );
                                                                },
                                                              ),
                                                            ],
                                                          )
                                                        : const SizedBox();
                                                  },
                                                ),
                                              ],
                                            ),
                                          ],
                                        ),
                                      ),
                                    );
                                  },
                                ),
                              ),
                            );
                }),
              )
            ],
          ),
        ),
      ),
    );
  }
}
