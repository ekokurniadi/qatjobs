import 'package:email_validator/email_validator.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:oktoast/oktoast.dart';
import 'package:qatjobs/core/styles/color_name_style.dart';
import 'package:qatjobs/core/styles/text_name_style.dart';
import 'package:qatjobs/core/widget/custom_text_field.dart';
import 'package:qatjobs/features/auth/bloc/auth_bloc.dart';
import 'package:qatjobs/features/auth/domain/usecases/login_usecase.dart';
import 'package:qatjobs/injector.dart';

class LoginPage extends StatefulWidget {
  const LoginPage({super.key});

  @override
  State<LoginPage> createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {
  final ValueNotifier<int> selectedRole = ValueNotifier(1);
  final ValueNotifier<bool> rememberMe = ValueNotifier(false);
  final GlobalKey<FormState> _formKey = GlobalKey();
  final TextEditingController emailController = TextEditingController();
  final TextEditingController passwordController = TextEditingController();

  @override
  void dispose() {
    selectedRole.dispose();
    rememberMe.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => getIt<AuthBloc>(),
      child: BlocListener<AuthBloc, AuthState>(
        listener: (context, state) {
          if (state.status == LoginStatus.failure) {
            showToast(state.message);
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
                      SizedBox(
                        width: double.infinity,
                        child: CustomTextField(
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
                        typeName: TextTypeName.body2,
                      ),
                      SizedBox(height: 16.h),
                      SizedBox(
                        width: double.infinity,
                        child: CustomTextField(
                          controller: passwordController,
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
                                        fillColor:
                                            const MaterialStatePropertyAll(
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
                                if (!_formKey.currentState!.validate()) {
                                  return;
                                }
                                context.read<AuthBloc>().add(
                                      LoginEvent(
                                        LoginRequestParams(
                                          email: emailController.text,
                                          password: passwordController.text,
                                          deviceName: 'mobile',
                                        ),
                                      ),
                                    );
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
        ),
      ),
    );
  }
}
