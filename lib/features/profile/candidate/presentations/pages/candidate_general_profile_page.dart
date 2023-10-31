import 'dart:io';

import 'package:collection/collection.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:image_picker/image_picker.dart';
import 'package:intl/intl.dart';
import 'package:intl_phone_field/intl_phone_field.dart';
import 'package:qatjobs/core/helpers/global_helper.dart';
import 'package:qatjobs/core/helpers/image_picker_helper.dart';
import 'package:qatjobs/core/styles/color_name_style.dart';
import 'package:qatjobs/core/styles/resolution_style.dart';
import 'package:qatjobs/core/styles/text_name_style.dart';
import 'package:qatjobs/core/widget/custom_appbar_widget.dart';
import 'package:qatjobs/core/widget/custom_cached_image_network.dart';
import 'package:qatjobs/core/widget/custom_text_field.dart';
import 'package:qatjobs/core/widget/dropdown_search_widget.dart';
import 'package:qatjobs/core/widget/loading_dialog_widget.dart';
import 'package:qatjobs/core/widget/vertical_space_widget.dart';
import 'package:qatjobs/features/carrier_level/domain/entities/career_level_entity.codegen.dart';
import 'package:qatjobs/features/carrier_level/presentations/bloc/career_level_bloc.dart';
import 'package:qatjobs/features/currency/domain/entities/currency_entity.codegen.dart';
import 'package:qatjobs/features/currency/presentations/bloc/currency_bloc.dart';
import 'package:qatjobs/features/functional_area/domain/entities/functional_area_entity.codegen.dart';
import 'package:qatjobs/features/functional_area/presentations/bloc/functional_area_bloc.dart';
import 'package:qatjobs/features/jobs_skill/domain/entities/jobs_skill_entity.codegen.dart';
import 'package:qatjobs/features/jobs_skill/presentations/bloc/job_skill_bloc.dart';
import 'package:qatjobs/features/profile/candidate/domain/usecases/candidate_update_general_profile_usecase.dart';
import 'package:qatjobs/features/profile/candidate/presentations/bloc/profile_candidate_bloc.dart';
import 'package:qatjobs/injector.dart';
import 'package:zoom_tap_animation/zoom_tap_animation.dart';

class CandidateGeneralProfilePage extends StatefulWidget {
  const CandidateGeneralProfilePage({super.key});

  @override
  State<CandidateGeneralProfilePage> createState() =>
      _CandidateGeneralProfilePageState();
}

