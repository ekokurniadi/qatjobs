import 'package:collection/collection.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:intl/intl.dart';
import 'package:intl_phone_field/intl_phone_field.dart';
import 'package:qatjobs/core/styles/color_name_style.dart';
import 'package:qatjobs/core/styles/resolution_style.dart';
import 'package:qatjobs/core/styles/text_name_style.dart';
import 'package:qatjobs/core/widget/custom_appbar_widget.dart';
import 'package:qatjobs/core/widget/custom_text_field.dart';
import 'package:qatjobs/core/widget/dropdown_search_widget.dart';
import 'package:qatjobs/core/widget/vertical_space_widget.dart';
import 'package:qatjobs/features/carrier_level/domain/entities/career_level_entity.codegen.dart';
import 'package:qatjobs/features/carrier_level/presentations/bloc/career_level_bloc.dart';
import 'package:qatjobs/features/jobs_skill/domain/entities/jobs_skill_entity.codegen.dart';
import 'package:qatjobs/features/jobs_skill/presentations/bloc/job_skill_bloc.dart';
import 'package:qatjobs/injector.dart';

class CandidateGeneralProfilePage extends StatefulWidget {
  const CandidateGeneralProfilePage({super.key});

  @override
  State<CandidateGeneralProfilePage> createState() =>
      _CandidateGeneralProfilePageState();
}

