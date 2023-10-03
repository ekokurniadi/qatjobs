import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:qatjobs/core/styles/color_name_style.dart';
import 'package:qatjobs/core/styles/text_name_style.dart';
import 'package:qatjobs/core/widget/custom_text_field.dart';

class LoginPage extends StatefulWidget {
  const LoginPage({super.key});

  @override
  State<LoginPage> createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {
  final ValueNotifier<int> selectedRole = ValueNotifier(0);
  final ValueNotifier<bool> rememberMe = ValueNotifier(false);
  final GlobalKey<FormState> _formKey = GlobalKey();
  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        backgroundColor: AppColors.bg200,
        resizeToAvoidBottomInset: false,
        body: Container(
          padding: const EdgeInsets.all(29),
          width: double.infinity,
          height: MediaQuery.sizeOf(context).height,
          child: SingleChildScrollView(
            child: Form(
              key: _formKey,
              child: Column(
                mainAxisAlignment: MainAxisAlignment.start,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  SizedBox(height: 73.h),
                  Container(
                    width: double.infinity,
                    alignment: Alignment.center,
                    child: IText.set(
                      text: 'Welcome Back',
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
                      typeName: TextTypeName.body2,
                      textAlign: TextAlign.center,
                      color: AppColors.textPrimary100,
                      lineHeight: 0,
                    ),
                  ),
                  SizedBox(height: 64.h),
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
                                  backgroundColor: index == 0
                                      ? AppColors.secondary200
                                      : AppColors.secondary,
                                  shadowColor: Colors.transparent,
                                ),
                                onPressed: () {
                                  selectedRole.value = 0;
                                },
                                child: IText.set(
                                  text: 'Candidate',
                                  styleName: TextStyleName.bold,
                                  typeName: TextTypeName.body2,
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
                                  backgroundColor: index == 1
                                      ? AppColors.secondary200
                                      : AppColors.secondary,
                                  shadowColor: Colors.transparent,
                                ),
                                onPressed: () {
                                  selectedRole.value = 1;
                                },
                                child: IText.set(
                                  text: 'Employer',
                                  styleName: TextStyleName.bold,
                                  typeName: TextTypeName.body2,
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
                  SizedBox(height: 32.h),
                  IText.set(
                    text: 'Email',
                    styleName: TextStyleName.bold,
                    typeName: TextTypeName.body2,
                  ),
                  SizedBox(height: 16.h),
                  const SizedBox(
                    width: double.infinity,
                    child: CustomTextField(
                      isRequired: true,
                      placeholder: 'Email',
                    ),
                  ),
                  IText.set(
                    text: 'Password',
                    styleName: TextStyleName.bold,
                    typeName: TextTypeName.body2,
                  ),
                  SizedBox(height: 16.h),
                  const SizedBox(
                    width: double.infinity,
                    child: CustomTextField(
                      isRequired: true,
                      placeholder: 'Password',
                      isPassword: true,
                    ),
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: [
                      Row(
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
                                valueListenable: rememberMe,
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
                                      rememberMe.value = checked!;
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
                          IText.set(
                            text: 'Remember me',
                            styleName: TextStyleName.regular,
                            typeName: TextTypeName.body2,
                            color: AppColors.textPrimary100,
                          ),
                        ],
                      ),
                      TextButton(
                        onPressed: () {},
                        child: IText.set(
                          text: 'Forgot Password ?',
                          styleName: TextStyleName.bold,
                          typeName: TextTypeName.body2,
                          color: AppColors.primary,
                        ),
                      )
                    ],
                  ),
                  SizedBox(height: 32.h),
                  SizedBox(
                    width: double.infinity,
                    height: 60.h,
                    child: ValueListenableBuilder(
                      valueListenable: selectedRole,
                      builder: (context, role, _) {
                        return ElevatedButton(
                          onPressed: () {
                            if(!_formKey.currentState!.validate()){
                              return;
                            }
                          },
                          child: IText.set(
                            text: 'Login',
                            typeName: TextTypeName.buttonLarge,
                            color: AppColors.bg100,
                          ),
                        );
                      },
                    ),
                  ),
                  SizedBox(height: 22.h),
                  SizedBox(
                    width: double.infinity,
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        IText.set(
                          text: 'You don\'t have an account yet?',
                          styleName: TextStyleName.regular,
                          typeName: TextTypeName.body2,
                          color: AppColors.textPrimary100,
                        ),
                        TextButton(
                          onPressed: () {},
                          child: IText.set(
                            text: 'Sign up',
                            styleName: TextStyleName.bold,
                            typeName: TextTypeName.body2,
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
    );
  }
}
