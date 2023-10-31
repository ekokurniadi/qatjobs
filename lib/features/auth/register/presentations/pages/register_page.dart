import 'package:email_validator/email_validator.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:oktoast/oktoast.dart';
import 'package:qatjobs/core/styles/color_name_style.dart';
import 'package:qatjobs/core/styles/text_name_style.dart';
import 'package:qatjobs/core/widget/custom_text_field.dart';
import 'package:qatjobs/features/auth/bloc/auth_bloc.dart';
import 'package:qatjobs/features/auth/domain/usecases/register_usecase.dart';
import 'package:qatjobs/injector.dart';

class RegisterPage extends StatefulWidget {
  const RegisterPage({super.key});

  @override
  State<RegisterPage> createState() => _RegisterPageState();
}

class _RegisterPageState extends State<RegisterPage> {
  final ValueNotifier<int> selectedRole = ValueNotifier(1);
  final ValueNotifier<bool> agreePolicy = ValueNotifier(false);
  final GlobalKey<FormState> _formKey = GlobalKey();
  final TextEditingController emailController = TextEditingController();
  final TextEditingController nameController = TextEditingController();
  final TextEditingController passwordController = TextEditingController();
  final TextEditingController confirmPasswordController =
      TextEditingController();

  @override
  void dispose() {
    selectedRole.dispose();
    agreePolicy.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => getIt<AuthBloc>(),
      child: BlocListener<AuthBloc, AuthState>(
        listener: (context, state) {
          if (state.status == AuthStatus.failure) {
            showToast(state.message);
          } else if (state.status == AuthStatus.registerSuccess) {
            showToast(state.message);
            Navigator.pop(context);
          }
        },
        child: SafeArea(
          child: Scaffold(
            backgroundColor: AppColors.bg200,
            resizeToAvoidBottomInset: false,
            body: Container(
              padding: const EdgeInsets.all(29),
              width: double.infinity,
              height: MediaQuery.sizeOf(context).height,
              child: SingleChildScrollView(
                padding: EdgeInsets.only(
                    bottom: MediaQuery.of(context).viewInsets.bottom),
                child: Form(
                  key: _formKey,
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.start,
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      SizedBox(height: 16.h),
                      Container(
                        width: double.infinity,
                        alignment: Alignment.center,
                        child: IText.set(
                          text: 'Register',
                          styleName: TextStyleName.bold,
                          typeName: TextTypeName.large,
                        ),
                      ),
                      SizedBox(height: 12.h),
                      Container(
                        width: double.infinity,
                        alignment: Alignment.center,
                        child: IText.set(
                          text:
                              'Explore all the most exciting job roles based on your interest and study major.',
                          styleName: TextStyleName.regular,
                          typeName: TextTypeName.caption1,
                          textAlign: TextAlign.center,
                          color: AppColors.textPrimary100,
                          lineHeight: 0,
                        ),
                      ),
                      SizedBox(height: 32.h),
                      ValueListenableBuilder(
                        valueListenable: selectedRole,
                        builder: (context, index, _) {
                          return Row(
                            children: [
                              Expanded(
                                child: SizedBox(
                                  height: 50.h,
                                  child: ElevatedButton(
                                    style: ElevatedButton.styleFrom(
                                      backgroundColor: index == 1
                                          ? AppColors.secondary200
                                          : AppColors.secondary,
                                      shadowColor: Colors.transparent,
                                    ),
                                    onPressed: () {
                                      selectedRole.value = 1;
                                    },
                                    child: IText.set(
                                      text: 'Candidate',
                                      styleName: TextStyleName.bold,
                                      typeName: TextTypeName.caption1,
                                      textAlign: TextAlign.center,
                                      color: AppColors.textPrimary,
                                    ),
                                  ),
                                ),
                              ),
                              SizedBox(width: 16.w),
                              Expanded(
                                child: SizedBox(
                                  height: 50.h,
                                  child: ElevatedButton(
                                    style: ElevatedButton.styleFrom(
                                      backgroundColor: index == 2
                                          ? AppColors.secondary200
                                          : AppColors.secondary,
                                      shadowColor: Colors.transparent,
                                    ),
                                    onPressed: () {
                                      selectedRole.value = 2;
                                    },
                                    child: IText.set(
                                      text: 'Employer',
                                      styleName: TextStyleName.bold,
                                      typeName: TextTypeName.caption1,
                                      textAlign: TextAlign.center,
                                      color: AppColors.textPrimary,
                                    ),
                                  ),
                                ),
                              ),
                            ],
                          );
                        },
                      ),
                      SizedBox(height: 16.h),
                      IText.set(
                        text: 'Name',
                        styleName: TextStyleName.bold,
                        typeName: TextTypeName.caption1,
                      ),
                      SizedBox(height: 16.h),
                      SizedBox(
                        width: double.infinity,
                        child: CustomTextField(
                          showBorder: true,
                          controller: nameController,
                          isRequired: true,
                          placeholder: 'Enter your name',
                        ),
                      ),
                      IText.set(
                        text: 'Email',
                        styleName: TextStyleName.bold,
                        typeName: TextTypeName.caption1,
                      ),
                      SizedBox(height: 16.h),
                      SizedBox(
                        width: double.infinity,
                        child: CustomTextField(
                          showBorder: true,
                          controller: emailController,
                          validator: (val) {
                            if (val!.isEmpty) {
                              return 'Please fill out this field !';
                            } else if (!EmailValidator.validate(val)) {
                              return 'Invalid format email';
                            }
                            return null;
                          },
                          placeholder: 'Email',
                        ),
                      ),
                      IText.set(
                        text: 'Password',
                        styleName: TextStyleName.bold,
                        typeName: TextTypeName.caption1,
                      ),
                      SizedBox(height: 16.h),
                      SizedBox(
                        width: double.infinity,
                        child: CustomTextField(
                          showBorder: true,
                          controller: passwordController,
                          isRequired: true,
                          placeholder: 'Password',
                          isPassword: true,
                        ),
                      ),
                      IText.set(
                        text: 'Confirm Password',
                        styleName: TextStyleName.bold,
                        typeName: TextTypeName.caption1,
                      ),
                      SizedBox(height: 16.h),
                      SizedBox(
                        width: double.infinity,
                        child: CustomTextField(
                          showBorder: true,
                          controller: confirmPasswordController,
                          validator: (val) {
                            if (val!.isEmpty) {
                              return 'Please fill out this field !';
                            } else if (confirmPasswordController.text !=
                                passwordController.text) {
                              return 'Password not match';
                            }
                            return null;
                          },
                          placeholder: 'Confirm Password',
                          isPassword: true,
                        ),
                      ),
                      Row(
                        crossAxisAlignment: CrossAxisAlignment.center,
                        children: [
                          Container(
                            width: 34.w,
                            height: 34.w,
                            decoration: BoxDecoration(
                              color: AppColors.secondary,
                              borderRadius: BorderRadius.circular(8.r),
                            ),
                            child: Transform.scale(
                              scale: 1.5,
                              child: ValueListenableBuilder(
                                valueListenable: agreePolicy,
                                builder: (context, remember, _) {
                                  return Checkbox(
                                    materialTapTargetSize:
                                        MaterialTapTargetSize.padded,
                                    activeColor: AppColors.secondary,
                                    shape: RoundedRectangleBorder(
                                      borderRadius: BorderRadius.circular(
                                        8.r,
                                      ),
                                      side: const BorderSide(
                                        color: AppColors.secondary,
                                      ),
                                    ),
                                    value: remember,
                                    onChanged: (checked) {
                                      agreePolicy.value = checked!;
                                    },
                                    checkColor: AppColors.textPrimary,
                                    fillColor: const MaterialStatePropertyAll(
                                      AppColors.secondary,
                                    ),
                                  );
                                },
                              ),
                            ),
                          ),
                          SizedBox(width: 16.w),
                          Expanded(
                            child: SizedBox(
                              child: IText.set(
                                text:
                                    'By signing up you agree to our Terms And Conditions & Privacy Policy',
                                styleName: TextStyleName.regular,
                                typeName: TextTypeName.caption1,
                                color: AppColors.textPrimary100,
                              ),
                            ),
                          ),
                        ],
                      ),
                      SizedBox(height: 16.h),
                      SizedBox(
                        width: double.infinity,
                        height: 60.h,
                        child: ValueListenableBuilder(
                          valueListenable: selectedRole,
                          builder: (context, role, _) {
                            return ValueListenableBuilder(
                                valueListenable: agreePolicy,
                                builder: (context, agree, _) {
                                  return BlocBuilder<AuthBloc, AuthState>(
                                    builder: (context, state) {
                                      return ElevatedButton(
                                        onPressed: !agreePolicy.value
                                            ? null
                                            : state.status == AuthStatus.loading
                                                ? () {}
                                                : () {
                                                    if (!_formKey.currentState!
                                                        .validate()) {
                                                      return;
                                                    }
                                                    context
                                                        .read<AuthBloc>()
                                                        .add(
                                                          RegisterEvent(
                                                            RegisterRequestParam(
                                                              email:
                                                                  emailController
                                                                      .text,
                                                              password:
                                                                  passwordController
                                                                      .text,
                                                              firstName:
                                                                  nameController
                                                                      .text,
                                                              type: selectedRole
                                                                  .value
                                                                  .toString(),
                                                            ),
                                                          ),
                                                        );
                                                  },
                                        child: state.status ==
                                                AuthStatus.loading
                                            ? const CircularProgressIndicator(
                                                color: AppColors.bg200,
                                              )
                                            : IText.set(
                                                text: 'Create Account',
                                                typeName:
                                                    TextTypeName.headline3,
                                                color: !agreePolicy.value
                                                    ? AppColors.textPrimary100
                                                    : AppColors.bg100,
                                              ),
                                      );
                                    },
                                  );
                                });
                          },
                        ),
                      ),
                      SizedBox(
                        width: double.infinity,
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            IText.set(
                              text: 'Already have an account ?',
                              styleName: TextStyleName.regular,
                              typeName: TextTypeName.caption1,
                              color: AppColors.textPrimary100,
                            ),
                            TextButton(
                              onPressed: () {
                                Navigator.pop(context);
                              },
                              child: IText.set(
                                text: 'Sign in',
                                styleName: TextStyleName.bold,
                                typeName: TextTypeName.caption1,
                                color: AppColors.warning,
                                textDecoration: TextDecoration.underline,
                              ),
                            )
                          ],
                        ),
                      )
                    ],
                  ),
                ),
              ),
            ),
          ),
        ),
      ),
    );
  }
}
