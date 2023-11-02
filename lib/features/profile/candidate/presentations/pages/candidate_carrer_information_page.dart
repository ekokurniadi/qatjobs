import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:intl/intl.dart';
import 'package:qatjobs/core/constant/assets_constant.dart';
import 'package:qatjobs/core/helpers/date_helper.dart';
import 'package:qatjobs/core/helpers/global_helper.dart';
import 'package:qatjobs/core/styles/color_name_style.dart';
import 'package:qatjobs/core/styles/resolution_style.dart';
import 'package:qatjobs/core/styles/text_name_style.dart';
import 'package:qatjobs/core/widget/confirm_dialog_bottom_sheet.dart';
import 'package:qatjobs/core/widget/custom_appbar_widget.dart';
import 'package:qatjobs/core/widget/custom_text_field.dart';
import 'package:qatjobs/core/widget/loading_dialog_widget.dart';
import 'package:qatjobs/core/widget/section_title_widget.dart';
import 'package:qatjobs/core/widget/vertical_space_widget.dart';
import 'package:qatjobs/features/profile/candidate/data/models/candidate_experience_models.codegen.dart';
import 'package:qatjobs/features/profile/candidate/domain/entities/candidate_experience_entity.codegen.dart';
import 'package:qatjobs/features/profile/candidate/presentations/bloc/profile_candidate_bloc.dart';
import 'package:zoom_tap_animation/zoom_tap_animation.dart';

class CandidateCareerInformationPage extends StatefulWidget {
  const CandidateCareerInformationPage({super.key});

  @override
  State<CandidateCareerInformationPage> createState() =>
      _CandidateCareerInformationPageState();
}

