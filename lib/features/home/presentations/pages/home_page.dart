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
import 'package:qatjobs/core/widget/pull_to_refresh_widget.dart';
import 'package:qatjobs/core/widget/shimmer_box_widget.dart';
import 'package:qatjobs/core/widget/vertical_space_widget.dart';
import 'package:qatjobs/core/widget/widget_chip.dart';
import 'package:qatjobs/features/article/presentations/widgets/article_card_item.dart';
import 'package:qatjobs/features/company/data/models/company_model.codegen.dart';
import 'package:qatjobs/features/company/domain/usecases/get_company_usecase.dart';
import 'package:qatjobs/features/company/presentations/bloc/company_bloc.dart';
import 'package:qatjobs/features/company/presentations/pages/company_detail_page.dart';
import 'package:qatjobs/features/home/data/models/home_models.codegen.dart';
import 'package:qatjobs/features/home/presentations/bloc/home_bloc.dart';
import 'package:qatjobs/core/widget/section_title_widget.dart';
import 'package:qatjobs/features/job/data/models/job_filter.codegen.dart';
import 'package:qatjobs/features/job/data/models/job_model.codegen.dart';
import 'package:qatjobs/features/job/presentations/bloc/bloc/jobs_bloc.dart';
import 'package:qatjobs/features/job_category/data/models/job_category_model.codegen.dart';
import 'package:qatjobs/features/job_category/presentations/widgets/card_category.dart';
import 'package:qatjobs/features/layouts/presentations/cubit/bottom_nav_cubit.dart';
import 'package:qatjobs/features/plan/data/models/plan_model.codegen.dart';
import 'package:zoom_tap_animation/zoom_tap_animation.dart';

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  // final RefreshController controller = RefreshController(initialRefresh: false);
  late HomeBloc homeBloc;

  @override
  void initState() {
    homeBloc = context.read<HomeBloc>();
    homeBloc.add(
      const HomeEvent.getFrontData(),
    );
    context.read<CompanyBloc>().add(
          const CompanyEvent.started(
            CompanyRequestParams(
              page: 1,
              limit: 10,
            ),
            isReset: true,
          ),
        );
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      resizeToAvoidBottomInset: false,
      backgroundColor: AppColors.bg300,
      appBar: const CustomAppBar(
        title: 'Home',
      ),
      body: BlocConsumer<HomeBloc, HomeState>(
        listener: (context, state) {
          if (state.status == HomeStatus.failure) {
            LoadingDialog.showError(message: state.message);
          }
        },
        builder: (context, state) {
          return PullToRefreshWidget(
            onRefresh: () async {
              homeBloc.add(
                const HomeEvent.getFrontData(),
              );
              context.read<CompanyBloc>().add(
                    const CompanyEvent.started(
                      CompanyRequestParams(
                        page: 1,
                        limit: 10,
                      ),
                      isReset: true,
                    ),
                  );
            },
            child: Container(
              width: double.infinity,
              height: MediaQuery.sizeOf(context).height,
              padding: const EdgeInsets.all(16),
              child: SingleChildScrollView(
                physics: const AlwaysScrollableScrollPhysics(),
                primary: false,
                child: Column(
                  children: [
                    const SpaceWidget(),
                    const SectionTitleWidget(
                      title: 'Find Your Job',
                    ),
                    const SpaceWidget(),
                    _SectionCounterWidget(
                      state.data?.dataCounts,
                      isLoading: state.status == HomeStatus.loading,
                    ),
                    const SpaceWidget(),
                    SectionTitleWidget(
                      title: 'Popular Categories',
                      showMoreWidget: true,
                      onTap: () {
                        AutoRouter.of(context).push(const JobCategoryRoute());
                      },
                    ),
                    _SectionPopularCategory(
                      state.data?.jobCategories ?? {},
                      isLoading: state.status == HomeStatus.loading,
                    ),
                    const SpaceWidget(),
                    SectionTitleWidget(
                      title: 'Company',
                      showMoreWidget: true,
                      onTap: () {
                        AutoRouter.of(context).push(const CompanyRoute());
                      },
                    ),
                    BlocBuilder<CompanyBloc, CompanyState>(
                      builder: (context, state) {
                        return SizedBox(
                          width: double.infinity,
                          child: ListView.builder(
                            physics: const NeverScrollableScrollPhysics(),
                            scrollDirection: Axis.vertical,
                            shrinkWrap: true,
                            itemCount: state.status == CompanyStatus.loading
                                ? 3
                                : state.companies.length > 4
                                    ? 4
                                    : state.companies.length,
                            itemBuilder: (context, index) {
                              final data = state.status == CompanyStatus.loading
                                  ? CompanyModel()
                                  : state.companies[index];
                              return ZoomTapAnimation(
                                onTap: () {
                                  Navigator.push(
                                    context,
                                    MaterialPageRoute(
                                      builder: (context) {
                                        return CompanyDetailPage(
                                          company: data,
                                        );
                                      },
                                    ),
                                  );
                                },
                                child: Container(
                                  width: MediaQuery.sizeOf(context).width,
                                  padding: const EdgeInsets.all(16),
                                  margin: EdgeInsets.symmetric(
                                    horizontal: 1.w,
                                    vertical: 8.h,
                                  ),
                                  decoration: BoxDecoration(
                                    borderRadius: BorderRadius.circular(8.r),
                                    color: AppColors.bg200,
                                    boxShadow: const [
                                      BoxShadow(
                                        color: AppColors.neutral,
                                        spreadRadius: 0.1,
                                        blurRadius: 0.1,
                                      ),
                                      BoxShadow(
                                        color: AppColors.neutral,
                                        spreadRadius: 0.1,
                                        blurRadius: 0.1,
                                      )
                                    ],
                                  ),
                                  child: Row(
                                    children: [
                                      if (state.status ==
                                          CompanyStatus.loading) ...[
                                        ShimmerBoxWidget(
                                            width: 80.w, height: 80.w),
                                        SizedBox(width: 16.w),
                                        Column(
                                          crossAxisAlignment:
                                              CrossAxisAlignment.start,
                                          mainAxisAlignment:
                                              MainAxisAlignment.center,
                                          children: [
                                            ShimmerBoxWidget(
                                              width: 200.w,
                                              height: 20,
                                            ),
                                            const SpaceWidget(),
                                            SizedBox(
                                              width: MediaQuery.sizeOf(context)
                                                      .width *
                                                  0.60,
                                              child: Row(
                                                crossAxisAlignment:
                                                    CrossAxisAlignment.start,
                                                children: [
                                                  const Expanded(
                                                    child: ShimmerBoxWidget(
                                                      width: double.infinity,
                                                      height: 20,
                                                    ),
                                                  ),
                                                  SizedBox(width: 8.w),
                                                ],
                                              ),
                                            ),
                                            const SpaceWidget(),
                                            const ShimmerBoxWidget(
                                              width: 100,
                                              height: 20,
                                            ),
                                          ],
                                        )
                                      ] else ...[
                                        if (!GlobalHelper.isEmptyList(
                                            state.companies)) ...[
                                          SizedBox(
                                            width: 80.w,
                                            height: 80.w,
                                            child: ClipRRect(
                                              borderRadius: defaultRadius,
                                              child: CustomImageNetwork(
                                                width: 80.w,
                                                fit: BoxFit.cover,
                                                imageUrl: data.companyUrl ?? '',
                                                customErrorWidget:
                                                    SvgPicture.asset(
                                                  AssetsConstant
                                                      .svgAssetsPicture,
                                                ),
                                              ),
                                            ),
                                          ),
                                          SizedBox(width: 16.w),
                                          Column(
                                            crossAxisAlignment:
                                                CrossAxisAlignment.start,
                                            mainAxisAlignment:
                                                MainAxisAlignment.center,
                                            children: [
                                              IText.set(
                                                text: data.user?.fullName ?? '',
                                                styleName: TextStyleName.bold,
                                                typeName:
                                                    TextTypeName.headline3,
                                                color: AppColors.textPrimary,
                                              ),
                                              SizedBox(
                                                height: 8.h,
                                              ),
                                              WidgetChip(
                                                content:
                                                    '${data.jobs?.length ?? 0} Open Position',
                                              ),
                                            ],
                                          ),
                                        ],
                                      ],
                                    ],
                                  ),
                                ),
                              );
                            },
                          ),
                        );
                      },
                    ),
                    const SpaceWidget(),
                    SectionTitleWidget(
                      title: 'Latest Jobs',
                      showMoreWidget: true,
                      onTap: () {
                        context.read<BottomNavCubit>().setSelectedMenuIndex(2);
                      },
                    ),
                    const SpaceWidget(),
                    if (state.status == HomeStatus.complete &&
                        GlobalHelper.isEmptyList(state.data?.latestJobs)) ...[
                      Column(
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
                        ],
                      )
                    ] else ...[
                      _SectionLatestJobs(
                        state.data?.latestJobs ?? [],
                        isLoading: state.status == HomeStatus.loading,
                      ),
                    ],
                    const SpaceWidget(),
                    const SectionTitleWidget(
                      title: 'Latest Article',
                    ),
                    const SpaceWidget(),
                    SizedBox(
                      width: double.infinity,
                      child: ListView.builder(
                        physics: const NeverScrollableScrollPhysics(),
                        scrollDirection: Axis.vertical,
                        shrinkWrap: true,
                        itemCount:
                            GlobalHelper.isEmptyList(state.data?.recentBlog)
                                ? 3
                                : state.data?.recentBlog.length,
                        itemBuilder: (context, index) {
                          if (GlobalHelper.isEmptyList(
                                  state.data?.recentBlog) &&
                              state.status == HomeStatus.loading) {
                            return Container(
                              padding: defaultPadding,
                              margin: EdgeInsets.only(bottom: 16.h),
                              decoration: BoxDecoration(
                                borderRadius: BorderRadius.circular(8.r),
                                color: AppColors.bg200,
                                boxShadow: const [
                                  BoxShadow(
                                    color: AppColors.neutral,
                                    spreadRadius: 0.1,
                                    blurRadius: 0.1,
                                  ),
                                  BoxShadow(
                                    color: AppColors.neutral,
                                    spreadRadius: 0.1,
                                    blurRadius: 0.1,
                                  )
                                ],
                              ),
                              child: const Column(
                                children: [
                                  ShimmerBoxWidget(
                                    width: double.infinity,
                                    height: 200,
                                  ),
                                  SpaceWidget(),
                                  ShimmerBoxWidget(
                                    width: double.infinity,
                                    height: 20,
                                  ),
                                  SpaceWidget(),
                                  Row(
                                    mainAxisAlignment:
                                        MainAxisAlignment.spaceBetween,
                                    children: [
                                      Expanded(
                                        child: ShimmerBoxWidget(
                                          width: double.infinity,
                                          height: 20,
                                        ),
                                      ),
                                      SpaceWidget(
                                        direction: Direction.horizontal,
                                      ),
                                      Expanded(
                                        child: ShimmerBoxWidget(
                                          width: double.infinity,
                                          height: 20,
                                        ),
                                      ),
                                    ],
                                  )
                                ],
                              ),
                            );
                          } else if (state.status == HomeStatus.complete) {
                            return ArticleCardItem(
                              isLoading: false,
                              onTap: () {
                                AutoRouter.of(context).push(ArticleDetailRoute(
                                  articleModel: state.data?.recentBlog[index],
                                ));
                              },
                              articleModel: state.data?.recentBlog[index],
                            );
                          } else {
                            return const SizedBox();
                          }
                        },
                      ),
                    ),
                    if (state.data?.plansEnable ?? false) ...[
                      const SpaceWidget(),
                      const SectionTitleWidget(
                        title: 'Pricing Plan',
                      ),
                      _SectionPlan(state.data?.plans)
                    ]
                  ],
                ),
              ),
            ),
          );
        },
      ),
    );
  }
}

