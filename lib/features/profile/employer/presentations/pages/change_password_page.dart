import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:qatjobs/core/styles/color_name_style.dart';
import 'package:qatjobs/core/styles/resolution_style.dart';
import 'package:qatjobs/core/widget/custom_appbar_widget.dart';
import 'package:qatjobs/core/widget/custom_text_field.dart';
import 'package:qatjobs/core/widget/loading_dialog_widget.dart';
import 'package:qatjobs/features/profile/employer/domain/usecases/change_password_usecase.dart';
import 'package:qatjobs/features/profile/employer/presentations/cubit/employer_cubit.dart';

class EmployerChangePasswordPage extends StatefulWidget {
  const EmployerChangePasswordPage({super.key});

  @override
  State<EmployerChangePasswordPage> createState() =>
      _EmployerChangePasswordPageState();
}

class _EmployerChangePasswordPageState
    extends State<EmployerChangePasswordPage> {
  final TextEditingController currentPasswordController =
      TextEditingController();
  final TextEditingController newPasswordController = TextEditingController();
  final TextEditingController confirmPasswordController =
      TextEditingController();
  final GlobalKey<FormState> _formKey = GlobalKey();

  @override
  Widget build(BuildContext context) {
    return BlocListener<EmployerCubit, EmployerState>(
      listener: (context, state) {
        if (state.status == EmployerStatus.changePasswordSuccess) {
          LoadingDialog.dismiss();
          LoadingDialog.showSuccess(message: state.message);
          Navigator.pop(context);
        } else if (state.status == EmployerStatus.failure) {
          LoadingDialog.dismiss();
          LoadingDialog.showError(message: state.message);
        } else if (state.status == EmployerStatus.loading) {
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

                context.read<EmployerCubit>().changePassword(
                      ChangePasswordRequestParams(
                        password: newPasswordController.text,
                        passwordCurrent: currentPasswordController.text,
                        passwordConfirmation: confirmPasswordController.text,
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
