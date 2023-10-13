import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:qatjobs/core/constant/assets_constant.dart';
import 'package:qatjobs/core/helpers/global_helper.dart';
import 'package:qatjobs/core/styles/color_name_style.dart';
import 'package:qatjobs/core/styles/resolution_style.dart';
import 'package:qatjobs/core/styles/text_name_style.dart';
import 'package:qatjobs/core/widget/custom_cached_image_network.dart';
import 'package:qatjobs/core/widget/section_title_widget.dart';
import 'package:qatjobs/core/widget/vertical_space_widget.dart';
import 'package:qatjobs/core/widget/autocomplete_box_widget.dart';
import 'package:qatjobs/features/job/presentations/bloc/bloc/jobs_bloc.dart';
import 'package:qatjobs/injector.dart';
import 'package:timeago/timeago.dart' as timeago;

class JobPage extends StatefulWidget {
  const JobPage({super.key});

  @override
  State<JobPage> createState() => _JobPageState();
}

class _JobPageState extends State<JobPage> {
  late JobsBloc jobsBloc;

  @override
  void initState() {
    jobsBloc = getIt<JobsBloc>();
    jobsBloc.add(const JobsEvent.getJobs());
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      resizeToAvoidBottomInset: false,
      backgroundColor: AppColors.bg300,
      body: SizedBox(
        width: double.infinity,
        height: MediaQuery.sizeOf(context).height,
        child: Column(
          children: [
            SizedBox(
              width: double.infinity,
              child: Stack(
                children: [
                  Image.asset(
                    'assets/images/img-card-bg.png',
                    fit: BoxFit.cover,
                    width: MediaQuery.sizeOf(context).width,
                    height: 200.h,
                  ),
                  Align(
                    alignment: Alignment.center,
                    child: Container(
                      padding: const EdgeInsets.all(24),
                      child: Column(
                        children: [
                          SizedBox(
                            width: double.infinity,
                            child: IText.set(
                              text: 'Find your dream job\nhere!',
                              textAlign: TextAlign.left,
                              styleName: TextStyleName.bold,
                              typeName: TextTypeName.large,
                              color: AppColors.bg100,
                              lineHeight: 1.2.h,
                            ),
                          ),
                          SpaceWidget(
                            space: 16.h,
                          ),
                          const AutoCompleteBoxWidget(),
                        ],
                      ),
                    ),
                  )
                ],
              ),
            ),
            Padding(
              padding: EdgeInsets.symmetric(
                horizontal: 16.w,
              ),
              child: const SectionTitleWidget(
                title: 'Job List',
              ),
            ),
            Flexible(
              child: BlocBuilder(
                bloc: jobsBloc,
                builder: (context, JobsState state) {
                  if (state.status == JobStatus.loading) {
                    return const Center(
                      child: CircularProgressIndicator(),
                    );
                  }
                  return state.jobs.isEmpty || state.status == JobStatus.failure
                      ? Column(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            SvgPicture.asset(AssetsConstant.illusJobEmpty),
                            const SpaceWidget(),
                            IText.set(
                              text: 'Job is empty',
                              textAlign: TextAlign.left,
                              styleName: TextStyleName.bold,
                              typeName: TextTypeName.large,
                              color: AppColors.bg100,
                              lineHeight: 1.2.h,
                            )
                          ],
                        )
                      : ListView.builder(
                          padding: defaultPadding,
                          shrinkWrap: true,
                          itemCount: state.jobs.length,
                          itemBuilder: (context, index) {
                            final data = state.jobs[index];
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
                                      children: [
                                        Container(
                                          width: 40.w,
                                          height: 40.w,
                                          decoration: const BoxDecoration(
                                              shape: BoxShape.circle),
                                          child: ClipOval(
                                            child: CustomImageNetwork(
                                              imageUrl:
                                                  data.company?.companyUrl ??
                                                      '',
                                            ),
                                          ),
                                        ),
                                        const SpaceWidget(
                                            direction: Direction.horizontal),
                                        Expanded(
                                          child: Row(
                                            children: [
                                              IText.set(
                                                text: data.company?.user
                                                        ?.firstName ??
                                                    '',
                                                textAlign: TextAlign.left,
                                                styleName: TextStyleName.bold,
                                                typeName:
                                                    TextTypeName.headline2,
                                                color: AppColors.textPrimary100,
                                              ),
                                              SpaceWidget(
                                                direction: Direction.horizontal,
                                                space: 8.w,
                                              ),
                                              if (!GlobalHelper.isEmpty(
                                                data.jobShift,
                                              ))
                                                Container(
                                                  padding:
                                                      const EdgeInsets.all(8),
                                                  decoration: BoxDecoration(
                                                    borderRadius:
                                                        BorderRadius.circular(
                                                            8.r),
                                                    color: AppColors.danger50,
                                                  ),
                                                  child: IText.set(
                                                    text:
                                                        data.jobShift?.shift ??
                                                            '',
                                                    textAlign: TextAlign.left,
                                                    styleName:
                                                        TextStyleName.bold,
                                                    typeName:
                                                        TextTypeName.caption2,
                                                    color: AppColors.danger100,
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
                                      text: state.jobs[index].jobTitle ?? '-',
                                      textAlign: TextAlign.left,
                                      styleName: TextStyleName.semiBold,
                                      typeName: TextTypeName.headline3,
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
                                        styleName: TextStyleName.regular,
                                        typeName: TextTypeName.caption1,
                                        color: AppColors.textPrimary100,
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
                                              boxShadow:
                                                  AppColors.defaultShadow,
                                              borderRadius:
                                                  BorderRadius.circular(
                                                8.r,
                                              ),
                                            ),
                                            margin: EdgeInsets.only(
                                                right: 8.w, bottom: 8.w),
                                            padding: const EdgeInsets.all(8),
                                            child: IText.set(
                                              text: data.jobsTag![i].name,
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
                                  if (!(data.hideSalary ?? true)) ...[
                                    SpaceWidget(
                                      space: 8.h,
                                    ),
                                    Row(
                                      children: [
                                        IText.set(
                                          text:
                                              data.currency?.currencyIcon ?? '',
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
                                              (data.salaryFrom ?? 0).toString(),
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
                                          text: (data.salaryTo ?? 0).toString(),
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
                                          DateTime.parse(data.createdAt!),
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
                            );
                          },
                        );
                },
              ),
            )
          ],
        ),
      ),
    );
  }
}