class _SectionPlan extends StatelessWidget {
  const _SectionPlan(
    this.plans,
  );
  final List<PlanModel>? plans;

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: MediaQuery.sizeOf(context).width,
      height: 235.h,
      child: ListView(
        scrollDirection: Axis.horizontal,
        shrinkWrap: true,
        children: List.generate(
          (plans ?? []).length,
          (index) {
            final data = plans?[index];
            return Container(
              width: MediaQuery.sizeOf(context).width / 2 - 18.w,
              // padding: const EdgeInsets.all(16),
              margin: EdgeInsets.symmetric(
                vertical: 8.h,
              ).copyWith(left: 8.w),
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(8.r),
                color: AppColors.bg200,
                boxShadow: const [
                  BoxShadow(
                    color: AppColors.neutral,
                    spreadRadius: 0.1,
                    blurRadius: 0.1,
                  ),
                  BoxShadow(
                    color: AppColors.neutral,
                    spreadRadius: 0.1,
                    blurRadius: 0.1,
                  )
                ],
              ),
              child: Stack(
                clipBehavior: Clip.antiAlias,
                children: [
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.center,
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      IText.set(
                        text: data?.name ?? '',
                        styleName: TextStyleName.bold,
                        typeName: TextTypeName.headline1,
                        color: AppColors.textPrimary,
                      ),
                      const SpaceWidget(),
                      Row(
                        crossAxisAlignment: CrossAxisAlignment.center,
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          IText.set(
                            text: (data?.amount ?? 0).toString(),
                            styleName: TextStyleName.bold,
                            typeName: TextTypeName.headline1,
                            color: AppColors.danger100,
                          ),
                          IText.set(
                            text: data?.salaryCurrency.currencyIcon ?? '',
                            styleName: TextStyleName.bold,
                            typeName: TextTypeName.headline1,
                            color: AppColors.danger100,
                          ),
                          IText.set(
                            text: '/monthly',
                            styleName: TextStyleName.regular,
                            typeName: TextTypeName.headline3,
                            color: AppColors.textPrimary100,
                          ),
                        ],
                      ),
                      const SpaceWidget(),
                      Row(
                        crossAxisAlignment: CrossAxisAlignment.center,
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          const Icon(
                            Icons.check,
                            color: AppColors.danger100,
                          ),
                          SizedBox(width: 2.w),
                          IText.set(
                            text: (data?.allowedJobs ?? 0).toString(),
                            styleName: TextStyleName.regular,
                            typeName: TextTypeName.headline3,
                            color: AppColors.textPrimary100,
                          ),
                          IText.set(
                            text: '\tjobs allowed',
                            styleName: TextStyleName.regular,
                            typeName: TextTypeName.headline3,
                            color: AppColors.textPrimary100,
                          ),
                        ],
                      ),
                      const SpaceWidget(),
                      ElevatedButton(
                        onPressed: () {},
                        child: const Text('Get Started'),
                      )
                    ],
                  ),
                ],
              ),
            );
          },
        ).toList(),
      ),
    );
  }
}

