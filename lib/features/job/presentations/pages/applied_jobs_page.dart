import 'package:auto_route/auto_route.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:qatjobs/core/auto_route/auto_route.gr.dart';
import 'package:qatjobs/core/constant/assets_constant.dart';
import 'package:qatjobs/core/constant/global_constant.dart';
import 'package:qatjobs/core/helpers/global_helper.dart';
import 'package:qatjobs/core/styles/color_name_style.dart';
import 'package:qatjobs/core/styles/resolution_style.dart';
import 'package:qatjobs/core/styles/text_name_style.dart';
import 'package:qatjobs/core/widget/custom_appbar_widget.dart';
import 'package:qatjobs/core/widget/custom_cached_image_network.dart';
import 'package:qatjobs/core/widget/loading_dialog_widget.dart';
import 'package:qatjobs/core/widget/vertical_space_widget.dart';
import 'package:qatjobs/core/widget/widget_chip.dart';
import 'package:qatjobs/features/job/presentations/bloc/bloc/jobs_bloc.dart';
import 'package:qatjobs/features/job/presentations/pages/candidate_job_slots_page.dart';
import 'package:timeago/timeago.dart' as timeago;

class AppliedJobsPage extends StatelessWidget {
  const AppliedJobsPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.bg300,
      appBar: const CustomAppBar(
        title: 'Applied Job',
        showLeading: true,
      ),
      body: Padding(
        padding: defaultPadding,
        child: BlocListener<JobsBloc, JobsState>(
          listener: (context, state) {
            if (state.status == JobStatus.loading) {
              LoadingDialog.show(message: 'Loading ...');
            } else {
              LoadingDialog.dismiss();
            }
          },
          child: BlocBuilder<JobsBloc, JobsState>(
            builder: (context, state) {
              return state.appliedJobs.isEmpty
                  ? SizedBox(
                      width: double.infinity,
                      height: MediaQuery.sizeOf(context).height,
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        mainAxisSize: MainAxisSize.min,
                        children: [
                          SvgPicture.asset(AssetsConstant.illusJobEmpty),
                          const SpaceWidget(),
                          IText.set(
                            text: 'No Applied Jobs',
                            textAlign: TextAlign.left,
                            styleName: TextStyleName.medium,
                            typeName: TextTypeName.large,
                            color: AppColors.textPrimary,
                            lineHeight: 1.2.h,
                          ),
                          const SpaceWidget(),
                          IText.set(
                            text:
                                'You don\'t have any applied jobs saved, please\n find it in search to apply a jobs',
                            textAlign: TextAlign.center,
                            styleName: TextStyleName.regular,
                            typeName: TextTypeName.caption1,
                            color: AppColors.textPrimary100,
                          )
                        ],
                      ),
                    )
                  : ListView.builder(
                      itemCount: state.appliedJobs.length,
                      itemBuilder: (context, index) {
                        final data = state.appliedJobs[index].job;
                        return Container(
                          width: double.infinity,
                          padding: defaultPadding,
                          margin: EdgeInsets.only(bottom: 16.h),
                          decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(8.r),
                            color: AppColors.bg200,
                            boxShadow: AppColors.defaultShadow,
                          ),
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              SizedBox(
                                width: double.infinity,
                                child: Row(
                                  mainAxisAlignment:
                                      MainAxisAlignment.spaceBetween,
                                  children: [
                                    Container(
                                      width: 40.w,
                                      height: 40.w,
                                      decoration: const BoxDecoration(
                                          shape: BoxShape.circle),
                                      child: ClipOval(
                                        child: CustomImageNetwork(
                                          imageUrl:
                                              data?.company?.companyUrl ?? '',
                                          customErrorWidget: SvgPicture.asset(
                                            AssetsConstant.svgAssetsPicture,
                                          ),
                                        ),
                                      ),
                                    ),
                                    PopupMenuButton(
                                      onSelected: (value) async {
                                        if (value == 'view') {
                                          AutoRouter.of(context).push(
                                            ApplyJobRoute(
                                              jobId: data?.id ?? 0,
                                              jobTitle: data?.jobTitle ?? '',
                                              appliedJob:
                                                  state.appliedJobs[index],
                                            ),
                                          );
                                        } else {
                                          await showDialog(
                                            context: context,
                                            builder: (context) {
                                              return CandidateJobSlotPage(
                                                jobApplicationId:
                                                    state.appliedJobs[index].id,
                                              );
                                            },
                                          );
                                        }
                                      },
                                      itemBuilder: (context) {
                                        return [
                                          PopupMenuItem(
                                            value: 'view',
                                            child: IText.set(
                                              text: 'View',
                                            ),
                                          ),
                                          if (!GlobalHelper.isEmpty(state
                                              .appliedJobs[index].jobStage))
                                            PopupMenuItem(
                                              value: 'slots',
                                              child: IText.set(
                                                text: 'Slots',
                                              ),
                                            ),
                                        ];
                                      },
                                    )
                                  ],
                                ),
                              ),
                              const SpaceWidget(),
                              SizedBox(
                                width: double.infinity,
                                child: Row(
                                  children: [
                                    IText.set(
                                      text: data?.jobTitle ?? '-',
                                      textAlign: TextAlign.left,
                                      styleName: TextStyleName.semiBold,
                                      typeName: TextTypeName.headline3,
                                      color: AppColors.textPrimary100,
                                    ),
                                    SizedBox(width: 8.w),
                                    WidgetChip(
                                      backgroundColor: AppColors.secondary,
                                      textColor: AppColors.textPrimary100,
                                      content: GlobalConstant.getAppliedStatus(
                                        state.appliedJobs[index].status,
                                      ),
                                    )
                                  ],
                                ),
                              ),
                              if (!GlobalHelper.isEmpty(
                                  state.appliedJobs[index].jobStage)) ...[
                                Row(
                                  children: [
                                    IText.set(
                                      text: 'Job Stages : ',
                                      textAlign: TextAlign.left,
                                      styleName: TextStyleName.semiBold,
                                      color: AppColors.textPrimary100,
                                    ),
                                    IText.set(
                                      text: state.appliedJobs[index].jobStage
                                              ?.name ??
                                          '',
                                      textAlign: TextAlign.left,
                                      styleName: TextStyleName.regular,
                                      color: AppColors.textPrimary100,
                                    )
                                  ],
                                ),
                                const SpaceWidget(),
                              ],
                              if (!GlobalHelper.isEmpty(state.appliedJobs[index]
                                  .job?.company?.user?.fullName))
                                Row(
                                  children: [
                                    IText.set(
                                      text: state.appliedJobs[index].job
                                              ?.company?.user?.fullName ??
                                          '',
                                      textAlign: TextAlign.left,
                                      styleName: TextStyleName.bold,
                                      typeName: TextTypeName.headline4,
                                      color: AppColors.textPrimary100,
                                    ),
                                    SpaceWidget(
                                      direction: Direction.horizontal,
                                      space: 8.w,
                                    ),
                                  ],
                                ),
                              if (!GlobalHelper.isEmpty(
                                  data?.company?.location)) ...[
                                SpaceWidget(
                                  space: 8.h,
                                ),
                                SizedBox(
                                  width: double.infinity,
                                  child: IText.set(
                                    text:
                                        '${data?.company?.location ?? ''} ${data?.company?.location2 ?? ''}',
                                    textAlign: TextAlign.left,
                                    styleName: TextStyleName.regular,
                                    typeName: TextTypeName.caption1,
                                    color: AppColors.textPrimary100,
                                  ),
                                ),
                              ],
                              if (!GlobalHelper.isEmptyList(data?.jobsTag)) ...[
                                SpaceWidget(
                                  space: 8.h,
                                ),
                                SizedBox(
                                  width: double.infinity,
                                  child: Wrap(
                                    children: List.generate(
                                      (data?.jobsTag ?? []).length > 2
                                          ? 3
                                          : (data?.jobsTag ?? []).length,
                                      (i) => Container(
                                        decoration: BoxDecoration(
                                          color: AppColors.bg300,
                                          boxShadow: AppColors.defaultShadow,
                                          borderRadius: BorderRadius.circular(
                                            8.r,
                                          ),
                                        ),
                                        margin: EdgeInsets.only(
                                            right: 8.w, bottom: 8.w),
                                        padding: const EdgeInsets.all(8),
                                        child: IText.set(
                                          text: data?.jobsTag?[i].name ?? '',
                                          textAlign: TextAlign.left,
                                          styleName: TextStyleName.regular,
                                          typeName: TextTypeName.caption2,
                                          color: AppColors.textPrimary,
                                        ),
                                      ),
                                    ).toList(),
                                  ),
                                ),
                              ],
                              if (!(data?.hideSalary ?? true)) ...[
                                SpaceWidget(
                                  space: 8.h,
                                ),
                                Row(
                                  children: [
                                    IText.set(
                                      text: data?.currency?.currencyIcon ?? '',
                                      textAlign: TextAlign.left,
                                      styleName: TextStyleName.regular,
                                      typeName: TextTypeName.caption1,
                                      color: AppColors.textPrimary,
                                    ),
                                    SpaceWidget(
                                      direction: Direction.horizontal,
                                      space: 4.w,
                                    ),
                                    IText.set(
                                      text: (data?.salaryFrom ?? 0).toString(),
                                      textAlign: TextAlign.left,
                                      styleName: TextStyleName.regular,
                                      typeName: TextTypeName.caption1,
                                      color: AppColors.textPrimary,
                                    ),
                                    IText.set(
                                      text: '-',
                                      textAlign: TextAlign.left,
                                      styleName: TextStyleName.regular,
                                      typeName: TextTypeName.caption1,
                                      color: AppColors.textPrimary,
                                    ),
                                    IText.set(
                                      text: (data?.salaryTo ?? 0).toString(),
                                      textAlign: TextAlign.left,
                                      styleName: TextStyleName.regular,
                                      typeName: TextTypeName.caption1,
                                      color: AppColors.textPrimary,
                                    )
                                  ],
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
                                    direction: Direction.horizontal,
                                    space: 4.w,
                                  ),
                                  IText.set(
                                    text: timeago.format(
                                      DateTime.parse(data?.createdAt ??
                                          DateTime.now().toString()),
                                    ),
                                    textAlign: TextAlign.left,
                                    styleName: TextStyleName.regular,
                                    typeName: TextTypeName.caption2,
                                    color: AppColors.neutral50,
                                  ),
                                  Expanded(
                                    child: Align(
                                      alignment: Alignment.centerRight,
                                      child: WidgetChip(
                                        backgroundColor: AppColors.bg300,
                                        textColor: AppColors.textPrimary100,
                                        content:
                                            state.appliedJobs[index].status == 0
                                                ? 'On Draft'
                                                : 'Already Applied',
                                      ),
                                    ),
                                  )
                                ],
                              )
                            ],
                          ),
                        );
                      },
                    );
            },
          ),
        ),
      ),
    );
  }
}
