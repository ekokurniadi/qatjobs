import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:qatjobs/core/widget/custom_appbar_widget.dart';
import 'package:qatjobs/core/widget/pull_to_refresh_widget.dart';
import 'package:qatjobs/features/job/data/models/job_filter.codegen.dart';
import 'package:qatjobs/features/job/presentations/bloc/bloc/jobs_bloc.dart';
import 'package:qatjobs/features/job_category/domain/entities/job_category_entity.codegen.dart';
import 'package:qatjobs/features/job_category/presentations/bloc/job_category_bloc.dart';
import 'package:qatjobs/features/job_category/presentations/widgets/card_category.dart';
import 'package:qatjobs/features/layouts/presentations/cubit/bottom_nav_cubit.dart';
import 'package:zoom_tap_animation/zoom_tap_animation.dart';

class JobCategoryPage extends StatefulWidget {
  const JobCategoryPage({super.key});

  @override
  State<JobCategoryPage> createState() => _JobCategoryPageState();
}

class _JobCategoryPageState extends State<JobCategoryPage> {
  @override
  void initState() {
    context.read<JobCategoryBloc>().add(const JobCategoryEvent.started());
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: const CustomAppBar(
        title: 'Job Category',
        showLeading: true,
      ),
      body: PullToRefreshWidget(
        onRefresh: () async {
          context.read<JobCategoryBloc>().add(const JobCategoryEvent.started());
        },
        child: BlocBuilder<JobCategoryBloc, JobCategoryState>(
            builder: (context, state) {
          return ListView.separated(
            padding: EdgeInsets.all(16.w),
            shrinkWrap: true,
            itemCount: state.categories.length,
            itemBuilder: (context, index) {
              return ZoomTapAnimation(
                onTap: () {
                  Navigator.pop(context);
                  context.read<JobsBloc>().add(
                        JobsEvent.getJobs(
                          JobFilterModel(
                            jobCategoryId: state.categories[index].id,
                          ),
                          true,
                        ),
                      );
                  context.read<BottomNavCubit>().setSelectedMenuIndex(2);
                },
                child: CardCategory(
                  categoryModel: state.categories[index].toModel(),
                  isLoading: state.status == JobCategoryStatus.loading,
                ),
              );
            },
            separatorBuilder: (context, index) => SizedBox(
              height: 16.w,
            ),
          );
        }),
      ),
    );
  }
}