class _SectionLatestJobs extends StatelessWidget {
  const _SectionLatestJobs(
    this.jobs, {
    required this.isLoading,
  });
  final List<JobModel> jobs;
  final bool isLoading;

  @override
  Widget build(BuildContext context) {
    return ListView.builder(
      physics: const NeverScrollableScrollPhysics(),
      scrollDirection: Axis.vertical,
      shrinkWrap: true,
      itemCount: jobs.length,
      itemBuilder: (context, index) {
        return ZoomTapAnimation(
          onTap: () {
            AutoRouter.of(context).push(
              JobDetailRoute(
                jobModel: jobs[index],
              ),
            );
          },
          child: Container(
            width: MediaQuery.sizeOf(context).width,
            padding: const EdgeInsets.all(16),
            margin: EdgeInsets.symmetric(
              horizontal: 1.w,
              vertical: 8.h,
            ),
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(8.r),
              color: AppColors.bg200,
              boxShadow: const [
                BoxShadow(
                  color: AppColors.neutral,
                  spreadRadius: 0.1,
                  blurRadius: 0.1,
                ),
                BoxShadow(
                  color: AppColors.neutral,
                  spreadRadius: 0.1,
                  blurRadius: 0.1,
                )
              ],
            ),
            child: Row(
              children: [
                if (isLoading) ...[
                  ShimmerBoxWidget(width: 80.w, height: 80.w),
                  SizedBox(width: 16.w),
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      ShimmerBoxWidget(
                        width: 200.w,
                        height: 20,
                      ),
                      const SpaceWidget(),
                      SizedBox(
                        width: MediaQuery.sizeOf(context).width * 0.60,
                        child: Row(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            const Expanded(
                              child: ShimmerBoxWidget(
                                width: double.infinity,
                                height: 20,
                              ),
                            ),
                            SizedBox(width: 8.w),
                          ],
                        ),
                      ),
                      const SpaceWidget(),
                      const ShimmerBoxWidget(
                        width: 100,
                        height: 20,
                      ),
                    ],
                  )
                ] else ...[
                  if (!GlobalHelper.isEmptyList(jobs)) ...[
                    SizedBox(
                      width: 80.w,
                      height: 80.w,
                      child: ClipRRect(
                        borderRadius: defaultRadius,
                        child: CustomImageNetwork(
                          width: 80.w,
                          fit: BoxFit.cover,
                          imageUrl: jobs[index].company?.companyUrl ?? '',
                          customErrorWidget: SvgPicture.asset(
                            AssetsConstant.svgAssetsPicture,
                          ),
                        ),
                      ),
                    ),
                    SizedBox(width: 16.w),
                    Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        IText.set(
                          text: jobs[index].jobTitle ?? '',
                          styleName: TextStyleName.bold,
                          typeName: TextTypeName.headline3,
                          color: AppColors.textPrimary,
                        ),
                        SizedBox(
                          width: MediaQuery.sizeOf(context).width * 0.60,
                          child: Row(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Expanded(
                                child: IText.set(
                                  text:
                                      jobs[index].company?.user?.fullName ?? '',
                                  styleName: TextStyleName.regular,
                                  typeName: TextTypeName.headline4,
                                  color: AppColors.textPrimary100,
                                ),
                              ),
                              if (!GlobalHelper.isEmpty(
                                  jobs[index].jobShift?.shift)) ...[
                                SizedBox(width: 8.w),
                                Container(
                                  padding: const EdgeInsets.all(4),
                                  decoration: BoxDecoration(
                                    color: AppColors.danger50,
                                    borderRadius: BorderRadius.circular(
                                      4.r,
                                    ),
                                  ),
                                  child: IText.set(
                                    text: jobs[index].jobShift?.shift ?? '-',
                                    styleName: TextStyleName.regular,
                                    typeName: TextTypeName.caption1,
                                    color: AppColors.danger100,
                                  ),
                                )
                              ],
                            ],
                          ),
                        ),
                        if (!(jobs[index].hideSalary ?? true)) ...[
                          SpaceWidget(
                            space: 8.h,
                          ),
                          Row(
                            children: [
                              IText.set(
                                text: jobs[index].currency?.currencyIcon ?? '﷼',
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
                                text: (jobs[index].salaryFrom ?? 0).toString(),
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
                                text: (jobs[index].salaryTo ?? 0).toString(),
                                textAlign: TextAlign.left,
                                styleName: TextStyleName.regular,
                                typeName: TextTypeName.caption1,
                                color: AppColors.textPrimary,
                              )
                            ],
                          ),
                        ],
                      ],
                    ),
                  ],
                ],
              ],
            ),
          ),
        );
      },
    );
  }
}

