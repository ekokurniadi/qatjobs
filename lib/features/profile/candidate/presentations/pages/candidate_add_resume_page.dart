import 'dart:io';

import 'package:dotted_border/dotted_border.dart';
import 'package:file_picker/file_picker.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:mime/mime.dart';
import 'package:qatjobs/core/constant/app_constant.dart';
import 'package:qatjobs/core/constant/assets_constant.dart';
import 'package:qatjobs/core/styles/color_name_style.dart';
import 'package:qatjobs/core/styles/resolution_style.dart';
import 'package:qatjobs/core/styles/text_name_style.dart';
import 'package:qatjobs/core/widget/custom_appbar_widget.dart';
import 'package:qatjobs/core/widget/custom_text_field.dart';
import 'package:qatjobs/core/widget/loading_dialog_widget.dart';
import 'package:qatjobs/core/widget/vertical_space_widget.dart';
import 'package:qatjobs/features/profile/candidate/domain/usecases/candidate_upload_resume_usecase.dart';
import 'package:qatjobs/features/profile/candidate/presentations/bloc/profile_candidate_bloc.dart';
import 'package:zoom_tap_animation/zoom_tap_animation.dart';

class CandidateAddResumePage extends StatefulWidget {
  const CandidateAddResumePage({super.key});

  @override
  State<CandidateAddResumePage> createState() => _CandidateAddResumePageState();
}

class _CandidateAddResumePageState extends State<CandidateAddResumePage> {
  final ValueNotifier<File?> fileUploaded = ValueNotifier(null);
  final TextEditingController titleController = TextEditingController();
  final GlobalKey<FormState> _formKey = GlobalKey();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      resizeToAvoidBottomInset: false,
      backgroundColor: AppColors.bg300,
      extendBody: true,
      appBar: const CustomAppBar(
        title: 'Add Resume',
        showLeading: true,
      ),
      body: BlocListener<ProfileCandidateBloc, ProfileCandidateState>(
        listener: (context, state) {
          if (state.status == ProfileCandidateStatus.failure) {
            LoadingDialog.dismiss();
            LoadingDialog.showError(message: state.message);
          } else if (state.status == ProfileCandidateStatus.insertResume) {
            LoadingDialog.dismiss();
            LoadingDialog.showSuccess(message: state.message);
            Navigator.pop(context);
          }
        },
        child: Container(
          width: double.infinity,
          height: MediaQuery.sizeOf(context).height,
          padding: defaultPadding,
          child: SingleChildScrollView(
            child: Form(
              key: _formKey,
              child: Column(
                children: [
                  CustomTextField(
                    placeholder: 'Title',
                    controller: titleController,
                    isRequired: true,
                  ),
                  ValueListenableBuilder(
                      valueListenable: fileUploaded,
                      builder: (context, file, _) {
                        return fileUploaded.value == null
                            ? ZoomTapAnimation(
                                onTap: () async {
                                  final result =
                                      await FilePicker.platform.pickFiles(
                                    type: FileType.custom,
                                    allowedExtensions: [
                                      'jpg',
                                      'jpeg',
                                      'pdf',
                                      'doc',
                                      'docx',
                                      'png',
                                    ],
                                  );
                                  if (result != null) {
                                    fileUploaded.value = File(
                                      result.files.first.path!,
                                    );
                                  }
                                },
                                child: ClipRRect(
                                  borderRadius: defaultRadius,
                                  child: DottedBorder(
                                    color: AppColors.neutral,
                                    child: Container(
                                      width: double.infinity,
                                      padding: defaultPadding,
                                      decoration: BoxDecoration(
                                        borderRadius: defaultRadius,
                                        color: AppColors.bg200,
                                      ),
                                      child: Row(
                                        mainAxisAlignment:
                                            MainAxisAlignment.center,
                                        crossAxisAlignment:
                                            CrossAxisAlignment.center,
                                        children: [
                                          SvgPicture.asset(
                                            AssetsConstant.svgAssetsUploadCV,
                                            width: 60.w,
                                          ),
                                          const SpaceWidget(
                                              direction: Direction.horizontal),
                                          IText.set(text: 'Upload CV/Resume')
                                        ],
                                      ),
                                    ),
                                  ),
                                ),
                              )
                            : ClipRRect(
                                borderRadius: defaultRadius,
                                child: DottedBorder(
                                  color: AppColors.neutral,
                                  child: Container(
                                    width: double.infinity,
                                    padding: defaultPadding,
                                    decoration: BoxDecoration(
                                      borderRadius: defaultRadius,
                                      color: AppColors.bg200,
                                    ),
                                    child: Row(
                                      mainAxisAlignment:
                                          MainAxisAlignment.start,
                                      crossAxisAlignment:
                                          CrossAxisAlignment.center,
                                      children: [
                                        SvgPicture.asset(
                                          lookupMimeType(fileUploaded
                                                      .value!.path)!
                                                  .contains(
                                                      AppConstant.mimeTypePDF)
                                              ? AssetsConstant.svgAssetsPDF
                                              : lookupMimeType(
                                                          fileUploaded
                                                              .value!.path)!
                                                      .contains(
                                                          AppConstant
                                                              .mimeTypeImage)
                                                  ? AssetsConstant
                                                      .svgAssetsPicture
                                                  : AssetsConstant.svgAssetsDoc,
                                          width: 42.w,
                                        ),
                                        const SpaceWidget(
                                            direction: Direction.horizontal),
                                        Expanded(
                                          child: IText.set(
                                            text: file!.path.split('/').last,
                                          ),
                                        ),
                                        IconButton(
                                          onPressed: () {
                                            fileUploaded.value = null;
                                          },
                                          icon: SvgPicture.asset(
                                            AssetsConstant.svgAssetsDelete,
                                          ),
                                        ),
                                      ],
                                    ),
                                  ),
                                ),
                              );
                      }),
                  const SpaceWidget(),
                  IText.set(
                    text:
                        'Upload files in PDF, Image or Doc. Just upload it once and you can use it in your next application.',
                    textAlign: TextAlign.center,
                    color: AppColors.textPrimary100,
                    styleName: TextStyleName.regular,
                    typeName: TextTypeName.caption2,
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
              if (fileUploaded.value == null) {
                LoadingDialog.showError(message: 'Please select file before');
                return;
              }
              context.read<ProfileCandidateBloc>().add(
                    ProfileCandidateEvent.uploadResume(
                      ResumeRequestParams(
                        title: titleController.text,
                        file: fileUploaded.value!,
                        isDefault: 0,
                      ),
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
