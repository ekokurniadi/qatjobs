import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:qatjobs/core/helpers/global_helper.dart';
import 'package:qatjobs/core/helpers/html_parse_helper.dart';
import 'package:qatjobs/core/styles/color_name_style.dart';
import 'package:qatjobs/core/styles/resolution_style.dart';
import 'package:qatjobs/core/widget/custom_appbar_widget.dart';
import 'package:qatjobs/core/widget/custom_text_field.dart';
import 'package:qatjobs/core/widget/loading_dialog_widget.dart';
import 'package:qatjobs/features/job_stages/data/models/job_stages_model.codegen.dart';
import 'package:qatjobs/features/job_stages/domain/usecases/add_job_stages_usecase.dart';
import 'package:qatjobs/features/job_stages/presentations/cubit/job_stages_cubit.dart';

class FormJobStagesPage extends StatefulWidget {
  const FormJobStagesPage({
    super.key,
    this.isEdit = false,
    this.jobStages,
  });
  final bool isEdit;
  final JobStagesModel? jobStages;

  @override
  State<FormJobStagesPage> createState() => _FormJobStagesPageState();
}

class _FormJobStagesPageState extends State<FormJobStagesPage> {
  final GlobalKey<FormState> _formKey = GlobalKey();
  final TextEditingController nameController = TextEditingController();
  final TextEditingController descController = TextEditingController();

  @override
  void initState() {
    if (widget.isEdit && !GlobalHelper.isEmpty(widget.jobStages)) {
      nameController.text = widget.jobStages?.name ?? '';
      descController.text = HtmlParseHelper.stripHtmlIfNeeded(
        widget.jobStages?.description ?? '',
      );
    }
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.bg300,
      appBar: const CustomAppBar(
        title: 'Job Stages',
        showLeading: true,
      ),
      body: BlocListener<JobStagesCubit, JobStagesState>(
        listener: (context, state) {
          if (state.status == JobStagesStatus.failure) {
            LoadingDialog.dismiss();
            LoadingDialog.showError(message: state.message);
          } else if (state.status == JobStagesStatus.added ||
              state.status == JobStagesStatus.updated) {
            LoadingDialog.dismiss();
            LoadingDialog.showSuccess(message: state.message);
            Future.delayed(const Duration(milliseconds: 1000), () {
              Navigator.pop(context);
              context.read<JobStagesCubit>().get();
            });
          } else if (state.status == JobStagesStatus.loading) {
            LoadingDialog.show(message: 'Loading ...');
          } else {
            LoadingDialog.dismiss();
          }
        },
        child: Padding(
          padding: defaultPadding,
          child: Form(
            key: _formKey,
            child: Column(
              children: [
                CustomTextField(
                  placeholder: 'Name',
                  label: 'Name',
                  isAlwaysShowLabel: true,
                  isRequired: true,
                  controller: nameController,
                ),
                CustomTextField(
                  placeholder: 'Description',
                  label: 'Description',
                  isAlwaysShowLabel: true,
                  maxLines: 8,
                  isRequired: true,
                  controller: descController,
                )
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
              if (widget.isEdit) {
                context.read<JobStagesCubit>().update(
                      JobStagesRequestParams(
                        id: widget.jobStages?.id ?? 0,
                        name: nameController.text,
                        description: descController.text,
                      ),
                    );
              } else {
                context.read<JobStagesCubit>().add(
                      JobStagesRequestParams(
                        name: nameController.text,
                        description: descController.text,
                      ),
                    );
              }
            },
            child: const Text('Save'),
          ),
        ),
      ),
    );
  }
}