class _SectionPopularCategory extends StatelessWidget {
  const _SectionPopularCategory(
    this.categories, {
    required this.isLoading,
  });

  final Map<String, JobCategoryModel> categories;
  final bool isLoading;

  @override
  Widget build(BuildContext context) {
    return isLoading
        ? SizedBox(
            height: 120.h,
            width: double.infinity,
            child: ListView.builder(
              padding: EdgeInsets.symmetric(
                vertical: 16.h,
              ),
              scrollDirection: Axis.horizontal,
              shrinkWrap: true,
              itemCount: 3,
              itemBuilder: (context, index) {
                return Container(
                  width: MediaQuery.sizeOf(context).width * 0.75,
                  padding: const EdgeInsets.all(16),
                  margin: const EdgeInsets.only(right: 16),
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(8.r),
                    color: AppColors.bg200,
                    boxShadow: const [
                      BoxShadow(
                        color: AppColors.neutral,
                        spreadRadius: 0.1,
                        blurRadius: 0.1,
                      ),
                      BoxShadow(
                        color: AppColors.neutral,
                        spreadRadius: 0.1,
                        blurRadius: 0.1,
                      )
                    ],
                  ),
                  height: 120.h,
                  child: Row(
                    children: [
                      Expanded(
                        child: ShimmerBoxWidget(
                          width: double.infinity,
                          height: 80.h,
                        ),
                      ),
                      SizedBox(width: 16.w),
                      Expanded(
                        flex: 3,
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            ShimmerBoxWidget(
                              width: 100.w,
                              height: 20.h,
                            ),
                            SizedBox(height: 8.h),
                            ShimmerBoxWidget(
                              width: 150.w,
                              height: 20.h,
                            )
                          ],
                        ),
                      )
                    ],
                  ),
                );
              },
            ),
          )
        : SizedBox(
            height: 120.h,
            width: double.infinity,
            child: ListView.builder(
              padding: EdgeInsets.symmetric(
                vertical: 16.h,
              ),
              scrollDirection: Axis.horizontal,
              shrinkWrap: true,
              itemCount: categories.entries.length,
              itemBuilder: (context, index) {
                return Padding(
                  padding: EdgeInsets.only(right: 16.w),
                  child: ZoomTapAnimation(
                    onTap: () {
                      if (!isLoading) {
                        context.read<JobsBloc>().add(
                              JobsEvent.getJobs(
                                JobFilterModel(
                                  jobCategoryId: categories.entries
                                      .elementAt(index)
                                      .value
                                      .id,
                                ),
                                true,
                              ),
                            );
                        context.read<BottomNavCubit>().setSelectedMenuIndex(2);
                      }
                    },
                    child: CardCategory(
                      categoryModel: categories.entries.elementAt(index).value,
                      isLoading: isLoading,
                    ),
                  ),
                );
              },
            ),
          );
  }
}