class _CandidateCareerInformationPageState
    extends State<CandidateCareerInformationPage> {
  final ValueNotifier<int> indexPage = ValueNotifier(0);

  @override
  void initState() {
    context
        .read<ProfileCandidateBloc>()
        .add(const ProfileCandidateEvent.getExperiences());
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      resizeToAvoidBottomInset: false,
      backgroundColor: AppColors.bg300,
      appBar: const CustomAppBar(
        title: 'Career Informations',
        showLeading: true,
      ),
      body: BlocListener<ProfileCandidateBloc, ProfileCandidateState>(
        listener: (context, state) {
          if (state.status == ProfileCandidateStatus.failure) {
            LoadingDialog.dismiss();
            LoadingDialog.showError(message: state.message);
          } else if (state.status == ProfileCandidateStatus.loading) {
            LoadingDialog.show(message: 'Loading ...');
          } else if (state.status == ProfileCandidateStatus.addExperiences) {
            LoadingDialog.dismiss();
            LoadingDialog.showSuccess(message: state.message);
            context
                .read<ProfileCandidateBloc>()
                .add(const ProfileCandidateEvent.getExperiences());
          } else {
            LoadingDialog.dismiss();
          }
        },
        child: Container(
          width: double.infinity,
          height: MediaQuery.sizeOf(context).height,
          padding: defaultPadding,
          child: Column(
            children: [
              ValueListenableBuilder(
                valueListenable: indexPage,
                builder: (context, index, _) {
                  return SizedBox(
                    width: double.infinity,
                    height: 50.h,
                    child: Row(
                      children: [
                        Expanded(
                          child: ZoomTapAnimation(
                            onTap: () {
                              indexPage.value = 0;
                              context.read<ProfileCandidateBloc>().add(
                                    const ProfileCandidateEvent
                                        .getExperiences(),
                                  );
                            },
                            child: Container(
                              decoration: BoxDecoration(
                                color: index == 0
                                    ? AppColors.secondary
                                    : AppColors.bg200,
                                boxShadow: AppColors.defaultShadow,
                                borderRadius: BorderRadius.circular(
                                  8.r,
                                ),
                              ),
                              margin: EdgeInsets.only(right: 8.w, bottom: 8.w),
                              padding: const EdgeInsets.all(8),
                              child: Center(
                                child: IText.set(
                                  text: 'Experiences',
                                  textAlign: TextAlign.left,
                                  styleName: index == 0
                                      ? TextStyleName.bold
                                      : TextStyleName.regular,
                                  typeName: TextTypeName.caption1,
                                  color: AppColors.textPrimary,
                                ),
                              ),
                            ),
                          ),
                        ),
                        Expanded(
                          child: ZoomTapAnimation(
                            onTap: () => indexPage.value = 1,
                            child: Container(
                              decoration: BoxDecoration(
                                color: index == 1
                                    ? AppColors.secondary
                                    : AppColors.bg200,
                                boxShadow: AppColors.defaultShadow,
                                borderRadius: BorderRadius.circular(
                                  8.r,
                                ),
                              ),
                              margin: EdgeInsets.only(right: 8.w, bottom: 8.w),
                              padding: const EdgeInsets.all(8),
                              child: Center(
                                child: IText.set(
                                  text: 'Education',
                                  textAlign: TextAlign.left,
                                  styleName: index == 1
                                      ? TextStyleName.bold
                                      : TextStyleName.regular,
                                  typeName: TextTypeName.caption1,
                                  color: AppColors.textPrimary,
                                ),
                              ),
                            ),
                          ),
                        )
                      ],
                    ),
                  );
                },
              ),
              if (indexPage.value == 0) ...[
                SizedBox(
                  width: double.infinity,
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.end,
                    children: [
                      InkWell(
                        onTap: () async {
                          await showDialog(
                            context: context,
                            barrierDismissible: false,
                            builder: (context) {
                              return Dialog(
                                shape: RoundedRectangleBorder(
                                  borderRadius: defaultRadius,
                                ),
                                child: const _DialogAddExperience(),
                              );
                            },
                          );
                        },
                        child: ZoomTapAnimation(
                          child: Container(
                            padding: defaultPadding,
                            child: Row(
                              children: [
                                IText.set(
                                  text: 'Add Experience',
                                  color: AppColors.warning,
                                  typeName: TextTypeName.caption1,
                                  styleName: TextStyleName.semiBold,
                                ),
                                SizedBox(width: 8.w),
                                Container(
                                  width: 24.w,
                                  height: 24.w,
                                  decoration: BoxDecoration(
                                    shape: BoxShape.circle,
                                    boxShadow: AppColors.defaultShadow,
                                    color: AppColors.warning50,
                                  ),
                                  child: Icon(
                                    Icons.add,
                                    size: 14.sp,
                                    color: AppColors.warning,
                                  ),
                                )
                              ],
                            ),
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
                const Flexible(child: _ListExperiences()),
              ]
            ],
          ),
        ),
      ),
    );
  }
}

class _DialogAddExperience extends StatefulWidget {
  const _DialogAddExperience({
    this.experienceEntity,
    this.isEdit = false,
  });

  final CandidateExperienceEntity? experienceEntity;
  final bool isEdit;

  @override
  State<_DialogAddExperience> createState() => _DialogAddExperienceState();
}

class _DialogAddExperienceState extends State<_DialogAddExperience> {
  final TextEditingController titleController = TextEditingController();
  final TextEditingController companyController = TextEditingController();
  final TextEditingController startDateController = TextEditingController();
  final TextEditingController endDateController = TextEditingController();
  final TextEditingController descriptionController = TextEditingController();
  final ValueNotifier<bool> isCurrently = ValueNotifier(false);
  final GlobalKey<FormState> _formKey = GlobalKey();

  @override
  void initState() {
    if (widget.isEdit) {
      titleController.text = widget.experienceEntity?.experienceTitle ?? '';
      companyController.text = widget.experienceEntity?.company ?? '';
      startDateController.text =
          !GlobalHelper.isEmpty(widget.experienceEntity?.startDate)
              ? DateHelper.getOnlyDate(widget.experienceEntity?.startDate)
              : '';
      endDateController.text =
          !GlobalHelper.isEmpty(widget.experienceEntity?.endDate)
              ? DateHelper.getOnlyDate(widget.experienceEntity?.endDate)
              : '';
      isCurrently.value = widget.experienceEntity?.currentlyWorking ?? false;
      descriptionController.text = widget.experienceEntity?.description ?? '';
    }
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: defaultPadding,
      decoration: BoxDecoration(
        color: AppColors.bg200,
        borderRadius: defaultRadius,
      ),
      child: SingleChildScrollView(
        child: Form(
          key: _formKey,
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              SectionTitleWidget(
                title: widget.isEdit ? 'Edit Experience' : 'Add Experience',
              ),
              const SpaceWidget(),
              SizedBox(
                width: double.infinity,
                child: CustomTextField(
                  showBorder: true,
                  placeholder: 'Experience Title',
                  isAlwaysShowLabel: true,
                  controller: titleController,
                  isRequired: true,
                  label: 'Experience Title',
                ),
              ),
              SizedBox(
                width: double.infinity,
                child: CustomTextField(
                  showBorder: true,
                  placeholder: 'Company',
                  isAlwaysShowLabel: true,
                  controller: companyController,
                  isRequired: true,
                  label: 'Company',
                ),
              ),
              SizedBox(
                width: double.infinity,
                child: CustomTextField(
                  showBorder: true,
                  placeholder: 'Start Date',
                  isAlwaysShowLabel: true,
                  controller: startDateController,
                  isRequired: true,
                  isCalendarPicker: true,
                  isReadOnly: true,
                  label: 'Start Date',
                  onTap: () async {
                    final result = await showDatePicker(
                      context: context,
                      firstDate: DateTime.parse('1900-01-01'),
                      initialDate: DateTime.now(),
                      lastDate: DateTime.now(),
                    );
                    if (result != null) {
                      startDateController.text =
                          DateFormat('yyyy-MM-dd').format(result);
                    }
                  },
                ),
              ),
              SizedBox(
                width: double.infinity,
                child: ValueListenableBuilder(
                  valueListenable: isCurrently,
                  builder: (context, isCurrent, _) {
                    return Visibility(
                      visible: !isCurrently.value,
                      child: CustomTextField(
                        showBorder: true,
                        placeholder: 'End Date',
                        isAlwaysShowLabel: true,
                        controller: endDateController,
                        isRequired: !isCurrently.value,
                        isCalendarPicker: true,
                        isReadOnly: true,
                        label: 'End Date',
                        onTap: isCurrently.value
                            ? null
                            : () async {
                                final result = await showDatePicker(
                                  context: context,
                                  firstDate: DateTime.parse('1900-01-01'),
                                  initialDate: DateTime.now(),
                                  lastDate: DateTime.now(),
                                );
                                if (result != null) {
                                  endDateController.text =
                                      DateFormat('yyyy-MM-dd').format(result);
                                }
                              },
                      ),
                    );
                  },
                ),
              ),
              ValueListenableBuilder(
                  valueListenable: isCurrently,
                  builder: (context, isCurrent, _) {
                    return SwitchListTile(
                      contentPadding: EdgeInsets.zero,
                      activeColor: AppColors.warning,
                      title: IText.set(
                        text: 'Currently Working',
                        textAlign: TextAlign.left,
                        styleName: TextStyleName.semiBold,
                        typeName: TextTypeName.headline3,
                        color: AppColors.textPrimary100,
                      ),
                      value: isCurrently.value,
                      onChanged: (val) {
                        isCurrently.value = val;
                      },
                    );
                  }),
              SizedBox(
                width: double.infinity,
                child: CustomTextField(
                  showBorder: true,
                  placeholder: 'Description',
                  isAlwaysShowLabel: true,
                  controller: descriptionController,
                  label: 'Description',
                ),
              ),
              SizedBox(
                width: double.infinity,
                height: 40.h,
                child: ElevatedButton(
                  onPressed: () {
                    if (!_formKey.currentState!.validate()) {
                      return;
                    }

                    if (widget.isEdit) {
                    } else {
                      Navigator.pop(context);
                      context.read<ProfileCandidateBloc>().add(
                            ProfileCandidateEvent.addExperiences(
                              CandidateExperienceModels(
                                id: 0,
                                candidateId: 0,
                                experienceTitle: titleController.text,
                                startDate: startDateController.text,
                                company: companyController.text,
                                currentlyWorking: isCurrently.value,
                                description: descriptionController.text,
                                endDate:
                                    GlobalHelper.isEmpty(endDateController.text)
                                        ? DateHelper.getOnlyDate(
                                            DateTime.now().toString())
                                        : endDateController.text,
                              ),
                            ),
                          );
                    }
                  },
                  child: IText.set(
                    text: 'SAVE',
                    styleName: TextStyleName.semiBold,
                    color: AppColors.bg100,
                  ),
                ),
              ),
              const SpaceWidget(),
              SizedBox(
                  width: double.infinity,
                  height: 40.h,
                  child: ElevatedButton(
                    style: ElevatedButton.styleFrom(
                      backgroundColor: AppColors.secondary,
                    ),
                    onPressed: () {
                      Navigator.pop(context);
                    },
                    child: IText.set(
                      text: 'UNDO CHANGES',
                      styleName: TextStyleName.semiBold,
                      color: AppColors.textPrimary100,
                    ),
                  )),
            ],
          ),
        ),
      ),
    );
  }
}

class _ListExperiences extends StatelessWidget {
  const _ListExperiences();

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<ProfileCandidateBloc, ProfileCandidateState>(
      builder: (context, state) {
        return state.experiences.isEmpty
            ? Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  SvgPicture.asset(AssetsConstant.illusJobEmpty),
                  const SpaceWidget(),
                  IText.set(
                    text: 'Experiences is empty',
                    textAlign: TextAlign.left,
                    styleName: TextStyleName.medium,
                    typeName: TextTypeName.large,
                    color: AppColors.textPrimary,
                    lineHeight: 1.2.h,
                  ),
                  const SpaceWidget(),
                  IText.set(
                    text: 'Please add your experiences first',
                    textAlign: TextAlign.left,
                    styleName: TextStyleName.regular,
                    typeName: TextTypeName.caption1,
                    color: AppColors.textPrimary100,
                  )
                ],
              )
            : ListView.separated(
                separatorBuilder: (context, index) => const SpaceWidget(),
                shrinkWrap: true,
                itemCount: state.experiences.length,
                itemBuilder: (context, index) {
                  return Container(
                    padding: defaultPadding,
                    decoration: BoxDecoration(
                      borderRadius: defaultRadius,
                      boxShadow: AppColors.defaultShadow,
                      color: AppColors.bg200,
                    ),
                    child: Row(
                      children: [
                        Expanded(
                          flex: 3,
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              IText.set(
                                text: state.experiences[index].experienceTitle,
                                styleName: TextStyleName.bold,
                                typeName: TextTypeName.headline2,
                                color: AppColors.primary,
                              ),
                              IText.set(
                                text: state.experiences[index].company,
                                styleName: TextStyleName.regular,
                                typeName: TextTypeName.headline3,
                                color: AppColors.textPrimary100,
                              ),
                              Row(
                                children: [
                                  IText.set(
                                    text: DateHelper.formatdMy(
                                      state.experiences[index].startDate,
                                    ),
                                    styleName: TextStyleName.regular,
                                    typeName: TextTypeName.headline3,
                                    color: AppColors.textPrimary100,
                                  ),
                                  IText.set(text: ' - '),
                                  IText.set(
                                    text: state
                                            .experiences[index].currentlyWorking
                                        ? 'Present'
                                        : DateHelper.formatdMy(
                                            state.experiences[index].endDate,
                                          ),
                                    styleName: TextStyleName.regular,
                                    typeName: TextTypeName.headline3,
                                    color: AppColors.textPrimary100,
                                  ),
                                ],
                              ),
                              IText.set(
                                text:
                                    state.experiences[index].description ?? '',
                                styleName: TextStyleName.regular,
                                typeName: TextTypeName.headline3,
                                color: AppColors.textPrimary100,
                              ),
                            ],
                          ),
                        ),
                        SizedBox(
                          child: Row(
                            children: [
                              IconButton(
                                onPressed: () async {
                                  await showDialog(
                                    context: context,
                                    builder: (context) {
                                      return Dialog(
                                        shape: RoundedRectangleBorder(
                                          borderRadius: defaultRadius,
                                        ),
                                        child: _DialogAddExperience(
                                          isEdit: true,
                                          experienceEntity:
                                              state.experiences[index],
                                        ),
                                      );
                                    },
                                  );
                                },
                                icon: SvgPicture.asset(
                                  AssetsConstant.svgAssetsEdit,
                                  color: AppColors.warning,
                                ),
                              ),
                              SizedBox(width: 8.w),
                              IconButton(
                                onPressed: () async {
                                  await showModalBottomSheet(
                                    shape: const RoundedRectangleBorder(
                                        borderRadius: BorderRadius.only(
                                      topRight: Radius.circular(32),
                                      topLeft: Radius.circular(32),
                                    )),
                                    context: context,
                                    builder: (context) {
                                      return ConfirmDialogBottomSheet(
                                        title: 'Remove Experience ?',
                                        caption:
                                            'Are you sure you want to delete ${state.experiences[index].experienceTitle}?',
                                        onTapCancel: () =>
                                            Navigator.pop(context),
                                        onTapContinue: () {
                                          Navigator.pop(context);
                                          context
                                              .read<ProfileCandidateBloc>()
                                              .add(
                                                ProfileCandidateEvent
                                                    .deleteResume(
                                                  state.resumes[index].id,
                                                ),
                                              );
                                        },
                                      );
                                    },
                                  );
                                },
                                icon: SvgPicture.asset(
                                  AssetsConstant.svgAssetsDelete,
                                ),
                              )
                            ],
                          ),
                        )
                      ],
                    ),
                  );
                },
              );
      },
    );
  }
}
