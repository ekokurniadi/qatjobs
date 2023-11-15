import 'package:collection/collection.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:qatjobs/core/styles/color_name_style.dart';
import 'package:qatjobs/core/styles/resolution_style.dart';
import 'package:qatjobs/core/styles/text_name_style.dart';
import 'package:qatjobs/core/widget/dropdown_search_widget.dart';
import 'package:qatjobs/core/widget/loading_dialog_widget.dart';
import 'package:qatjobs/core/widget/section_title_widget.dart';
import 'package:qatjobs/core/widget/vertical_space_widget.dart';
import 'package:qatjobs/features/carrier_level/domain/entities/career_level_entity.codegen.dart';
import 'package:qatjobs/features/carrier_level/presentations/bloc/career_level_bloc.dart';
import 'package:qatjobs/features/functional_area/domain/entities/functional_area_entity.codegen.dart';
import 'package:qatjobs/features/functional_area/presentations/bloc/functional_area_bloc.dart';
import 'package:qatjobs/features/job/data/models/job_filter.codegen.dart';
import 'package:qatjobs/features/job/presentations/bloc/bloc/jobs_bloc.dart';
import 'package:qatjobs/features/job_category/domain/entities/job_category_entity.codegen.dart';
import 'package:qatjobs/features/job_category/presentations/bloc/job_category_bloc.dart';
import 'package:qatjobs/features/job_type/presentations/bloc/job_type_bloc.dart';
import 'package:qatjobs/features/jobs_skill/domain/entities/jobs_skill_entity.codegen.dart';
import 'package:qatjobs/features/jobs_skill/presentations/bloc/job_skill_bloc.dart';
import 'package:qatjobs/injector.dart';

class JobFilterPage extends StatefulWidget {
  const JobFilterPage({
    super.key,
    required this.jobsBloc,
  });
  final JobsBloc jobsBloc;

  @override
  State<JobFilterPage> createState() => _JobFilterPageState();
}

class _JobFilterPageState extends State<JobFilterPage> {
  final ValueNotifier<JobFilterModel> jobFilterModel = ValueNotifier(
    JobFilterModel(
      perPage: 999,
    ),
  );

