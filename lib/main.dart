import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_easyloading/flutter_easyloading.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:injectable/injectable.dart';
import 'package:oktoast/oktoast.dart';
import 'package:qatjobs/app.dart';
import 'package:qatjobs/core/auto_route/auto_route.gr.dart';
import 'package:qatjobs/core/logger/bloc_event_logger.dart';
import 'package:qatjobs/core/styles/color_name_style.dart';
import 'package:qatjobs/features/job/presentations/bloc/bloc/jobs_bloc.dart';
import 'package:qatjobs/features/layouts/presentations/cubit/bottom_nav_cubit.dart';
import 'package:qatjobs/injector.dart';
import 'package:responsive_framework/responsive_framework.dart';

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();

  await configureDependencies(environment: Environment.dev);
  await App.init();

  Bloc.observer = BlocEventLogger();
  SystemChrome.setSystemUIOverlayStyle(
    const SystemUiOverlayStyle(
      statusBarColor: AppColors.secondary,
    ),
  );
  runApp(MainApp());
}

class MainApp extends StatelessWidget {
  MainApp({super.key});

  final _appRouter = AppRouter();

  @override
  Widget build(BuildContext context) {
    return MultiBlocProvider(
      providers: [
        BlocProvider(
          create: (context) => getIt<BottomNavCubit>(),
        ),
        BlocProvider(
          create: (context) => getIt<JobsBloc>(),
        ),
      ],
      child: ScreenUtilInit(
        designSize: Size(
          MediaQuery.sizeOf(context).width,
          MediaQuery.sizeOf(context).height,
        ),
        builder: (context, child) {
          double scale = 126 / MediaQuery.of(context).size.shortestSide;
          return OKToast(
            child: MaterialApp.router(
              builder: EasyLoading.init(
                builder: (context, widget) => ResponsiveWrapper.builder(
                  BouncingScrollWrapper(child: widget!),
                  defaultScale: true,
                  background: const ColoredBox(
                    color: Color(0xFFF5F5F5),
                  ),
                  breakpoints: [
                    ResponsiveBreakpoint.autoScale(
                      480,
                      name: MOBILE,
                      scaleFactor: scale,
                    ),
                    ResponsiveBreakpoint.autoScale(450,
                        name: MOBILE, scaleFactor: scale),
                    const ResponsiveBreakpoint.autoScale(600),
                    const ResponsiveBreakpoint.autoScale(
                      800,
                      name: TABLET,
                    ),
                    const ResponsiveBreakpoint.autoScale(1000, name: TABLET),
                    const ResponsiveBreakpoint.autoScale(1200, name: DESKTOP),
                    const ResponsiveBreakpoint.autoScale(2460, name: "4K"),
                  ],
                ),
              ),
              routerDelegate: _appRouter.delegate(),
              routeInformationParser: _appRouter.defaultRouteParser(),
              theme: ThemeData(
                pageTransitionsTheme: const PageTransitionsTheme(
                  builders: {
                    TargetPlatform.android: ZoomPageTransitionsBuilder(),
                    TargetPlatform.iOS: CupertinoPageTransitionsBuilder(),
                  },
                ),
                shadowColor: AppColors.neutral100,
                fontFamily: 'Poppins',
                textButtonTheme: TextButtonThemeData(
                  style: TextButton.styleFrom(
                    foregroundColor: AppColors.primary,
                    textStyle: TextStyle(
                      fontSize: 14.w,
                      fontWeight: FontWeight.w600,
                    ),
                  ),
                ),
                dropdownMenuTheme: DropdownMenuThemeData(
                  inputDecorationTheme: InputDecorationTheme(
                    labelStyle: TextStyle(
                      color: AppColors.textPrimary,
                      fontSize: 14.sp,
                      fontWeight: FontWeight.w400,
                    ),
                    hintStyle: TextStyle(
                      fontSize: 14.w,
                      fontWeight: FontWeight.w400,
                      color: AppColors.textPrimary,
                    ),
                    enabledBorder: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(8.r),
                      borderSide: const BorderSide(
                        color: AppColors.neutral100,
                      ),
                    ),
                    border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(8.r),
                      borderSide: const BorderSide(
                        color: AppColors.neutral100,
                      ),
                    ),
                    focusedBorder: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(8.r),
                      borderSide: const BorderSide(
                        color: AppColors.neutral100,
                      ),
                    ),
                    disabledBorder: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(8.r),
                      borderSide: const BorderSide(
                        color: AppColors.neutral100,
                      ),
                    ),
                  ),
                ),
                inputDecorationTheme: InputDecorationTheme(
                  labelStyle: TextStyle(
                    color: AppColors.textPrimary,
                    fontSize: 14.sp,
                    fontWeight: FontWeight.w400,
                  ),
                  hintStyle: TextStyle(
                    fontSize: 14.w,
                    fontWeight: FontWeight.w400,
                    color: AppColors.textPrimary,
                  ),
                  enabledBorder: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(8.r),
                    borderSide: const BorderSide(
                      color: AppColors.neutral100,
                    ),
                  ),
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(8.r),
                    borderSide: const BorderSide(
                      color: AppColors.neutral100,
                    ),
                  ),
                  focusedBorder: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(8.r),
                    borderSide: const BorderSide(
                      color: AppColors.neutral100,
                    ),
                  ),
                ),
                elevatedButtonTheme: ElevatedButtonThemeData(
                  style: ElevatedButton.styleFrom(
                    backgroundColor: AppColors.primary,
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(4.r),
                    ),
                    fixedSize: Size(double.infinity, 36.h),
                    padding: EdgeInsets.all(8.w),
                  ),
                ),
                highlightColor: Colors.transparent,
              ),
            ),
          );
        },
      ),
    );
  }
}
