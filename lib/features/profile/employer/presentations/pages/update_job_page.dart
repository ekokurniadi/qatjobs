import 'dart:developer';

import 'package:collection/collection.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:intl/intl.dart';
import 'package:qatjobs/core/constant/url_constant.dart';
import 'package:qatjobs/core/extensions/dio_response_extension.dart';
import 'package:qatjobs/core/helpers/date_helper.dart';
import 'package:qatjobs/core/helpers/dio_helper.dart';
import 'package:qatjobs/core/helpers/html_parse_helper.dart';
import 'package:qatjobs/core/styles/color_name_style.dart';
import 'package:qatjobs/core/styles/resolution_style.dart';
import 'package:qatjobs/core/styles/text_name_style.dart';
import 'package:qatjobs/core/widget/custom_appbar_widget.dart';
import 'package:qatjobs/core/widget/custom_text_field.dart';
import 'package:qatjobs/core/widget/dropdown_search_widget.dart';
import 'package:qatjobs/core/widget/loading_dialog_widget.dart';
import 'package:qatjobs/core/widget/vertical_space_widget.dart';
import 'package:qatjobs/features/carrier_level/presentations/bloc/career_level_bloc.dart';
import 'package:qatjobs/features/currency/presentations/bloc/currency_bloc.dart';
import 'package:qatjobs/features/degree_level/domain/entities/degree_level_entity.codegen.dart';
import 'package:qatjobs/features/degree_level/presentations/bloc/degree_level_bloc.dart';
import 'package:qatjobs/features/functional_area/domain/entities/functional_area_entity.codegen.dart';
import 'package:qatjobs/features/functional_area/presentations/bloc/functional_area_bloc.dart';
import 'package:qatjobs/features/job/data/models/job_model.codegen.dart';
import 'package:qatjobs/features/job_category/presentations/bloc/job_category_bloc.dart';
import 'package:qatjobs/features/job_shift/data/models/job_shift_model.codegen.dart';
import 'package:qatjobs/features/job_tags/data/models/job_tags_model.codegen.dart';
import 'package:qatjobs/features/job_type/presentations/bloc/job_type_bloc.dart';
import 'package:qatjobs/features/jobs_skill/data/models/jobs_skill_model.codegen.dart';
import 'package:qatjobs/features/jobs_skill/domain/entities/jobs_skill_entity.codegen.dart';
import 'package:qatjobs/features/jobs_skill/presentations/bloc/job_skill_bloc.dart';
import 'package:qatjobs/features/profile/employer/data/models/job_request_params.codegen.dart';
import 'package:qatjobs/features/profile/employer/presentations/cubit/employer_cubit.dart';
import 'package:qatjobs/features/salary_period/data/models/salary_period_model.codegen.dart';
import 'package:qatjobs/injector.dart';

class UpdateJobPage extends StatefulWidget {
  const UpdateJobPage({
    super.key,
    required this.job,
  });
  final JobModel job;

  @override
  State<UpdateJobPage> createState() => _UpdateJobPageState();
}

class _UpdateJobPageState extends State<UpdateJobPage> {
  List<JobShiftModel> shifts = [];
  List<SalaryPeriod> salaryPeriod = [];
  List<JobsTag> jobTags = [];

  final TextEditingController titleController = TextEditingController();
  final TextEditingController descriptionController = TextEditingController();
  final TextEditingController expiredDateController = TextEditingController();
  final TextEditingController salaryFromController = TextEditingController();
  final TextEditingController salaryToController = TextEditingController();
  final TextEditingController positionController = TextEditingController();
  final TextEditingController experiencesController = TextEditingController();

  final ValueNotifier<int> selectedJobTypeId = ValueNotifier(0);
  final ValueNotifier<int> selectedJobCategoryId = ValueNotifier(0);
  final ValueNotifier<int> selectedCurrencyId = ValueNotifier(0);
  final ValueNotifier<int> selectedSalaryPeriodId = ValueNotifier(0);
  final ValueNotifier<int> selectedCareerLevelId = ValueNotifier(0);
  final ValueNotifier<int> selectedJobShiftId = ValueNotifier(0);
  final ValueNotifier<int> selectedDegreeLevelId = ValueNotifier(0);
  final ValueNotifier<int> selectedFunctionalAreaId = ValueNotifier(0);
  final ValueNotifier<bool> isHideSalary = ValueNotifier(false);
  final ValueNotifier<bool> isFreelance = ValueNotifier(false);
  final GlobalKey<FormState> _formKey = GlobalKey();

