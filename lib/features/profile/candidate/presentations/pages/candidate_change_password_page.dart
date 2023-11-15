import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:qatjobs/core/styles/color_name_style.dart';
import 'package:qatjobs/core/styles/resolution_style.dart';
import 'package:qatjobs/core/widget/custom_appbar_widget.dart';
import 'package:qatjobs/core/widget/custom_text_field.dart';
import 'package:qatjobs/core/widget/loading_dialog_widget.dart';
import 'package:qatjobs/features/profile/candidate/domain/usecases/candidate_change_password_usecase.dart';
import 'package:qatjobs/features/profile/candidate/presentations/bloc/profile_candidate_bloc.dart';

class CandidateChangePasswordPage extends StatefulWidget {
  const CandidateChangePasswordPage({super.key});

  @override
  State<CandidateChangePasswordPage> createState() =>
      _CandidateChangePasswordPageState();
}

class _CandidateChangePasswordPageState
    extends State<CandidateChangePasswordPage> {
  final TextEditingController currentPasswordController =
      TextEditingController();
  final TextEditingController newPasswordController = TextEditingController();
  final TextEditingController confirmPasswordController =
      TextEditingController();
  final GlobalKey<FormState> _formKey = GlobalKey();

  @override
  Widget build(BuildContext context) {
    return BlocListener<ProfileCandidateBloc, ProfileCandidateState>(
      listener: (context, state) {
        if (state.status == ProfileCandidateStatus.changePasswordSuccess) {
          LoadingDialog.dismiss();
          LoadingDialog.showSuccess(message: state.message);
          Navigator.pop(context);
        } else if (state.status == ProfileCandidateStatus.failure) {
          LoadingDialog.dismiss();
          LoadingDialog.showError(message: state.message);
        } else if (state.status == ProfileCandidateStatus.loading) {
          LoadingDialog.show(message: 'Loading ...');
        } else {
          LoadingDialog.dismiss();
        }
      },
      child: Scaffold(
        backgroundColor: AppColors.bg300,
        appBar: const CustomAppBar(
          title: 'Change Password',
          showLeading: true,
        ),
        body: Container(
          width: double.infinity,
          padding: defaultPadding,
          child: Form(
            key: _formKey,
            child: Column(
              children: [
                CustomTextField(
                  placeholder: 'Current Password',
                  controller: currentPasswordController,
                  isPassword: true,
                  isRequired: true,
                ),
                CustomTextField(
                  placeholder: 'New Password',
                  controller: newPasswordController,
                  isPassword: true,
                  validator: (val) {
                    if (val!.isEmpty) {
                      return 'Please fill out this field!';
                    } else if (val.length < 6) {
                      return 'Password must contain at least 6 characters.';
                    }
                    return null;
                  },
                ),
                CustomTextField(
                  placeholder: 'Confirm Password',
                  controller: confirmPasswordController,
                  isPassword: true,
                  validator: (val) {
                    if (val!.isEmpty) {
                      return 'Please fill out this field!';
                    } else if (val != newPasswordController.text) {
                      return 'Confirm password not matching';
                    } else if (val.length < 6) {
                      return 'Password must contain at least 6 characters.';
                    }
                    return null;
                  },
                )
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
              onPressed: () {
                if (!_formKey.currentState!.validate()) return;
                context.read<ProfileCandidateBloc>().add(
                        ProfileCandidateEvent.changePassword(
                            ChangePasswordRequestParams(
                      password: newPasswordController.text,
                      passwordConfirmation: confirmPasswordController.text,
                      passwordCurrent: currentPasswordController.text,
                    )));
              },
              child: const Text('Save'),
            ),
          ),
        ),
      ),
    );
  }
}
