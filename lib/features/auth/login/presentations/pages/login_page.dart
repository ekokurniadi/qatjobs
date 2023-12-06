import 'package:auto_route/auto_route.dart';
import 'package:email_validator/email_validator.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:qatjobs/core/auto_route/auto_route.gr.dart';
import 'package:qatjobs/core/constant/app_constant.dart';
import 'package:qatjobs/core/styles/color_name_style.dart';
import 'package:qatjobs/core/styles/resolution_style.dart';
import 'package:qatjobs/core/styles/text_name_style.dart';
import 'package:qatjobs/core/widget/custom_text_field.dart';
import 'package:qatjobs/core/widget/loading_dialog_widget.dart';
import 'package:qatjobs/core/widget/vertical_space_widget.dart';
import 'package:qatjobs/features/auth/bloc/auth_bloc.dart';
import 'package:qatjobs/features/auth/domain/usecases/login_usecase.dart';
import 'package:qatjobs/features/notification/presentations/cubit/notification_cubit.dart';
import 'package:qatjobs/features/users/presentations/bloc/user_bloc.dart';
import 'package:qatjobs/injector.dart';
import 'package:shared_preferences/shared_preferences.dart';

class LoginPage extends StatefulWidget {
  const LoginPage({super.key});

  @override
  State<LoginPage> createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {
  final ValueNotifier<int> selectedRole = ValueNotifier(1);
  final ValueNotifier<bool> rememberMe = ValueNotifier(false);
  final GlobalKey<FormState> _formKey = GlobalKey();
  final GlobalKey<FormState> _formForgotPassworKey = GlobalKey();
  final TextEditingController emailController = TextEditingController();
  final TextEditingController passwordController = TextEditingController();
  final TextEditingController emailForgotPassword = TextEditingController();

  @override
  void initState() {
    getRememberMe();
    super.initState();
  }

  Future<void> getRememberMe() async {
    final isRememberMeActive = getIt<SharedPreferences>().getBool(
      AppConstant.prefIsRememberMeKey,
    );

    rememberMe.value = isRememberMeActive ?? false;

    if (isRememberMeActive ?? false) {
      final email = getIt<SharedPreferences>().getString(
        AppConstant.prefEmailKey,
      );
      final password = getIt<SharedPreferences>().getString(
        AppConstant.prefPasswordKey,
      );
      final role = getIt<SharedPreferences>().getInt(
        AppConstant.prefSelectedRoledKey,
      );

      emailController.text = email ?? '';
      passwordController.text = password ?? '';
      selectedRole.value = role ?? 0;
    }
  }

  @override
  void dispose() {
    selectedRole.dispose();
    rememberMe.dispose();
    emailForgotPassword.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return BlocListener<AuthBloc, AuthState>(
      listener: (context, state) {
        if (state.status == AuthStatus.failure) {
          LoadingDialog.dismiss();
          LoadingDialog.showError(message: state.message);
        } else if (state.status == AuthStatus.success) {
          LoadingDialog.dismiss();
          context.read<UserBloc>().add(const UserEvent.getLogedinUser());
          context.read<NotificationCubit>().getNotif();
          AutoRouter.of(context).replaceAll([const LayoutsRoute()]);
          LoadingDialog.showSuccess(message: state.message);
        } else if (state.status == AuthStatus.sendEmailForgotPassword) {
          LoadingDialog.dismiss();
          LoadingDialog.showSuccess(message: state.message);
          Navigator.pop(context);
        } else if (state.status == AuthStatus.loading) {
          LoadingDialog.show(message: 'Loading ...');
        }
      },
      child: SafeArea(
        child: Scaffold(
          backgroundColor: AppColors.bg200,
          resizeToAvoidBottomInset: false,
          body: Container(
            padding: EdgeInsets.fromLTRB(
                29, 29, 29, MediaQuery.of(context).viewInsets.bottom),
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
                        typeName: TextTypeName.caption1,
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
                    SizedBox(height: 32.h),
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
                              typeName: TextTypeName.caption1,
                              color: AppColors.textPrimary100,
                            ),
                          ],
                        ),
                        TextButton(
                          onPressed: () async {
                            await showDialog(
                              context: context,
                              builder: (context) {
                                return Dialog(
                                  child: Container(
                                    padding: defaultPadding,
                                    decoration: BoxDecoration(
                                      borderRadius: defaultRadius,
                                      color: AppColors.bg200,
                                    ),
                                    child: Form(
                                      key: _formForgotPassworKey,
                                      child: Column(
                                        mainAxisSize: MainAxisSize.min,
                                        crossAxisAlignment:
                                            CrossAxisAlignment.center,
                                        mainAxisAlignment:
                                            MainAxisAlignment.center,
                                        children: [
                                          IText.set(
                                            text: 'Reset Password ?',
                                            typeName: TextTypeName.headline3,
                                            styleName: TextStyleName.semiBold,
                                          ),
                                          IText.set(
                                            text:
                                                'Enter your email to reset your password.',
                                          ),
                                          const SpaceWidget(),
                                          SizedBox(
                                            height: 90.h,
                                            child: CustomTextField(
                                              showBorder: true,
                                              placeholder: 'Your Email',
                                              controller: emailForgotPassword,
                                              validator: (val) {
                                                if (val!.isEmpty) {
                                                  return 'Please fill out this field !';
                                                } else if (!EmailValidator
                                                    .validate(val)) {
                                                  return 'Invalid format email';
                                                }
                                                return null;
                                              },
                                            ),
                                          ),
                                          Row(
                                            children: [
                                              SizedBox(
                                                height: 40.h,
                                                child: ElevatedButton(
                                                  onPressed: () {
                                                    context
                                                        .read<AuthBloc>()
                                                        .add(
                                                          ForgotPassword(
                                                              emailForgotPassword
                                                                  .text),
                                                        );
                                                  },
                                                  child: const Text(
                                                    'Email Password Reset Link',
                                                  ),
                                                ),
                                              ),
                                              SizedBox(width: 8.w),
                                              Expanded(
                                                child: SizedBox(
                                                  height: 40.h,
                                                  child: ElevatedButton(
                                                    style: ElevatedButton
                                                        .styleFrom(
                                                      backgroundColor: AppColors
                                                          .secondary100,
                                                    ),
                                                    onPressed: () {
                                                      Navigator.pop(context);
                                                    },
                                                    child: const Text(
                                                      'Cancel',
                                                    ),
                                                  ),
                                                ),
                                              )
                                            ],
                                          )
                                        ],
                                      ),
                                    ),
                                  ),
                                );
                              },
                            );
                          },
                          child: IText.set(
                            text: 'Forgot Password ?',
                            styleName: TextStyleName.bold,
                            typeName: TextTypeName.caption1,
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
                          return BlocBuilder<AuthBloc, AuthState>(
                            builder: (context, state) {
                              return ElevatedButton(
                                onPressed: state.status == AuthStatus.loading
                                    ? () {}
                                    : () {
                                        if (!_formKey.currentState!
                                            .validate()) {
                                          return;
                                        }
                                        context.read<AuthBloc>().add(
                                              LoginEvent(
                                                LoginRequestParams(
                                                  email: emailController.text,
                                                  password:
                                                      passwordController.text,
                                                  deviceName: 'mobile',
                                                  isRememberMe:
                                                      rememberMe.value,
                                                ),
                                              ),
                                            );
                                      },
                                child: state.status == AuthStatus.loading
                                    ? const CircularProgressIndicator(
                                        color: AppColors.bg200,
                                      )
                                    : IText.set(
                                        text: 'Login',
                                        typeName: TextTypeName.headline3,
                                        color: AppColors.bg100,
                                      ),
                              );
                            },
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
                            typeName: TextTypeName.caption1,
                            color: AppColors.textPrimary100,
                          ),
                          TextButton(
                            onPressed: () {
                              AutoRouter.of(context)
                                  .push(const RegisterRoute());
                            },
                            child: IText.set(
                              text: 'Sign up',
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
    );
  }
}