  List<JobsSkillEntity> selectedSkill = [];
  List<JobsTag> selectedJobTags = [];

  final ScrollController _scrollController = ScrollController();

  Future<void> getJobShift() async {
    try {
      final result = await DioHelper.dio!.get(URLConstant.jobShift);

      if (result.isOk) {
        shifts = List.from(result.data.map((e) => JobShiftModel.fromJson(e)));
      }
      setState(() {});
    } catch (e) {
      log(e.toString());
    }
  }

  Future<void> getSalaryPeriod() async {
    try {
      final result = await DioHelper.dio!.get(URLConstant.jobSalaryPeriod);

      if (result.isOk) {
        salaryPeriod =
            List.from(result.data.map((e) => SalaryPeriod.fromJson(e)));
      }
      setState(() {});
    } catch (e) {
      log(e.toString());
    }
  }

  Future<void> getJobTags() async {
    try {
      final result = await DioHelper.dio!.get(URLConstant.jobTags);

      if (result.isOk) {
        jobTags = List.from(result.data.map((e) => JobsTag.fromJson(e)));
      }
      setState(() {});
    } catch (e) {
      log(e.toString());
    }
  }

  @override
  void initState() {
    getJobShift();
    getSalaryPeriod();
    getJobTags();

    titleController.text = widget.job.jobTitle ?? '';
    selectedJobTypeId.value = widget.job.jobTypeId ?? 0;
    selectedJobCategoryId.value = widget.job.jobCategoryId ?? 0;
    selectedSkill = List.from(
      (widget.job.jobsSkill ?? []).map(
        (e) => e.toDomain(),
      ),
    );
    descriptionController.text = HtmlParseHelper.stripHtmlIfNeeded(
      widget.job.description ?? '',
    );
    expiredDateController.text = DateHelper.getOnlyDate(
      widget.job.jobExpiryDate,
    );
    salaryFromController.text = (widget.job.salaryFrom ?? 0).toString();
    salaryToController.text = (widget.job.salaryTo ?? 0).toString();
    selectedCurrencyId.value = widget.job.currencyId ?? 0;
    selectedSalaryPeriodId.value = widget.job.salaryPeriodId ?? 0;
    selectedCareerLevelId.value = widget.job.careerLevelId ?? 0;
    selectedJobShiftId.value = widget.job.jobShiftId ?? 0;
    selectedDegreeLevelId.value = widget.job.degreeLevelId ?? 0;
    selectedFunctionalAreaId.value = widget.job.functionalAreaId ?? 0;
    positionController.text = (widget.job.position ?? 0).toString();
    experiencesController.text = (widget.job.experience ?? 0).toString();

    isHideSalary.value = widget.job.hideSalary ?? false;
    isFreelance.value = widget.job.isFreelance ?? false;
    selectedJobTags = widget.job.jobsTag ?? [];

    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.bg300,
      appBar: const CustomAppBar(
        title: 'Update Job',
        showLeading: true,
      ),
      body: BlocListener<EmployerCubit, EmployerState>(
        listener: (context, state) {
          if (state.status == EmployerStatus.updateJob) {
            LoadingDialog.dismiss();
            LoadingDialog.showSuccess(message: state.message);
            Future.delayed(const Duration(seconds: 2), () {
              Navigator.pop(context);
              context.read<EmployerCubit>().getJobs(
                    JobRequestParams(),
                    isReset: true,
                  );
            });
          } else if (state.status == EmployerStatus.loading) {
            LoadingDialog.show(message: 'Loading ...');
          } else if (state.status == EmployerStatus.failure) {
            LoadingDialog.dismiss();
            LoadingDialog.showError(message: state.message);
          } else {
            LoadingDialog.dismiss();
          }
        },
        child: SingleChildScrollView(
          child: Padding(
            padding: defaultPadding,
            child: Form(
              key: _formKey,
              child: Column(
                children: [
                  CustomTextField(
                    placeholder: 'Job Title',
                    label: 'Job Title',
                    isAlwaysShowLabel: true,
                    isRequired: true,
                    controller: titleController,
                  ),
                  Container(
                    decoration: BoxDecoration(
                      color: AppColors.bg200,
                      borderRadius: defaultRadius,
                      boxShadow: AppColors.defaultShadow,
                    ),
                    child: BlocProvider(
                      create: (context) => getIt<JobTypeBloc>()
                        ..add(
                          const JobTypeEvent.started(),
                        ),
                      child: BlocBuilder<JobTypeBloc, JobTypeState>(
                        builder: (context, state) {
                          return DropdownSearchWidget(
                            selectedItem: state.types.firstWhereOrNull(
                              (element) =>
                                  element.id == selectedJobTypeId.value,
                            ),
                            onChanged: (type) {
                              selectedJobTypeId.value = type?.id ?? 0;
                            },
                            items: state.types,
                            hintText: 'Job Type',
                            label: 'Job Type',
                            alwaysShowLabel: true,
                            itemAsString: (p0) {
                              return p0.name;
                            },
                            isRequired: true,
                          );
                        },
                      ),
                    ),
                  ),
                  const SpaceWidget(),
                  Container(
                    decoration: BoxDecoration(
                      color: AppColors.bg200,
                      borderRadius: defaultRadius,
                      boxShadow: AppColors.defaultShadow,
                    ),
                    child: BlocProvider(
                      create: (context) => getIt<JobCategoryBloc>()
                        ..add(
                          const JobCategoryEvent.started(),
                        ),
                      child: BlocBuilder<JobCategoryBloc, JobCategoryState>(
                        builder: (context, state) {
                          return DropdownSearchWidget(
                            selectedItem: state.categories.firstWhereOrNull(
                              (element) =>
                                  element.id == selectedJobCategoryId.value,
                            ),
                            onChanged: (type) {
                              selectedJobCategoryId.value = type?.id ?? 0;
                            },
                            items: state.categories,
                            hintText: 'Job Category',
                            label: 'Job Category',
                            alwaysShowLabel: true,
                            itemAsString: (p0) {
                              return p0.name;
                            },
                            isRequired: true,
                          );
                        },
                      ),
                    ),
                  ),
                  const SpaceWidget(),
                  Container(
                    decoration: BoxDecoration(
                      color: AppColors.bg200,
                      borderRadius: defaultRadius,
                      boxShadow: AppColors.defaultShadow,
                    ),
                    child: BlocProvider(
                      create: (context) => getIt<JobSkillBloc>()
                        ..add(
                          const JobSkillEvent.started(),
                        ),
                      child: BlocBuilder<JobSkillBloc, JobSkillState>(
                        builder: (context, state) {
                          return DropdownSearchMultiSelectWidget<
                              JobsSkillEntity>(
                            isRequired: true,
                            selectedItem: selectedSkill,
                            onChanged: (type) {
                              selectedSkill = type;
                            },
                            items: state.skills,
                            hintText: 'Job Skill',
                            label: 'Job Skill',
                            alwaysShowLabel: true,
                            itemAsString: (p0) {
                              return p0.name;
                            },
                          );
                        },
                      ),
                    ),
                  ),
                  const SpaceWidget(),
                  Scrollbar(
                    controller: _scrollController,
                    child: CustomTextField(
                      scrollController: _scrollController,
                      maxLines: 8,
                      textInputType: TextInputType.multiline,
                      placeholder: 'Description',
                      label: 'Description',
                      isAlwaysShowLabel: true,
                      isRequired: true,
                      controller: descriptionController,
                    ),
                  ),
                  CustomTextField(
                    placeholder: 'Job Expired Date',
                    label: 'Job Expired Date',
                    isAlwaysShowLabel: true,
                    isRequired: true,
                    isCalendarPicker: true,
                    controller: expiredDateController,
                    isReadOnly: true,
                    onTap: () async {
                      final result = await showDatePicker(
                        context: context,
                        firstDate: DateTime.now(),
                        initialDate: DateTime.now(),
                        lastDate: DateTime.now().add(const Duration(days: 365)),
                      );
                      if (result != null) {
                        expiredDateController.text =
                            DateFormat('yyyy-MM-dd').format(result);
                      }
                    },
                  ),
                  SizedBox(
                    width: double.infinity,
                    child: Row(
                      children: [
                        Expanded(
                          child: CustomTextField(
                            maxLines: 8,
                            textInputType: TextInputType.number,
                            placeholder: 'Salary From',
                            label: 'Salary From',
                            isAlwaysShowLabel: true,
                            isRequired: true,
                            controller: salaryFromController,
                          ),
                        ),
                        const SpaceWidget(direction: Direction.horizontal),
                        Expanded(
                          child: CustomTextField(
                            maxLines: 8,
                            textInputType: TextInputType.number,
                            placeholder: 'Salary To',
                            label: 'Salary To',
                            isAlwaysShowLabel: true,
                            isRequired: true,
                            controller: salaryToController,
                          ),
                        ),
                      ],
                    ),
                  ),
                  Container(
                    decoration: BoxDecoration(
                      color: AppColors.bg200,
                      borderRadius: defaultRadius,
                      boxShadow: AppColors.defaultShadow,
                    ),
                    child: BlocProvider(
                      create: (context) => getIt<CurrencyBloc>()
                        ..add(
                          const CurrencyEvent.started(),
                        ),
                      child: BlocBuilder<CurrencyBloc, CurrencyState>(
                        builder: (context, state) {
                          return DropdownSearchWidget(
                            showSearchBox: false,
                            selectedItem: state.currency.firstWhereOrNull(
                              (element) =>
                                  element.id == selectedCurrencyId.value,
                            ),
                            onChanged: (type) {
                              selectedCurrencyId.value = type?.id ?? 0;
                            },
                            items: state.currency,
                            hintText: 'Currency',
                            label: 'Currency',
                            alwaysShowLabel: true,
                            itemAsString: (p0) {
                              return p0.currencyName;
                            },
                            isRequired: true,
                          );
                        },
                      ),
                    ),
                  ),
                  const SpaceWidget(),
                  Container(
                    decoration: BoxDecoration(
                      color: AppColors.bg200,
                      borderRadius: defaultRadius,
                      boxShadow: AppColors.defaultShadow,
                    ),
                    child: DropdownSearchWidget(
                      selectedItem: salaryPeriod.firstWhereOrNull(
                        (element) => element.id == selectedSalaryPeriodId.value,
                      ),
                      onChanged: (type) {
                        selectedSalaryPeriodId.value = type?.id ?? 0;
                      },
                      items: salaryPeriod,
                      hintText: 'Salary Period',
                      label: 'Salary Period',
                      alwaysShowLabel: true,
                      itemAsString: (p0) {
                        return p0.period;
                      },
                      isRequired: true,
                    ),
                  ),
                  const SpaceWidget(),
                  Container(
                    decoration: BoxDecoration(
                      color: AppColors.bg200,
                      borderRadius: defaultRadius,
                      boxShadow: AppColors.defaultShadow,
                    ),
                    child: BlocProvider(
                      create: (context) => getIt<CareerLevelBloc>()
                        ..add(
                          const CareerLevelEvent.started(),
                        ),
                      child: BlocBuilder<CareerLevelBloc, CareerLevelState>(
                        builder: (context, state) {
                          return DropdownSearchWidget(
                            selectedItem: state.careerLevels.firstWhereOrNull(
                              (element) =>
                                  element.id == selectedCareerLevelId.value,
                            ),
                            onChanged: (type) {
                              selectedCareerLevelId.value = type?.id ?? 0;
                            },
                            items: state.careerLevels,
                            hintText: 'Career Level',
                            label: 'Career Level',
                            alwaysShowLabel: true,
                            itemAsString: (p0) {
                              return p0.levelName;
                            },
                          );
                        },
                      ),
                    ),
                  ),
                  const SpaceWidget(),
                  Container(
                    decoration: BoxDecoration(
                      color: AppColors.bg200,
                      borderRadius: defaultRadius,
                      boxShadow: AppColors.defaultShadow,
                    ),
                    child: DropdownSearchWidget(
                      selectedItem: shifts.firstWhereOrNull(
                        (element) => element.id == selectedJobShiftId.value,
                      ),
                      onChanged: (type) {
                        selectedJobShiftId.value = type?.id ?? 0;
                      },
                      items: shifts,
                      hintText: 'Job Shift',
                      label: 'Job Shift',
                      alwaysShowLabel: true,
                      itemAsString: (p0) {
                        return p0.shift;
                      },
                    ),
                  ),
                  const SpaceWidget(),
                  Container(
                    decoration: BoxDecoration(
                      color: AppColors.bg200,
                      borderRadius: defaultRadius,
                      boxShadow: AppColors.defaultShadow,
                    ),
                    child: DropdownSearchMultiSelectWidget<JobsTag>(
                      selectedItem: selectedJobTags,
                      onChanged: (type) {
                        selectedJobTags = type;
                      },
                      items: jobTags,
                      hintText: 'Job Tags',
                      label: 'Job Tags',
                      alwaysShowLabel: true,
                      itemAsString: (p0) {
                        return p0.name;
                      },
                    ),
                  ),
                  const SpaceWidget(),
                  Container(
                    decoration: BoxDecoration(
                      color: AppColors.bg200,
                      borderRadius: defaultRadius,
                      boxShadow: AppColors.defaultShadow,
                    ),
                    child: BlocProvider(
                      create: (context) => getIt<DegreeLevelBloc>()
                        ..add(
                          const DegreeLevelEvent.started(),
                        ),
                      child: BlocBuilder<DegreeLevelBloc, DegreeLevelState>(
                        builder: (context, state) {
                          return DropdownSearchWidget<DegreeLevelEntity>(
                            selectedItem: state.degreeLevels.firstWhereOrNull(
                              (element) =>
                                  element.id == selectedDegreeLevelId.value,
                            ),
                            onChanged: (type) {
                              selectedDegreeLevelId.value = type?.id ?? 0;
                            },
                            items: state.degreeLevels,
                            hintText: 'Degree Level',
                            label: 'Degree Level',
                            alwaysShowLabel: true,
                            itemAsString: (p0) {
                              return p0.name;
                            },
                          );
                        },
                      ),
                    ),
                  ),
                  const SpaceWidget(),
                  Container(
                    decoration: BoxDecoration(
                      color: AppColors.bg200,
                      borderRadius: defaultRadius,
                      boxShadow: AppColors.defaultShadow,
                    ),
                    child: BlocProvider(
                      create: (context) => getIt<FunctionalAreaBloc>()
                        ..add(
                          const FunctionalAreaEvent.started(),
                        ),
                      child:
                          BlocBuilder<FunctionalAreaBloc, FunctionalAreaState>(
                        builder: (context, state) {
                          return DropdownSearchWidget<FunctionalAreaEntity>(
                            isRequired: true,
                            selectedItem:
                                state.functionalAreas.firstWhereOrNull(
                              (element) =>
                                  element.id == selectedFunctionalAreaId.value,
                            ),
                            onChanged: (type) {
                              selectedFunctionalAreaId.value = type?.id ?? 0;
                            },
                            items: state.functionalAreas,
                            hintText: 'Functional Area',
                            label: 'Functional Area',
                            alwaysShowLabel: true,
                            itemAsString: (p0) {
                              return p0.name;
                            },
                          );
                        },
                      ),
                    ),
                  ),
                  const SpaceWidget(),
                  CustomTextField(
                    textInputType: TextInputType.number,
                    placeholder: 'Position',
                    label: 'Position',
                    isAlwaysShowLabel: true,
                    isRequired: true,
                    controller: positionController,
                  ),
                  CustomTextField(
                    textInputType: TextInputType.number,
                    placeholder: 'Job Experiences',
                    label: 'Job Experiences',
                    isAlwaysShowLabel: true,
                    isRequired: true,
                    controller: experiencesController,
                  ),
                  ValueListenableBuilder(
                    valueListenable: isHideSalary,
                    builder: (context, hide, _) {
                      return SwitchListTile(
                        activeColor: AppColors.warning,
                        title: IText.set(
                          text: 'Hide Salary',
                          typeName: TextTypeName.headline3,
                          styleName: TextStyleName.regular,
                          color: AppColors.textPrimary100,
                        ),
                        value: hide,
                        onChanged: (val) {
                          isHideSalary.value = val;
                        },
                      );
                    },
                  ),
                  ValueListenableBuilder(
                    valueListenable: isFreelance,
                    builder: (context, freelance, _) {
                      return SwitchListTile(
                        activeColor: AppColors.warning,
                        title: IText.set(
                          text: 'Is Freelance',
                          typeName: TextTypeName.headline3,
                          styleName: TextStyleName.regular,
                          color: AppColors.textPrimary100,
                        ),
                        value: freelance,
                        onChanged: (val) {
                          isFreelance.value = val;
                        },
                      );
                    },
                  )
                ],
              ),
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
            onPressed: () {
              if (!_formKey.currentState!.validate()) return;

              context.read<EmployerCubit>().updateJobUseCase(
                    JobModel(
                      id: widget.job.id,
                      jobTitle: titleController.text,
                      currencyId: selectedCurrencyId.value,
                      salaryPeriodId: selectedSalaryPeriodId.value,
                      jobTypeId: selectedJobTypeId.value,
                      functionalAreaId: selectedFunctionalAreaId.value,
                      position: int.tryParse(positionController.text) ?? 1,
                      experience: int.tryParse(experiencesController.text) ?? 1,
                      jobCategoryId: selectedJobCategoryId.value,
                      salaryFrom: int.tryParse(salaryFromController.text),
                      salaryTo: int.tryParse(salaryToController.text),
                      jobExpiryDate: expiredDateController.text,
                      jobShiftId: selectedJobShiftId.value,
                      description: descriptionController.text,
                      hideSalary: isHideSalary.value,
                      isFreelance: isFreelance.value,
                    ),
                  );
            },
            child: const Text('Save'),
          ),
        ),
      ),
    );
  }
}
