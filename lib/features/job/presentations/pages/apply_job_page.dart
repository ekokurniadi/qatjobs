import 'package:collection/collection.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:qatjobs/core/styles/color_name_style.dart';
import 'package:qatjobs/core/styles/resolution_style.dart';
import 'package:qatjobs/core/styles/text_name_style.dart';
import 'package:qatjobs/core/widget/custom_appbar_widget.dart';
import 'package:qatjobs/core/widget/custom_text_field.dart';
import 'package:qatjobs/core/widget/loading_dialog_widget.dart';
import 'package:qatjobs/core/widget/vertical_space_widget.dart';
import 'package:qatjobs/features/job/domain/usecases/apply_job_usecase.dart';
import 'package:qatjobs/features/job/presentations/bloc/bloc/jobs_bloc.dart';
import 'package:qatjobs/features/profile/candidate/domain/entities/resume_entity.codegen.dart';

class ApplyJobPage extends StatefulWidget {
  const ApplyJobPage({
    super.key,
    required this.jobId,
    required this.jobTitle,
    required this.resumes,
    required this.favoritJobId,
  });
  final int jobId;
  final String jobTitle;
  final List<ResumeEntity> resumes;
  final int favoritJobId;

  @override
  State<ApplyJobPage> createState() => _ApplyJobPageState();
}

class _ApplyJobPageState extends State<ApplyJobPage> {
  final ValueNotifier<String> applicationType = ValueNotifier('draft');
  final ValueNotifier<int> selectedResume = ValueNotifier(0);
  final TextEditingController expectedSalaryController =
      TextEditingController();
  final GlobalKey<FormState> _formKey = GlobalKey();

  @override
  Widget build(BuildContext context) {
    return BlocListener<JobsBloc, JobsState>(
      listener: (context, state) {
        if(state.status == JobStatus.applyJobSuccess){
          LoadingDialog.showSuccess(message: state.message);
          context.read<JobsBloc>().add(JobsEvent.deleteFavoriteJob(widget.favoritJobId));
        }
      },
      child: Scaffold(
        backgroundColor: AppColors.bg300,
        appBar: const CustomAppBar(
          title: 'Apply Job',
          showLeading: true,
        ),
        body: SingleChildScrollView(
          child: SizedBox(
            width: double.infinity,
            height: MediaQuery.sizeOf(context).height,
            child: Padding(
              padding: defaultPadding,
              child: Form(
                key: _formKey,
                child: Column(
                  children: [
                    SizedBox(
                      width: double.infinity,
                      child: CustomTextField(
                        placeholder: 'Expected Salary',
                        label: 'Expected Salary',
                        isAlwaysShowLabel: true,
                        controller: expectedSalaryController,
                        isRequired: true,
                        textInputType: TextInputType.number,
                      ),
                    ),
                    Container(
                      width: double.infinity,
                      padding: defaultPadding,
                      decoration: BoxDecoration(
                        color: AppColors.bg200,
                        borderRadius: defaultRadius,
                      ),
                      child: ValueListenableBuilder(
                        valueListenable: applicationType,
                        builder: (context, type, _) {
                          return Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              const Text(
                                'Application Type',
                                style: TextStyle(
                                  color: AppColors.textPrimary,
                                ),
                              ),
                              RadioListTile(
                                contentPadding: EdgeInsets.zero,
                                title: const Text(
                                  'Draft',
                                  style: TextStyle(
                                    color: AppColors.textPrimary100,
                                  ),
                                ),
                                value: 'draft',
                                groupValue: applicationType.value,
                                onChanged: (val) {
                                  applicationType.value = val!;
                                },
                              ),
                              RadioListTile(
                                contentPadding: EdgeInsets.zero,
                                title: const Text(
                                  'Apply',
                                  style: TextStyle(
                                    color: AppColors.textPrimary100,
                                  ),
                                ),
                                value: 'apply',
                                groupValue: applicationType.value,
                                onChanged: (val) {
                                  applicationType.value = val!;
                                },
                              )
                            ],
                          );
                        },
                      ),
                    ),
                    const SpaceWidget(),
                    ValueListenableBuilder(
                      valueListenable: selectedResume,
                      builder: (context, selected, _) {
                        return Container(
                          width: double.infinity,
                          padding: defaultPadding,
                          decoration: BoxDecoration(
                            color: AppColors.bg200,
                            borderRadius: defaultRadius,
                          ),
                          child: DropdownButtonFormField<ResumeEntity>(
                            autovalidateMode:
                                AutovalidateMode.onUserInteraction,
                            decoration: InputDecoration(
                                border: InputBorder.none,
                                focusedBorder: InputBorder.none,
                                enabledBorder: InputBorder.none,
                                floatingLabelBehavior:
                                    FloatingLabelBehavior.always,
                                label: RichText(
                                  text: TextSpan(
                                    children: [
                                      TextSpan(
                                        text: 'Resume',
                                        style: IText.set(
                                          text: '',
                                          typeName: TextTypeName.headline3,
                                          styleName: TextStyleName.regular,
                                          color: AppColors.textPrimary,
                                        ).style,
                                      ),
                                      TextSpan(
                                        text: ' *',
                                        style: IText.set(
                                          text: '*',
                                          typeName: TextTypeName.headline1,
                                          styleName: TextStyleName.regular,
                                          color: AppColors.danger100,
                                        ).style,
                                      ),
                                    ],
                                  ),
                                )),
                            validator: (value) {
                              if (value == null) {
                                return 'Please fill out this field!';
                              }
                              return null;
                            },
                            isExpanded: true,
                            value: widget.resumes.firstWhereOrNull(
                              (element) => element.id == selectedResume.value,
                            ),
                            hint: const Text(
                              'Select Resume',
                              style: TextStyle(
                                color: AppColors.textPrimary100,
                              ),
                            ),
                            items: List.generate(
                              widget.resumes.length,
                              (index) => DropdownMenuItem(
                                value: widget.resumes[index],
                                child: Text(
                                  widget
                                      .resumes[index].customProperties['title'],
                                  style: const TextStyle(
                                    color: AppColors.textPrimary100,
                                  ),
                                ),
                              ),
                            ),
                            onChanged: (val) {
                              selectedResume.value = val!.id;
                            },
                          ),
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
                context.read<JobsBloc>().add(
                      JobsEvent.applyJob(
                        ApplyJobRequestParams(
                          jobId: widget.jobId,
                          expectedSalary:
                              int.tryParse(expectedSalaryController.text) ?? 0,
                          applicationType: applicationType.value,
                          resumeId: selectedResume.value,
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
