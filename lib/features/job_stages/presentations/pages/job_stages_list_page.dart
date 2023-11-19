import 'package:auto_route/auto_route.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/svg.dart';
import 'package:qatjobs/core/auto_route/auto_route.gr.dart';
import 'package:qatjobs/core/constant/assets_constant.dart';
import 'package:qatjobs/core/helpers/html_parse_helper.dart';
import 'package:qatjobs/core/styles/color_name_style.dart';
import 'package:qatjobs/core/styles/resolution_style.dart';
import 'package:qatjobs/core/styles/text_name_style.dart';
import 'package:qatjobs/core/widget/confirm_dialog_bottom_sheet.dart';
import 'package:qatjobs/core/widget/custom_appbar_widget.dart';
import 'package:qatjobs/core/widget/loading_dialog_widget.dart';
import 'package:qatjobs/core/widget/vertical_space_widget.dart';
import 'package:qatjobs/features/job_stages/presentations/cubit/job_stages_cubit.dart';
import 'package:zoom_tap_animation/zoom_tap_animation.dart';

class JobStagesListPage extends StatefulWidget {
  const JobStagesListPage({
    super.key,
    this.isAsOption = false,
  });
  final bool isAsOption;

  @override
  State<JobStagesListPage> createState() => _JobStagesListPageState();
}

class _JobStagesListPageState extends State<JobStagesListPage> {
  @override
  void initState() {
    context.read<JobStagesCubit>().get();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.bg300,
      appBar: const CustomAppBar(
        title: 'Job Stages',
        showLeading: true,
      ),
      body: BlocListener<JobStagesCubit, JobStagesState>(
        listener: (context, state) {
          if (state.status == JobStagesStatus.failure) {
            LoadingDialog.dismiss();
            LoadingDialog.showError(message: state.message);
          } else if (state.status == JobStagesStatus.loading) {
            LoadingDialog.show(message: 'Loading ...');
          } else if (state.status == JobStagesStatus.deleted) {
            LoadingDialog.dismiss();
            LoadingDialog.showSuccess(message: state.message);
            Future.delayed(const Duration(milliseconds: 1000), () {
              context.read<JobStagesCubit>().get();
            });
          } else {
            LoadingDialog.dismiss();
          }
        },
        child: BlocBuilder<JobStagesCubit, JobStagesState>(
          builder: (context, state) {
            return Column(
              children: [
                SizedBox(
                  width: double.infinity,
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.end,
                    children: [
                      InkWell(
                        onTap: () {
                          AutoRouter.of(context).push(FormJobStagesRoute());
                        },
                        child: ZoomTapAnimation(
                          child: Container(
                            padding: defaultPadding,
                            child: Row(
                              children: [
                                IText.set(
                                  text: 'Add Job Stages',
                                  color: AppColors.warning,
                                  typeName: TextTypeName.caption1,
                                  styleName: TextStyleName.semiBold,
                                ),
                                SizedBox(width: 8.w),
                                Container(
                                  width: 24.w,
                                  height: 24.w,
                                  decoration: BoxDecoration(
                                    shape: BoxShape.circle,
                                    boxShadow: AppColors.defaultShadow,
                                    color: AppColors.warning50,
                                  ),
                                  child: Icon(
                                    Icons.add,
                                    size: 14.sp,
                                    color: AppColors.warning,
                                  ),
                                )
                              ],
                            ),
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
                Flexible(
                  child: state.stages.isEmpty
                      ? Column(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            SvgPicture.asset(AssetsConstant.illusJobEmpty),
                            const SpaceWidget(),
                            IText.set(
                              text: 'Job Stages is empty',
                              textAlign: TextAlign.left,
                              styleName: TextStyleName.medium,
                              typeName: TextTypeName.large,
                              color: AppColors.textPrimary,
                              lineHeight: 1.2.h,
                            ),
                            const SpaceWidget(),
                            IText.set(
                              text: 'Please add your job stages first',
                              textAlign: TextAlign.left,
                              styleName: TextStyleName.regular,
                              typeName: TextTypeName.caption1,
                              color: AppColors.textPrimary100,
                            )
                          ],
                        )
                      : ListView.separated(
                          separatorBuilder: (context, index) =>
                              const SpaceWidget(),
                          shrinkWrap: true,
                          itemCount: state.stages.length,
                          itemBuilder: (context, index) {
                            return InkWell(
                              onTap: widget.isAsOption
                                  ? () {
                                      Navigator.pop(
                                          context, state.stages[index].id);
                                    }
                                  : null,
                              child: Container(
                                margin: EdgeInsets.symmetric(horizontal: 16.w),
                                padding: defaultPadding,
                                decoration: BoxDecoration(
                                  color: AppColors.bg200,
                                  borderRadius: defaultRadius,
                                  boxShadow: AppColors.defaultShadow,
                                ),
                                child: Row(
                                  mainAxisAlignment:
                                      MainAxisAlignment.spaceBetween,
                                  crossAxisAlignment: CrossAxisAlignment.center,
                                  children: [
                                    Expanded(
                                      child: Column(
                                        crossAxisAlignment:
                                            CrossAxisAlignment.start,
                                        children: [
                                          IText.set(
                                            text: state.stages[index].name,
                                            styleName: TextStyleName.semiBold,
                                            color: AppColors.primary,
                                          ),
                                          IText.set(
                                            text: HtmlParseHelper
                                                .stripHtmlIfNeeded(
                                              state.stages[index].description,
                                            ),
                                          )
                                        ],
                                      ),
                                    ),
                                    Row(
                                      children: [
                                        IconButton(
                                          onPressed: () {
                                            AutoRouter.of(context).push(
                                              FormJobStagesRoute(
                                                isEdit: true,
                                                jobStages: state.stages[index],
                                              ),
                                            );
                                          },
                                          icon: SvgPicture.asset(
                                            AssetsConstant.svgAssetsEdit,
                                            color: AppColors.warning,
                                          ),
                                        ),
                                        IconButton(
                                          onPressed: () async {
                                            await showModalBottomSheet(
                                              shape:
                                                  const RoundedRectangleBorder(
                                                borderRadius: BorderRadius.only(
                                                  topRight: Radius.circular(32),
                                                  topLeft: Radius.circular(32),
                                                ),
                                              ),
                                              context: context,
                                              builder: (context) {
                                                return ConfirmDialogBottomSheet(
                                                  title: 'Remove Job Stage ?',
                                                  caption:
                                                      'Are you sure you want to delete ${state.stages[index].name}?',
                                                  onTapCancel: () =>
                                                      Navigator.pop(context),
                                                  onTapContinue: () {
                                                    Navigator.pop(context);
                                                    context
                                                        .read<JobStagesCubit>()
                                                        .delete(
                                                          state
                                                              .stages[index].id,
                                                        );
                                                  },
                                                );
                                              },
                                            );
                                          },
                                          icon: SvgPicture.asset(
                                            AssetsConstant.svgAssetsDelete,
                                            color: AppColors.danger100,
                                          ),
                                        )
                                      ],
                                    )
                                  ],
                                ),
                              ),
                            );
                          },
                        ),
                ),
              ],
            );
          },
        ),
      ),
    );
  }
}