  @override
  void initState() {
    if (widget.jobsBloc.state.isFilterActive) {
      jobFilterModel.value = widget.jobsBloc.state.jobFilter;
    }
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.bg300,
      appBar: AppBar(
        iconTheme: const IconThemeData(color: AppColors.textPrimary100),
        centerTitle: true,
        title: IText.set(
          text: 'Filter',
          textAlign: TextAlign.left,
          styleName: TextStyleName.bold,
          typeName: TextTypeName.headline2,
          color: AppColors.textPrimary,
        ),
        backgroundColor: AppColors.bg200,
        elevation: 0,
      ),
      body: Padding(
        padding: defaultPadding,
        child: SingleChildScrollView(
          child: Column(
            children: [
              const SectionTitleWidget(
                title: 'Category',
              ),
              const SpaceWidget(),
              BlocProvider(
                create: (context) => getIt<JobCategoryBloc>()
                  ..add(
                    const JobCategoryEvent.started(),
                  ),
                child: BlocConsumer<JobCategoryBloc, JobCategoryState>(
                  listener: (context, state) {
                    if (state.status == JobCategoryStatus.failure) {
                      LoadingDialog.showError(message: state.message);
                    }
                  },
                  builder: (context, state) {
                    return Container(
                      width: double.infinity,
                      decoration: BoxDecoration(
                        color: AppColors.bg200,
                        borderRadius: defaultRadius,
                      ),
                      child: DropdownSearchWidget<JobCategoryEntity>(
                        selectedItem: state.categories.firstWhereOrNull(
                          (element) =>
                              element.id == jobFilterModel.value.jobCategoryId,
                        ),
                        items: state.categories,
                        hintText: 'Select Job Category',
                        itemAsString: (val) => val.name,
                        onChanged: (cat) {
                          jobFilterModel.value.jobCategoryId = cat?.id;
                          setState(() {});
                        },
                      ),
                    );
                  },
                ),
              ),
              const SpaceWidget(),
              const SectionTitleWidget(
                title: 'Skill',
              ),
              const SpaceWidget(),
              BlocProvider(
                create: (context) => getIt<JobSkillBloc>()
                  ..add(
                    const JobSkillEvent.started(),
                  ),
                child: BlocConsumer<JobSkillBloc, JobSkillState>(
                  listener: (context, state) {
                    if (state.status == JobSkillStatus.failure) {
                      LoadingDialog.showError(message: state.message);
                    }
                  },
                  builder: (context, state) {
                    return Container(
                      width: double.infinity,
                      decoration: BoxDecoration(
                        color: AppColors.bg200,
                        borderRadius: defaultRadius,
                      ),
                      child: DropdownSearchWidget<JobsSkillEntity>(
                        selectedItem: state.skills.firstWhereOrNull(
                          (element) =>
                              element.id == jobFilterModel.value.skillId,
                        ),
                        items: state.skills,
                        hintText: 'Select Job Skill',
                        itemAsString: (val) => val.name,
                        onChanged: (skill) {
                          jobFilterModel.value.skillId = skill?.id;
                          setState(() {});
                        },
                      ),
                    );
                  },
                ),
              ),
              // const SpaceWidget(),
              // const SectionTitleWidget(
              //   title: 'Gender',
              // ),
              // const SpaceWidget(),
              // Container(
              //   width: double.infinity,
              //   decoration: BoxDecoration(
              //     color: AppColors.bg200,
              //     borderRadius: defaultRadius,
              //   ),
              //   child: DropdownSearchWidget<Map<String, dynamic>>(
              //     items: const [
              //       {
              //         'name': 'Both',
              //         'value': 2,
              //       },
              //       {
              //         'name': 'Male',
              //         'value': 1,
              //       },
              //       {
              //         'name': 'Female',
              //         'value': 0,
              //       },
              //     ],
              //     hintText: 'Select Gender',
              //     itemAsString: (val) => val['name'],
              //   ),
              // ),
              const SpaceWidget(),
              const SectionTitleWidget(
                title: 'Career Level',
              ),
              const SpaceWidget(),
              BlocProvider(
                create: (context) => getIt<CareerLevelBloc>()
                  ..add(
                    const CareerLevelEvent.started(),
                  ),
                child: BlocConsumer<CareerLevelBloc, CareerLevelState>(
                  listener: (context, state) {
                    if (state.status == CareerLevelStatus.failure) {
                      LoadingDialog.showError(message: state.message);
                    }
                  },
                  builder: (context, state) {
                    return Container(
                      width: double.infinity,
                      decoration: BoxDecoration(
                        color: AppColors.bg200,
                        borderRadius: defaultRadius,
                      ),
                      child: DropdownSearchWidget<CareerLevelEntity>(
                        selectedItem: state.careerLevels.firstWhereOrNull(
                          (element) =>
                              element.id == jobFilterModel.value.careerLevelId,
                        ),
                        items: state.careerLevels,
                        hintText: 'Select Career Level',
                        itemAsString: (val) => val.levelName,
                        onChanged: (career) {
                          jobFilterModel.value.careerLevelId = career?.id;
                          setState(() {});
                        },
                      ),
                    );
                  },
                ),
              ),
              const SpaceWidget(),
              const SectionTitleWidget(
                title: 'Functional Area',
              ),
              const SpaceWidget(),
              BlocProvider(
                create: (context) => getIt<FunctionalAreaBloc>()
                  ..add(
                    const FunctionalAreaEvent.started(),
                  ),
                child: BlocConsumer<FunctionalAreaBloc, FunctionalAreaState>(
                  listener: (context, state) {
                    if (state.status == FunctionalAreaStatus.failure) {
                      LoadingDialog.showError(message: state.message);
                    }
                  },
                  builder: (context, state) {
                    return Container(
                      width: double.infinity,
                      decoration: BoxDecoration(
                        color: AppColors.bg200,
                        borderRadius: defaultRadius,
                      ),
                      child: DropdownSearchWidget<FunctionalAreaEntity>(
                        selectedItem: state.functionalAreas.firstWhereOrNull(
                          (element) =>
                              element.id ==
                              jobFilterModel.value.functionalAreaId,
                        ),
                        items: state.functionalAreas,
                        hintText: 'Select Functional Area',
                        itemAsString: (val) => val.name,
                        onChanged: (func) {
                          jobFilterModel.value.functionalAreaId = func?.id;
                          setState(() {});
                        },
                      ),
                    );
                  },
                ),
              ),
              const SpaceWidget(),
              const SectionTitleWidget(
                title: 'Job Types',
              ),
              const SpaceWidget(),
              BlocProvider(
                create: (context) =>
                    getIt<JobTypeBloc>()..add(const JobTypeEvent.started()),
                child: BlocConsumer<JobTypeBloc, JobTypeState>(
                  listener: (context, state) {
                    if (state.status == JobTypeStatus.failure) {
                      LoadingDialog.showError(message: state.message);
                    }
                  },
                  builder: (context, state) {
                    return SizedBox(
                      width: double.infinity,
                      child: Wrap(
                        children: List.generate(
                          state.types.length,
                          (i) => InkWell(
                            onTap: () {
                              if (jobFilterModel.value.jobTypeId ==
                                  state.types[i].id) {
                                jobFilterModel.value.jobTypeId = null;
                              } else {
                                jobFilterModel.value.jobTypeId =
                                    state.types[i].id;
                              }
                              setState(() {});
                            },
                            child: Container(
                              decoration: BoxDecoration(
                                color: jobFilterModel.value.jobTypeId ==
                                        state.types[i].id
                                    ? AppColors.warning
                                    : AppColors.bg300,
                                boxShadow: AppColors.defaultShadow,
                                borderRadius: BorderRadius.circular(
                                  8.r,
                                ),
                              ),
                              margin: EdgeInsets.only(right: 8.w, bottom: 8.w),
                              padding: const EdgeInsets.all(8),
                              child: IText.set(
                                text: state.types[i].name,
                                textAlign: TextAlign.left,
                                styleName: TextStyleName.regular,
                                typeName: TextTypeName.caption2,
                                color: jobFilterModel.value.jobTypeId ==
                                        state.types[i].id
                                    ? AppColors.bg200
                                    : AppColors.textPrimary,
                              ),
                            ),
                          ),
                        ).toList(),
                      ),
                    );
                  },
                ),
              ),
              const SpaceWidget(),
              const SectionTitleWidget(
                title: 'Salary',
              ),
              const SpaceWidget(),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  IText.set(
                    text:
                        'From ${(jobFilterModel.value.salaryFrom ?? 0) / 1000}K',
                    textAlign: TextAlign.left,
                    styleName: TextStyleName.regular,
                    typeName: TextTypeName.caption2,
                    color: AppColors.textPrimary,
                  ),
                  IText.set(
                    text: 'To ${(jobFilterModel.value.salaryTo ?? 0) / 1000}K',
                    textAlign: TextAlign.left,
                    styleName: TextStyleName.regular,
                    typeName: TextTypeName.caption2,
                    color: AppColors.textPrimary,
                  )
                ],
              ),
              RangeSlider(
                labels: RangeLabels(
                  'From ${(jobFilterModel.value.salaryFrom ?? 0) / 1000}K',
                  'To ${(jobFilterModel.value.salaryTo ?? 0) / 1000}K',
                ),
                divisions: 1000,
                activeColor: AppColors.warning,
                inactiveColor: AppColors.neutral,
                min: 0,
                max: 150000,
                values: RangeValues(
                  (jobFilterModel.value.salaryFrom ?? 0).toDouble(),
                  (jobFilterModel.value.salaryTo ?? 0).toDouble(),
                ),
                onChanged: (val) {
                  jobFilterModel.value.salaryFrom = val.start.toInt();
                  jobFilterModel.value.salaryTo = val.end.toInt();
                  setState(() {});
                },
              ),
              const SpaceWidget(),
              const SectionTitleWidget(
                title: 'Experience',
              ),

              IText.set(
                text: '${jobFilterModel.value.experience ?? 0} Year',
                textAlign: TextAlign.left,
                styleName: TextStyleName.regular,
                typeName: TextTypeName.caption2,
                color: AppColors.textPrimary,
              ),
              Slider(
                label: '${jobFilterModel.value.experience ?? 0} Year',
                activeColor: AppColors.warning,
                inactiveColor: AppColors.neutral,
                value: (jobFilterModel.value.experience ?? 0).toDouble(),
                min: 0,
                max: 30,
                onChanged: (year) {
                  jobFilterModel.value.experience = year.toInt();
                  setState(() {});
                },
              )
            ],
          ),
        ),
      ),
      bottomNavigationBar: BlocListener(
        bloc: widget.jobsBloc,
        listener: (context, JobsState state) {
          if (state.status == JobStatus.success) {
            Navigator.pop(context);
          } else if (state.status == JobStatus.failure) {
            LoadingDialog.showError(message: state.message);
          }
        },
        child: ValueListenableBuilder(
            valueListenable: jobFilterModel,
            builder: (context, filter, _) {
              return Container(
                decoration: const BoxDecoration(
                  border: Border(
                    top: BorderSide(
                      color: AppColors.neutral,
                    ),
                  ),
                ),
                padding: defaultPadding,
                child: Row(
                  children: [
                    Expanded(
                      child: SizedBox(
                        height: 50.h,
                        child: ElevatedButton(
                          onPressed: !widget.jobsBloc.isJobFilterNotEmpty(filter)
                              ? null
                              : () {
                                  widget.jobsBloc.add(
                                    JobsEvent.getJobs(
                                      filter,
                                      widget.jobsBloc.isJobFilterNotEmpty(filter),
                                    ),
                                  );
                                },
                          child: const Text('Apply Filter'),
                        ),
                      ),
                    ),
                    if (widget.jobsBloc.isJobFilterNotEmpty(filter)) ...[
                      SizedBox(width: 16.w),
                      Expanded(
                        child: SizedBox(
                          height: 50.h,
                          child: ElevatedButton(
                            style: ElevatedButton.styleFrom(
                              backgroundColor: AppColors.danger100,
                            ),
                            onPressed: () {
                              setState(() {
                                jobFilterModel.value = JobFilterModel();
                              });
                              widget.jobsBloc.add(
                                JobsEvent.getJobs(
                                  JobFilterModel(),
                                  false,
                                ),
                              );
                            },
                            child: const Text('Reset Filter'),
                          ),
                        ),
                      ),
                    ],
                  ],
                ),
              );
            }),
      ),
    );
  }
}
