import 'package:auto_route/auto_route.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:qatjobs/core/auto_route/auto_route.gr.dart';
import 'package:qatjobs/core/constant/assets_constant.dart';
import 'package:qatjobs/core/styles/color_name_style.dart';
import 'package:qatjobs/features/article/presentations/pages/article_list_page.dart';
import 'package:qatjobs/features/home/presentations/pages/home_page.dart';
import 'package:qatjobs/features/job/presentations/pages/job_page.dart';
import 'package:qatjobs/features/layouts/presentations/cubit/bottom_nav_cubit.dart';
import 'package:qatjobs/features/notification/presentations/pages/notification_page.dart';

class LayoutsPage extends StatefulWidget {
  const LayoutsPage({super.key});

  @override
  State<LayoutsPage> createState() => _LayoutsPageState();
}

class _LayoutsPageState extends State<LayoutsPage> {
  int selectedIndex = 0;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      extendBody: true,
      body: SafeArea(
        child: BlocBuilder<BottomNavCubit, BottomNavState>(
          builder: (context, state) {
            switch (state.selectedMenuIndex) {
              case 0:
                return const HomePage();
              case 1:
                return const ArticleListPage();
              case 2:
                return const JobPage();
              case 3:
                return const NotificationPage();
              default:
                return Container(
                  width: double.infinity,
                  height: double.infinity,
                  color: Colors.pink,
                );
            }
          },
        ),
      ),
      bottomNavigationBar: BlocBuilder<BottomNavCubit, BottomNavState>(
        builder: (context, state) {
          return BottomNavigationBar(
            currentIndex: state.selectedMenuIndex,
            type: BottomNavigationBarType.fixed,
            showSelectedLabels: true,
            showUnselectedLabels: true,
            selectedItemColor: AppColors.warning,
            unselectedItemColor: AppColors.neutral50,
            selectedFontSize: 12.sp,
            unselectedFontSize: 12.sp,
            onTap: (index) {
              if (index > 2 && state.user == null) {
                AutoRouter.of(context).push(const LoginRoute());
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
                      ? AppColors.warning
                      : AppColors.neutral50,
                ),
              ),
              BottomNavigationBarItem(
                label: 'Articles',
                icon: SvgPicture.asset(
                  AssetsConstant.svgAssetsBottomNavFeeds,
                  width: 28.w,
                  color: state.selectedMenuIndex == 1
                      ? AppColors.warning
                      : AppColors.neutral50,
                ),
              ),
              BottomNavigationBarItem(
                label: 'Jobs',
                icon: SvgPicture.asset(
                  AssetsConstant.svgAssetsJobs,
                  width: 28.w,
                  color: state.selectedMenuIndex == 2
                      ? AppColors.warning
                      : AppColors.neutral50,
                ),
              ),
              BottomNavigationBarItem(
                label: 'Notification',
                icon: SvgPicture.asset(
                  AssetsConstant.svgAssetsBottomNavNotification,
                  width: 28.w,
                  color: state.selectedMenuIndex == 3
                      ? AppColors.warning
                      : AppColors.neutral50,
                ),
              ),
              BottomNavigationBarItem(
                label: 'Profile',
                icon: SvgPicture.asset(
                  AssetsConstant.svgAssetsBottomNavProfile,
                  width: 28.w,
                  color: state.selectedMenuIndex == 4
                      ? AppColors.warning
                      : AppColors.neutral50,
                ),
              ),
            ],
          );
        },
      ),
    );
  }
}