class _SectionCounterWidget extends StatelessWidget {
  const _SectionCounterWidget(
    this.dataCount, {
    required this.isLoading,
  });
  final DataCountsModel? dataCount;
  final bool isLoading;

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: double.infinity,
      height: 200.h,
      child: Row(
        children: [
          Expanded(
            child: Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                Flexible(
                  child: _DataCountWidget(
                    isLoading: isLoading,
                    boxColor: AppColors.success,
                    value: (dataCount?.jobs ?? 0).toString(),
                    title: 'Jobs',
                  ),
                ),
                const SpaceWidget(),
                Flexible(
                  child: _DataCountWidget(
                    isLoading: isLoading,
                    boxColor: AppColors.secondary,
                    value: (dataCount?.candidates ?? 0).toString(),
                    title: 'Candidate',
                  ),
                ),
              ],
            ),
          ),
          const SizedBox(width: 16),
          Expanded(
            child: Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                Flexible(
                  child: _DataCountWidget(
                    isLoading: isLoading,
                    boxColor: AppColors.warning50,
                    value: (dataCount?.companies ?? 0).toString(),
                    title: 'Companies',
                  ),
                ),
                const SpaceWidget(),
                Flexible(
                  child: _DataCountWidget(
                    isLoading: isLoading,
                    boxColor: AppColors.danger50,
                    value: (dataCount?.resumes ?? 0).toString(),
                    title: 'Resume',
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}

class _DataCountWidget extends StatelessWidget {
  const _DataCountWidget({
    this.boxColor = AppColors.success,
    required this.title,
    required this.value,
    required this.isLoading,
  });

  final Color boxColor;
  final String title;
  final String value;
  final bool isLoading;

  @override
  Widget build(BuildContext context) {
    return Container(
      width: double.infinity,
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(8.r),
        color: boxColor,
      ),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          if (isLoading) ...[
            ShimmerBoxWidget(
              width: 20.w,
              height: 20.w,
            ),
            SpaceWidget(
              space: 8.h,
            ),
            ShimmerBoxWidget(
              width: 50.w,
              height: 20.w,
            ),
          ] else ...[
            IText.set(
              text: value,
              styleName: TextStyleName.bold,
              typeName: TextTypeName.headline1,
              color: AppColors.textPrimary,
            ),
            IText.set(
              text: title,
              styleName: TextStyleName.regular,
              typeName: TextTypeName.headline2,
              color: AppColors.textPrimary,
            ),
          ],
        ],
      ),
    );
  }
}
