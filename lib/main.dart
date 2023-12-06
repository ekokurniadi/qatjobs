import 'package:auto_route/auto_route.dart';
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
import 'package:qatjobs/core/styles/resolution_style.dart';
import 'package:qatjobs/features/auth/bloc/auth_bloc.dart';
import 'package:qatjobs/features/company/presentations/bloc/company_bloc.dart';
import 'package:qatjobs/features/connectivity/presentations/bloc/connectivity_bloc.dart';
import 'package:qatjobs/features/home/presentations/bloc/home_bloc.dart';
import 'package:qatjobs/features/job/presentations/bloc/bloc/jobs_bloc.dart';
import 'package:qatjobs/features/job_category/presentations/bloc/job_category_bloc.dart';
import 'package:qatjobs/features/job_stages/presentations/cubit/job_stages_cubit.dart';
import 'package:qatjobs/features/layouts/presentations/cubit/bottom_nav_cubit.dart';
import 'package:qatjobs/features/notification/presentations/cubit/notification_cubit.dart';
import 'package:qatjobs/features/profile/candidate/presentations/bloc/profile_candidate_bloc.dart';
import 'package:qatjobs/features/profile/employer/presentations/cubit/employer_cubit.dart';
import 'package:qatjobs/features/slots/presentations/cubit/slots_cubit.dart';
import 'package:qatjobs/features/users/presentations/bloc/user_bloc.dart';
import 'package:qatjobs/injector.dart';
import 'package:responsive_framework/responsive_framework.dart';

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();

  await configureDependencies(environment: Environment.dev);
  await App.init();

  Bloc.observer = BlocEventLogger();
  SystemChrome.setSystemUIOverlayStyle(
    const SystemUiOverlayStyle(
      statusBarColor: Colors.transparent,
    ),
  );

  runApp(const MainApp());
}

class MainApp extends StatefulWidget {
  const MainApp({super.key});

  @override
  State<MainApp> createState() => _MainAppState();
}

class _MainAppState extends State<MainApp> {
  final _appRouter = AppRouter();
  final GlobalKey<ScaffoldState> _mainNavigatorKey = GlobalKey<ScaffoldState>();

  @override
  void dispose() {
    getIt<ConnectivityBloc>().close();
    super.dispose();
  }

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
        BlocProvider(
          create: (context) => getIt<HomeBloc>(),
        ),
        BlocProvider(
          create: (context) => getIt<ConnectivityBloc>(),
        ),
        BlocProvider(
          create: (context) => getIt<UserBloc>(),
        ),
        BlocProvider(
          create: (context) => getIt<ProfileCandidateBloc>(),
        ),
        BlocProvider(
          create: (context) => getIt<CompanyBloc>(),
        ),
        BlocProvider(
          create: (context) => getIt<JobCategoryBloc>(),
        ),
        BlocProvider(
          create: (context) => getIt<EmployerCubit>(),
        ),
        BlocProvider(
          create: (context) => getIt<JobStagesCubit>(),
        ),
        BlocProvider(
          create: (context) => getIt<NotificationCubit>(),
        ),
        BlocProvider(
          create: (context) => getIt<SlotsCubit>(),
        ),
        BlocProvider(
          create: (context) => getIt<AuthBloc>(),
        ),
      ],
      child: BlocListener<ConnectivityBloc, ConnectivityState>(
        listener: (context, state) {
          if (!state.internetConnectionStatus) {
            showToast(
              'Device not connected to internet',
              context: _mainNavigatorKey.currentContext,
            );
          }
        },
        child: ScreenUtilInit(
          designSize: Size(
            MediaQuery.sizeOf(context).width,
            MediaQuery.sizeOf(context).height,
          ),
          builder: (context, child) {
            double scale = 126 / MediaQuery.of(context).size.shortestSide;
            return OKToast(
              child: MaterialApp.router(
                key: _mainNavigatorKey,
                builder: EasyLoading.init(
                  builder: (context, widget) => ResponsiveWrapper.builder(
                    ClampingScrollWrapper(child: widget!),
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
                routerDelegate: _appRouter.delegate(
                  navigatorObservers: () => [AutoRouteObserver()],
                ),
                routeInformationParser: _appRouter.defaultRouteParser(),
                theme: ThemeData(
                  useMaterial3: false,
                  pageTransitionsTheme: const PageTransitionsTheme(
                    builders: {
                      TargetPlatform.android: CupertinoPageTransitionsBuilder(),
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
                  radioTheme: const RadioThemeData(
                    fillColor: MaterialStatePropertyAll(AppColors.warning),
                  ),
                  checkboxTheme: const CheckboxThemeData(
                    fillColor: MaterialStatePropertyAll(AppColors.warning),
                  ),
                  datePickerTheme: DatePickerThemeData(
                    shape: RoundedRectangleBorder(borderRadius: defaultRadius),
                    headerBackgroundColor: AppColors.primary,
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
                  appBarTheme: const AppBarTheme(
                    iconTheme: IconThemeData(color: AppColors.textPrimary100),
                  ),
                ),
              ),
            );
          },
        ),
      ),
    );
  }
}