class _CandidateGeneralProfilePageState
    extends State<CandidateGeneralProfilePage> {
  final List<String> genderOption = ['Male', 'Female', 'Both'];
  final ValueNotifier<String> selectedGender = ValueNotifier('');
  final ValueNotifier<int> selectedCareer = ValueNotifier(0);
  final ValueNotifier<List<JobsSkillEntity>> selectedSKill = ValueNotifier([]);
  final TextEditingController firstNameController = TextEditingController();
  final TextEditingController lastNameController = TextEditingController();
  final TextEditingController emailController = TextEditingController();
  final TextEditingController fatherNameController = TextEditingController();
  final TextEditingController birthDateController = TextEditingController();
  final TextEditingController maritalStatusController = TextEditingController();
  final TextEditingController nationalityController = TextEditingController();
  final TextEditingController nationalIDCardController =
      TextEditingController();
  final TextEditingController phoneController = TextEditingController();
  final TextEditingController experiencesController = TextEditingController();
  final TextEditingController currentSalaryController = TextEditingController();
  final TextEditingController expectedSalaryController =
      TextEditingController();
  final ValueNotifier<int> available = ValueNotifier(0);
  final TextEditingController availableDateController = TextEditingController();
  final TextEditingController facebookController = TextEditingController();
  final TextEditingController twitterController = TextEditingController();
  final TextEditingController linkedinController = TextEditingController();
  final TextEditingController googlePlusController = TextEditingController();
  final TextEditingController pinterestController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      resizeToAvoidBottomInset: false,
      backgroundColor: AppColors.bg300,
      extendBody: true,
      appBar: const CustomAppBar(
        title: 'General Profile',
        showLeading: true,
      ),
      body: Container(
        width: double.infinity,
        height: MediaQuery.sizeOf(context).height,
        padding: EdgeInsets.fromLTRB(
          16,
          16,
          16,
          MediaQuery.of(context).viewInsets.bottom,
        ),
        decoration: BoxDecoration(
          color: AppColors.bg300,
          borderRadius: defaultRadius,
          boxShadow: AppColors.defaultShadow,
        ),
        child: SingleChildScrollView(
          child: Column(
            children: [
              CustomTextField(
                placeholder: 'First Name',
                label: 'First Name',
                isRequired: true,
                controller: firstNameController,
              ),
              CustomTextField(
                placeholder: 'Last Name',
                label: 'Last Name',
                isRequired: true,
                controller: lastNameController,
              ),
              CustomTextField(
                placeholder: 'Email',
                label: 'Email',
                isRequired: true,
                controller: emailController,
                textInputType: TextInputType.emailAddress,
              ),
              CustomTextField(
                placeholder: 'Father Name',
                label: 'Father Name',
                controller: fatherNameController,
              ),
              CustomTextField(
                placeholder: 'Birth Date',
                label: 'Birth Date',
                controller: birthDateController,
                isCalendarPicker: true,
                isReadOnly: true,
                onTap: () async {
                  final result = await showDatePicker(
                    context: context,
                    firstDate: DateTime.parse('1900-01-01'),
                    initialDate: DateTime.now(),
                    lastDate: DateTime.now(),
                  );
                  if (result != null) {
                    birthDateController.text =
                        DateFormat('yyyy-MM-dd').format(result);
                  }
                },
              ),
              Container(
                margin: EdgeInsets.only(bottom: 16.h),
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(8.r),
                  color: AppColors.bg200,
                ),
                child: DropdownSearchWidget<String>(
                  items: genderOption,
                  selectedItem: genderOption.firstWhereOrNull(
                    (element) => selectedGender.value == element,
                  ),
                  itemAsString: (val) {
                    selectedGender.value = val;
                    return val;
                  },
                  hintText: 'Gender',
                ),
              ),
              BlocProvider(
                create: (context) => getIt<JobSkillBloc>()
                  ..add(
                    const JobSkillEvent.started(),
                  ),
                child: BlocBuilder<JobSkillBloc, JobSkillState>(
                  builder: (context, state) {
                    return Container(
                      margin: EdgeInsets.only(bottom: 16.h),
                      decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(8.r),
                          color: AppColors.bg200),
                      child: DropdownSearchMultiSelectWidget<JobsSkillEntity>(
                        items: state.skills,
                        onChanged: (val) {
                          selectedSKill.value = val;
                        },
                        selectedItem: state.skills
                            .where(
                              (s) => selectedSKill.value.any(
                                (e) => e.id == s.id,
                              ),
                            )
                            .toList(),
                        itemAsString: (val) {
                          return val.name;
                        },
                        hintText: 'Skills',
                      ),
                    );
                  },
                ),
              ),
              CustomTextField(
                placeholder: 'Nationality',
                label: 'Nationality',
                controller: nationalityController,
              ),
              CustomTextField(
                placeholder: 'National ID Card',
                label: 'National ID Card',
                controller: nationalIDCardController,
              ),
              Container(
                width: double.infinity,
                padding: defaultPadding,
                margin: EdgeInsets.only(bottom: 16.h),
                decoration: BoxDecoration(
                  color: AppColors.bg200,
                  borderRadius: BorderRadius.circular(
                    8.r,
                  ),
                ),
                child: IntlPhoneField(
                  invalidNumberMessage: 'Invalid format',
                  autovalidateMode: AutovalidateMode.onUserInteraction,
                  controller: phoneController,
                  decoration: const InputDecoration(
                    border: InputBorder.none,
                    hintText: 'Phone',
                    focusedBorder: InputBorder.none,
                    enabledBorder: InputBorder.none,
                  ),
                  languageCode: "en",
                  initialCountryCode: 'QA',
                ),
              ),
              CustomTextField(
                placeholder: 'Experiences',
                label: 'Experiences',
                controller: experiencesController,
                textInputType: TextInputType.number,
              ),
              BlocProvider(
                create: (context) => getIt<CareerLevelBloc>()
                  ..add(
                    const CareerLevelEvent.started(),
                  ),
                child: BlocBuilder<CareerLevelBloc, CareerLevelState>(
                  builder: (context, state) {
                    return Container(
                      margin: EdgeInsets.only(bottom: 16.h),
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(8.r),
                        color: AppColors.bg200,
                      ),
                      child: DropdownSearchWidget<CareerLevelEntity>(
                        items: state.careerLevels,
                        selectedItem: state.careerLevels.firstWhereOrNull(
                            (element) => element.id == selectedCareer.value),
                        itemAsString: (val) {
                          return val.levelName;
                        },
                        hintText: 'Career Level',
                      ),
                    );
                  },
                ),
              ),
              Container(
                margin: EdgeInsets.only(bottom: 16.h),
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(8.r),
                  color: AppColors.bg200,
                ),
                child: DropdownSearchWidget(
                  items: [],
                  selectedItem: '',
                  itemAsString: (val) {
                    return val;
                  },
                  hintText: 'Industry',
                ),
              ),
              Container(
                margin: EdgeInsets.only(bottom: 16.h),
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(8.r),
                  color: AppColors.bg200,
                ),
                child: DropdownSearchWidget(
                  items: [],
                  selectedItem: '',
                  itemAsString: (val) {
                    return val;
                  },
                  hintText: 'Functional Area',
                ),
              ),
              CustomTextField(
                placeholder: 'Current Salary',
                label: 'Current Salary',
                controller: currentSalaryController,
                textInputType: TextInputType.number,
              ),
              CustomTextField(
                placeholder: 'Expected Salary',
                label: 'Expected Salary',
                controller: expectedSalaryController,
                textInputType: TextInputType.number,
              ),
              Container(
                margin: EdgeInsets.only(bottom: 16.h),
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(8.r),
                  color: AppColors.bg200,
                ),
                child: DropdownSearchWidget(
                  items: [],
                  selectedItem: '',
                  itemAsString: (val) {
                    return val;
                  },
                  hintText: 'Salary Currency',
                ),
              ),
              ValueListenableBuilder(
                valueListenable: available,
                builder: (context, availableStatus, _) {
                  return Container(
                    width: double.infinity,
                    padding: defaultPadding,
                    margin: EdgeInsets.only(bottom: 16.h),
                    decoration: BoxDecoration(
                      color: AppColors.bg200,
                      borderRadius: BorderRadius.circular(
                        8.r,
                      ),
                    ),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        IText.set(text: 'Immediate Available'),
                        RadioListTile(
                          contentPadding: EdgeInsets.zero,
                          title: IText.set(text: 'Immediate Available'),
                          value: 0,
                          groupValue: available.value,
                          onChanged: (v) {
                            available.value = v!;
                          },
                        ),
                        RadioListTile(
                          contentPadding: EdgeInsets.zero,
                          title: IText.set(text: 'Not Immediate Available'),
                          value: 1,
                          groupValue: available.value,
                          onChanged: (v) {
                            available.value = v!;
                          },
                        ),
                      ],
                    ),
                  );
                },
              ),
              ValueListenableBuilder(
                valueListenable: available,
                builder: (context, availableStatus, _) {
                  return availableStatus == 1
                      ? CustomTextField(
                          placeholder: 'Available at',
                          label: 'Available at',
                          controller: availableDateController,
                          isRequired: availableStatus == 1,
                          isCalendarPicker: true,
                          isReadOnly: true,
                          onTap: () async {
                            final result = await showDatePicker(
                              context: context,
                              initialDate: DateTime.now(),
                              firstDate: DateTime.now(),
                              lastDate:
                                  DateTime.now().add(const Duration(days: 730)),
                            );
                            if (result != null) {
                              availableDateController.text =
                                  DateFormat('yyyy-MM-dd').format(result);
                            }
                          },
                        )
                      : const SizedBox();
                },
              ),
              CustomTextField(
                placeholder: 'Facebook URL',
                label: 'Facebook URL',
                controller: facebookController,
              ),
              CustomTextField(
                placeholder: 'Twitter URL',
                label: 'Twitter URL',
                controller: twitterController,
              ),
              CustomTextField(
                placeholder: 'Linkedin URL',
                label: 'Linkedin URL',
                controller: linkedinController,
              ),
              CustomTextField(
                placeholder: 'Pinterest URL',
                label: 'Pinterest URL',
                controller: pinterestController,
              ),
              CustomTextField(
                placeholder: 'Google+ URL',
                label: 'Google+ URL',
                controller: googlePlusController,
              ),
              SpaceWidget(space: 84.h),
            ],
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
            onPressed: () {},
            child: const Text('Save'),
          ),
        ),
      ),
    );
  }
}
