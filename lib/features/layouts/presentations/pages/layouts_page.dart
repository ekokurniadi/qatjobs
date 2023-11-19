import 'package:auto_route/auto_route.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:qatjobs/core/auto_route/auto_route.gr.dart';
import 'package:qatjobs/core/constant/app_constant.dart';
import 'package:qatjobs/core/constant/assets_constant.dart';
import 'package:qatjobs/core/helpers/global_helper.dart';
import 'package:qatjobs/core/styles/color_name_style.dart';
import 'package:qatjobs/features/article/presentations/pages/article_list_page.dart';
import 'package:qatjobs/features/home/presentations/pages/home_page.dart';
import 'package:qatjobs/features/job/data/models/job_filter.codegen.dart';
import 'package:qatjobs/features/job/presentations/bloc/bloc/jobs_bloc.dart';
import 'package:qatjobs/features/job/presentations/pages/jobs_page.dart';
import 'package:qatjobs/features/layouts/presentations/cubit/bottom_nav_cubit.dart';
import 'package:qatjobs/features/notification/presentations/cubit/notification_cubit.dart';
import 'package:qatjobs/features/notification/presentations/pages/notification_page.dart';
import 'package:qatjobs/features/profile/candidate/presentations/pages/candidate_profile_page.dart';
import 'package:qatjobs/features/profile/employer/presentations/pages/employer_page.dart';
import 'package:qatjobs/features/users/presentations/bloc/user_bloc.dart';

class LayoutsPage extends StatefulWidget {
  const LayoutsPage({super.key});

  @override
  State<LayoutsPage> createState() => _LayoutsPageState();
}

class _LayoutsPageState extends State<LayoutsPage> {
  int selectedIndex = 0;

  @override
  void initState() {
    context.read<UserBloc>().add(const UserEvent.getLogedinUser());
    context.read<NotificationCubit>().getNotif();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      extendBody: true,
      body: SafeArea(
        child: BlocBuilder<UserBloc, UserState>(builder: (context, userState) {
          return BlocBuilder<BottomNavCubit, BottomNavState>(
            builder: (context, state) {
              switch (state.selectedMenuIndex) {
                case 0:
                  return const HomePage();
                case 1:
                  return const ArticleListPage();
                case 2:
                  return const JobsPage();
                case 3:
                  return const NotificationPage();
                case 4:
                  if (!GlobalHelper.isEmpty(userState.user)) {
                    if (userState.user?.roles?.first.name.toLowerCase() ==
                        AppConstant.roleCandidate) {
                      return const CandidateProfilePage();
                    } else {
                      return const EmployerPage();
                    }
                  }
                  return const SizedBox();
                default:
                  return Container(
                    width: double.infinity,
                    height: double.infinity,
                    color: Colors.pink,
                  );
              }
            },
          );
        }),
      ),
      bottomNavigationBar: BlocBuilder<BottomNavCubit, BottomNavState>(
        builder: (context, state) {
          return BlocBuilder<UserBloc, UserState>(
            builder: (context, userState) {
              return BottomNavigationBar(
                currentIndex: state.selectedMenuIndex,
                type: BottomNavigationBarType.fixed,
                showSelectedLabels: true,
                showUnselectedLabels: true,
                selectedItemColor: AppColors.primary,
                unselectedItemColor: AppColors.neutral50,
                selectedFontSize: 12.sp,
                unselectedFontSize: 12.sp,
                onTap: (index) {
                  if (!GlobalHelper.isEmpty(userState.user)) {
                    context.read<NotificationCubit>().getNotif();
                  }
                  if (index > 2 && GlobalHelper.isEmpty(userState.user)) {
                    AutoRouter.of(context).push(const LoginRoute());
                  } else if (index == 2) {
                    context.read<JobsBloc>().add(
                          JobsEvent.getJobs(
                            JobFilterModel(),
                            false,
                          ),
                        );
                    context.read<BottomNavCubit>().setSelectedMenuIndex(index);
                  } else {
                    context.read<BottomNavCubit>().setSelectedMenuIndex(index);
                  }
                },
                items: [
                  BottomNavigationBarItem(
                    label: 'Home',
                    icon: SvgPicture.asset(
                      AssetsConstant.svgAssetsBottomNavHome,
                      width: 28.w,
                      color: state.selectedMenuIndex == 0
                          ? AppColors.primary
                          : AppColors.neutral50,
                    ),
                  ),
                  BottomNavigationBarItem(
                    label: 'Articles',
                    icon: SvgPicture.asset(
                      AssetsConstant.svgAssetsBottomNavFeeds,
                      width: 28.w,
                      color: state.selectedMenuIndex == 1
                          ? AppColors.primary
                          : AppColors.neutral50,
                    ),
                  ),
                  BottomNavigationBarItem(
                    label: 'Jobs',
                    icon: SvgPicture.asset(
                      AssetsConstant.svgAssetsJobs,
                      width: 28.w,
                      color: state.selectedMenuIndex == 2
                          ? AppColors.primary
                          : AppColors.neutral50,
                    ),
                  ),
                  BottomNavigationBarItem(
                    label: 'Notification',
                    icon: BlocBuilder<NotificationCubit, NotificationState>(
                      builder: (context, nState) {
                        return Stack(
                          children: [
                            if (nState.notifications.isNotEmpty &&
                                nState.notifications.any(
                                  (element) =>
                                      element.userId == userState.user?.id &&
                                      element.readAt == null,
                                ))
                              Positioned(
                                left: 1,
                                child: Icon(
                                  Icons.circle,
                                  color: AppColors.danger100,
                                  size: 10.sp,
                                ),
                              ),
                            SvgPicture.asset(
                              AssetsConstant.svgAssetsBottomNavNotification,
                              width: 28.w,
                              color: state.selectedMenuIndex == 3
                                  ? AppColors.primary
                                  : AppColors.neutral50,
                            ),
                          ],
                        );
                      },
                    ),
                  ),
                  BottomNavigationBarItem(
                    label: 'Account',
                    icon: SvgPicture.asset(
                      AssetsConstant.svgAssetsBottomNavProfile,
                      width: 28.w,
                      color: state.selectedMenuIndex == 4
                          ? AppColors.primary
                          : AppColors.neutral50,
                    ),
                  ),
                ],
              );
            },
          );
        },
      ),
    );
  }
}