class _CandidateGeneralProfilePageState
    extends State<CandidateGeneralProfilePage> {
  final List<String> genderOption = ['Male', 'Female', 'Both'];
  final ValueNotifier<int> selectedGender = ValueNotifier(0);
  final ValueNotifier<int> selectedCareer = ValueNotifier(0);
  final ValueNotifier<int> selectedFunctionalArea = ValueNotifier(0);
  final ValueNotifier<int> selectedCurrency = ValueNotifier(0);
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
  final GlobalKey<FormState> _formKey = GlobalKey();
  final ValueNotifier<File?> imageProfile = ValueNotifier(null);

  @override
  void initState() {
    context.read<ProfileCandidateBloc>().add(
          const ProfileCandidateEvent.getGeneralProfile(),
        );
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return BlocListener<ProfileCandidateBloc, ProfileCandidateState>(
      listener: (context, profileState) {
        if (profileState.status == ProfileCandidateStatus.loading) {
          LoadingDialog.show(message: 'Loading ...');
        } else if (profileState.status ==
            ProfileCandidateStatus.getGeneralProfile) {
          LoadingDialog.dismiss();
          firstNameController.text =
              profileState.generalProfile.user?.firstName ?? '';
          lastNameController.text =
              profileState.generalProfile.user?.lastName ?? '';
          emailController.text = profileState.generalProfile.user?.email ?? '';
          fatherNameController.text =
              profileState.generalProfile.fatherName ?? '';
          birthDateController.text =
              profileState.generalProfile.user?.dob ?? '';
          selectedGender.value = profileState.generalProfile.user?.gender ?? 0;
          nationalityController.text =
              profileState.generalProfile.nationality ?? '';
          selectedSKill.value = profileState.generalProfile.candidateSkill;
          birthDateController.text =
              profileState.generalProfile.user?.dob ?? '';

          birthDateController.text =
              !GlobalHelper.isEmpty(profileState.generalProfile.user?.dob)
                  ? DateFormat('yyyy-MM-dd').format(
                      DateTime.parse(profileState.generalProfile.user!.dob!),
                    )
                  : '';
          phoneController.text = profileState.generalProfile.user?.phone ?? '';
          available.value =
              profileState.generalProfile.immediateAvailable! ? 1 : 0;
          availableDateController.text =
              !GlobalHelper.isEmpty(profileState.generalProfile.availableAt)
                  ? DateFormat('yyyy-MM-dd').format(
                      DateTime.parse(profileState.generalProfile.availableAt!),
                    )
                  : '';
          nationalityController.text =
              profileState.generalProfile.nationality ?? '';
          nationalIDCardController.text =
              profileState.generalProfile.nationalIdCard ?? '';
          experiencesController.text =
              (profileState.generalProfile.experience ?? 0).toString();
          selectedCareer.value = profileState.generalProfile.careerLevelId ?? 0;
          selectedFunctionalArea.value =
              profileState.generalProfile.functionalAreaId ?? 0;
          currentSalaryController.text =
              (profileState.generalProfile.currentSalary ?? 0)
                  .toStringAsFixed(0);
          expectedSalaryController.text =
              (profileState.generalProfile.expectedSalary ?? 0)
                  .toStringAsFixed(0);
          selectedCurrency.value =
              int.tryParse(profileState.generalProfile.salaryCurrency) ?? 0;
          facebookController.text =
              profileState.generalProfile.user?.facebookUrl ?? '';
          twitterController.text =
              profileState.generalProfile.user?.twitterUrl ?? '';
          linkedinController.text =
              profileState.generalProfile.user?.linkedinUrl ?? '';
          pinterestController.text =
              profileState.generalProfile.user?.pinterestUrl ?? '';
          googlePlusController.text =
              profileState.generalProfile.user?.googlePlusUrl ?? '';
          setState(() {});
        } else if (profileState.status ==
            ProfileCandidateStatus.generalProfileSaved) {
          LoadingDialog.dismiss();
          LoadingDialog.showSuccess(message: profileState.message);
        } else {
          LoadingDialog.dismiss();
        }
      },
      child: Scaffold(
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
            child: Form(
              key: _formKey,
              child: Column(
                children: [
                  BlocBuilder<ProfileCandidateBloc, ProfileCandidateState>(
                    builder: (context, state) {
                      return ZoomTapAnimation(
                        onTap: () async{
                          await ImagePickerHelper.pickImage(source: ImageSource.gallery);
                        },
                        child: Container(
                          width: 90.w,
                          height: 90.w,
                          decoration: BoxDecoration(
                            shape: BoxShape.circle,
                            boxShadow: AppColors.defaultShadow,
                            color: AppColors.bg200,
                          ),
                          child: Stack(
                            children: [
                              ClipOval(
                                child: CustomImageNetwork(
                                  imageUrl:
                                      state.generalProfile.user?.avatar ?? '',
                                  customErrorWidget: const Center(
                                    child: Icon(Icons.people),
                                  ),
                                  isLoaderShimmer: true,
                                ),
                              ),
                              Positioned(
                                bottom: 0,
                                right: 0,
                                child: Container(
                                  width: 34.w,
                                  height: 34.w,
                                  decoration: BoxDecoration(
                                    shape: BoxShape.circle,
                                    boxShadow: AppColors.defaultShadow,
                                    color: AppColors.warning50,
                                  ),
                                  child: Icon(
                                    GlobalHelper.isEmpty(
                                      state.generalProfile.user?.avatar,
                                    )
                                        ? Icons.upload
                                        : Icons.edit,
                                    size: 21.sp,
                                    color: AppColors.warning,
                                  ),
                                ),
                              )
                            ],
                          ),
                        ),
                      );
                    },
                  ),
                  const SpaceWidget(),
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
                    isReadOnly: true,
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
                    // isReadOnly: true,
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
                        (element) =>
                            genderOption[selectedGender.value] == element,
                      ),
                      itemAsString: (val) {
                        return val;
                      },
                      onChanged: (val) {
                        selectedGender.value = genderOption
                            .indexWhere((element) => element == val);
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
                          child: ValueListenableBuilder(
                              valueListenable: selectedSKill,
                              builder: (context, skills, _) {
                                return DropdownSearchMultiSelectWidget<
                                    JobsSkillEntity>(
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
                                );
                              }),
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
                      disableLengthCheck: true,
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
                                (element) =>
                                    element.id == selectedCareer.value),
                            itemAsString: (val) {
                              return val.levelName;
                            },
                            onChanged: (val) {
                              selectedCareer.value = val?.id ?? 0;
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
                    child: BlocProvider(
                      create: (context) => getIt<FunctionalAreaBloc>()
                        ..add(
                          const FunctionalAreaEvent.started(),
                        ),
                      child:
                          BlocBuilder<FunctionalAreaBloc, FunctionalAreaState>(
                        builder: (context, state) {
                          return DropdownSearchWidget<FunctionalAreaEntity>(
                            items: state.functionalAreas,
                            selectedItem:
                                state.functionalAreas.firstWhereOrNull(
                              (element) =>
                                  element.id == selectedFunctionalArea.value,
                            ),
                            onChanged: (val) {
                              selectedFunctionalArea.value = val?.id ?? 0;
                            },
                            itemAsString: (val) {
                              return val.name;
                            },
                            hintText: 'Functional Area',
                          );
                        },
                      ),
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
                    child: BlocProvider(
                      create: (context) => getIt<CurrencyBloc>()
                        ..add(
                          const CurrencyEvent.started(),
                        ),
                      child: BlocBuilder<CurrencyBloc, CurrencyState>(
                        builder: (context, state) {
                          return DropdownSearchWidget<CurrencyEntity>(
                            items: state.currency,
                            selectedItem: state.currency.firstWhereOrNull(
                              (element) => element.id == selectedCurrency.value,
                            ),
                            itemAsString: (val) {
                              return val.currencyName;
                            },
                            onChanged: (val) {
                              selectedCurrency.value = val?.id ?? 0;
                            },
                            hintText: 'Salary Currency',
                          );
                        },
                      ),
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
                              title: IText.set(text: 'Not Immediate Available'),
                              value: 0,
                              groupValue: available.value,
                              onChanged: (v) {
                                available.value = v!;
                              },
                            ),
                            RadioListTile(
                              contentPadding: EdgeInsets.zero,
                              title: IText.set(text: 'Immediate Available'),
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
                      return availableStatus == 0
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
                                  lastDate: DateTime.now()
                                      .add(const Duration(days: 730)),
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
                context.read<ProfileCandidateBloc>().add(
                      ProfileCandidateEvent.updateGeneralProfile(
                        GeneralProfileRequestParams(
                          firstName: firstNameController.text,
                          lastName: lastNameController.text,
                          address: '',
                          availableAt: availableDateController.text,
                          candidateSkill: List<int>.from(
                              selectedSKill.value.map((e) => e.id)),
                          careerLevelId: selectedCareer.value,
                          currentSalary:
                              double.tryParse(currentSalaryController.text),
                          dob: birthDateController.text,
                          expectedSalary:
                              double.tryParse(expectedSalaryController.text),
                          experience: int.tryParse(experiencesController.text),
                          facebookUrl: facebookController.text,
                          fatherName: fatherNameController.text,
                          functionalAreaId: selectedFunctionalArea.value,
                          gender: selectedGender.value,
                          googlePlusUrl: googlePlusController.text,
                          immediateAvailable: available.value,
                          linkedinUrl: linkedinController.text,
                          phone: phoneController.text,
                          pinterestUrl: pinterestController.text,
                          twitterUrl: twitterController.text,
                        ),
                      ),
                    );
              },
              child: const Text('Save'),
            ),
          ),
        ),
      ),
    );
  }
}
