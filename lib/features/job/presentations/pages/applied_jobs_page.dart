import 'package:auto_route/auto_route.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:qatjobs/core/auto_route/auto_route.gr.dart';
import 'package:qatjobs/core/constant/assets_constant.dart';
import 'package:qatjobs/core/helpers/global_helper.dart';
import 'package:qatjobs/core/styles/color_name_style.dart';
import 'package:qatjobs/core/styles/resolution_style.dart';
import 'package:qatjobs/core/styles/text_name_style.dart';
import 'package:qatjobs/core/widget/custom_appbar_widget.dart';
import 'package:qatjobs/core/widget/custom_cached_image_network.dart';
import 'package:qatjobs/core/widget/loading_dialog_widget.dart';
import 'package:qatjobs/core/widget/vertical_space_widget.dart';
import 'package:qatjobs/features/job/presentations/bloc/bloc/jobs_bloc.dart';
import 'package:timeago/timeago.dart' as timeago;
import 'package:zoom_tap_animation/zoom_tap_animation.dart';

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
                        return ZoomTapAnimation(
                          onTap: () {
                            AutoRouter.of(context).push(
                              ApplyJobRoute(
                                jobId: data?.id ?? 0,
                                jobTitle: data?.jobTitle ?? '',
                                appliedJob: state.appliedJobs[index],
                              ),
                            );
                          },
                          child: Container(
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
                                      Container(
                                        decoration: BoxDecoration(
                                          color: AppColors.warning,
                                          boxShadow: AppColors.defaultShadow,
                                          borderRadius: BorderRadius.circular(
                                            8.r,
                                          ),
                                        ),
                                        margin: EdgeInsets.only(
                                            right: 8.w, bottom: 8.w),
                                        padding: const EdgeInsets.all(8),
                                        child: IText.set(
                                          text:
                                              state.appliedJobs[index].status ==
                                                      0
                                                  ? 'Draft'
                                                  : 'Applied',
                                          textAlign: TextAlign.left,
                                          styleName: TextStyleName.regular,
                                          typeName: TextTypeName.caption2,
                                          color: AppColors.bg200,
                                        ),
                                      )
                                    ],
                                  ),
                                ),
                                const SpaceWidget(),
                                SizedBox(
                                  width: double.infinity,
                                  child: IText.set(
                                    text: data?.jobTitle ?? '-',
                                    textAlign: TextAlign.left,
                                    styleName: TextStyleName.semiBold,
                                    typeName: TextTypeName.headline3,
                                    color: AppColors.textPrimary100,
                                  ),
                                ),
                                Row(
                                  children: [
                                    IText.set(
                                      text:
                                          data?.company?.user?.firstName ?? '',
                                      textAlign: TextAlign.left,
                                      styleName: TextStyleName.bold,
                                      typeName: TextTypeName.headline2,
                                      color: AppColors.textPrimary100,
                                    ),
                                    SpaceWidget(
                                      direction: Direction.horizontal,
                                      space: 8.w,
                                    ),
                                    if (!GlobalHelper.isEmpty(
                                      data?.jobShift,
                                    ))
                                      Container(
                                        padding: const EdgeInsets.all(8),
                                        decoration: BoxDecoration(
                                          borderRadius:
                                              BorderRadius.circular(8.r),
                                          color: AppColors.danger50,
                                        ),
                                        child: IText.set(
                                          text: data?.jobShift?.shift ?? '',
                                          textAlign: TextAlign.left,
                                          styleName: TextStyleName.bold,
                                          typeName: TextTypeName.caption2,
                                          color: AppColors.danger100,
                                        ),
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
                                if (!GlobalHelper.isEmptyList(
                                    data?.jobsTag)) ...[
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
                                        text:
                                            data?.currency?.currencyIcon ?? '',
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
                                        text:
                                            (data?.salaryFrom ?? 0).toString(),
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
                                  ],
                                )
                              ],
                            ),
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
