import 'dart:async';

import 'package:auto_route/auto_route.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:lazy_load_scrollview/lazy_load_scrollview.dart';
import 'package:qatjobs/core/auto_route/auto_route.gr.dart';
import 'package:qatjobs/core/constant/assets_constant.dart';
import 'package:qatjobs/core/constant/global_constant.dart';
import 'package:qatjobs/core/helpers/date_helper.dart';
import 'package:qatjobs/core/styles/color_name_style.dart';
import 'package:qatjobs/core/styles/resolution_style.dart';
import 'package:qatjobs/core/styles/text_name_style.dart';
import 'package:qatjobs/core/widget/confirm_dialog_bottom_sheet.dart';
import 'package:qatjobs/core/widget/custom_appbar_widget.dart';
import 'package:qatjobs/core/widget/custom_cached_image_network.dart';
import 'package:qatjobs/core/widget/custom_text_field.dart';
import 'package:qatjobs/core/widget/loading_dialog_widget.dart';
import 'package:qatjobs/core/widget/pull_to_refresh_widget.dart';
import 'package:qatjobs/core/widget/vertical_space_widget.dart';
import 'package:qatjobs/features/profile/employer/data/models/job_request_params.codegen.dart';
import 'package:qatjobs/features/profile/employer/domain/usecases/update_job_status_usecase.dart';
import 'package:qatjobs/features/profile/employer/presentations/cubit/employer_cubit.dart';

class EmployerJobPage extends StatefulWidget {
  const EmployerJobPage({super.key});

  @override
  State<EmployerJobPage> createState() => _EmployerJobPageState();
}

class _EmployerJobPageState extends State<EmployerJobPage> {
  @override
  void initState() {
    context.read<EmployerCubit>().getJobs(
          JobRequestParams(page: 1),
          isReset: true,
        );
    super.initState();
  }

  Timer? _debounce;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.bg300,
      appBar: const CustomAppBar(
        title: 'Jobs',
        showLeading: true,
      ),
      body: PullToRefreshWidget(
        onRefresh: () async {
          context.read<EmployerCubit>().getJobs(
                JobRequestParams(page: 1),
                isReset: true,
              );
        },
        child: BlocListener<EmployerCubit, EmployerState>(
          listener: (context, state) {
            if (state.status == EmployerStatus.updateJobStatus) {
              LoadingDialog.dismiss();
              LoadingDialog.showSuccess(message: state.message);
              context.read<EmployerCubit>().getJobs(
                    JobRequestParams(),
                    isReset: true,
                  );
            } else if (state.status == EmployerStatus.loading) {
              LoadingDialog.show(message: 'Loading ...');
            } else if (state.status == EmployerStatus.failure) {
              LoadingDialog.dismiss();
              LoadingDialog.showError(message: state.message);
            } else {
              LoadingDialog.dismiss();
            }
          },
          child: Padding(
            padding: defaultPadding,
            child: Column(
              children: [
                CustomTextField(
                  placeholder: 'Search Job',
                  onChange: (val) {
                    if (val.isEmpty) {
                      context.read<EmployerCubit>().getJobs(
                            JobRequestParams(page: 1),
                            isReset: true,
                          );
                    } else {
                      context.read<EmployerCubit>().searchJobs(
                            JobRequestParams(
                              q: val,
                              perPage: null,
                              page: 1,
                            ),
                            isReset: true,
                          );
                    }
                  },
                ),
                const SpaceWidget(),
                Flexible(
                  child: BlocBuilder<EmployerCubit, EmployerState>(
                    builder: (context, state) {
                      return state.jobs.isNotEmpty
                          ? LazyLoadScrollView(
                              onEndOfPage: () {
                                if (!state.hasReachMax) {
                                  context.read<EmployerCubit>().getJobs(
                                        JobRequestParams(
                                          page: state.currentPage + 1,
                                        ),
                                      );
                                }
                              },
                              child: ListView.builder(
                                shrinkWrap: true,
                                itemCount: state.jobs.length,
                                itemBuilder: (context, index) {
                                  final data = state.jobs[index];
                                  return Container(
                                    width: double.infinity,
                                    padding: defaultPadding,
                                    margin: EdgeInsets.only(bottom: 16.h),
                                    decoration: BoxDecoration(
                                      borderRadius: BorderRadius.circular(8.r),
                                      color: AppColors.bg200,
                                      boxShadow: AppColors.defaultShadow,
                                    ),
                                    child: Column(
                                      crossAxisAlignment:
                                          CrossAxisAlignment.start,
                                      children: [
                                        SizedBox(
                                          width: double.infinity,
                                          child: Row(
                                            mainAxisAlignment:
                                                MainAxisAlignment.spaceBetween,
                                            children: [
                                              Container(
                                                width: 40.w,
                                                height: 40.w,
                                                decoration: const BoxDecoration(
                                                    shape: BoxShape.circle),
                                                child: ClipOval(
                                                  child: CustomImageNetwork(
                                                    imageUrl: data.company
                                                            ?.companyUrl ??
                                                        '',
                                                    customErrorWidget:
                                                        SvgPicture.asset(
                                                      AssetsConstant
                                                          .svgAssetsPicture,
                                                    ),
                                                  ),
                                                ),
                                              ),
                                              PopupMenuButton(
                                                itemBuilder: (context) {
                                                  return [
                                                    if (data.status ==
                                                            GlobalConstant
                                                                .jobStatusDraft ||
                                                        data.status ==
                                                            GlobalConstant
                                                                .jobStatusPause) ...[
                                                      PopupMenuItem(
                                                        value: 'edit',
                                                        child: IText.set(
                                                          text: 'Edit',
                                                          textAlign:
                                                              TextAlign.left,
                                                          styleName:
                                                              TextStyleName
                                                                  .semiBold,
                                                          typeName: TextTypeName
                                                              .headline3,
                                                          color: AppColors
                                                              .textPrimary100,
                                                        ),
                                                      ),
                                                    ] else if (data.status ==
                                                        GlobalConstant
                                                            .jobStatusLive) ...[
                                                      PopupMenuItem(
                                                        value: 'applications',
                                                        child: IText.set(
                                                          text: 'Applications',
                                                          textAlign:
                                                              TextAlign.left,
                                                          styleName:
                                                              TextStyleName
                                                                  .semiBold,
                                                          typeName: TextTypeName
                                                              .headline3,
                                                          color: AppColors
                                                              .textPrimary100,
                                                        ),
                                                      ),
                                                      PopupMenuItem(
                                                        value: 'edit',
                                                        child: IText.set(
                                                          text: 'Edit',
                                                          textAlign:
                                                              TextAlign.left,
                                                          styleName:
                                                              TextStyleName
                                                                  .semiBold,
                                                          typeName: TextTypeName
                                                              .headline3,
                                                          color: AppColors
                                                              .textPrimary100,
                                                        ),
                                                      ),
                                                    ],
                                                    PopupMenuItem(
                                                      value: 'delete',
                                                      child: IText.set(
                                                        text: 'Delete',
                                                        textAlign:
                                                            TextAlign.left,
                                                        styleName: TextStyleName
                                                            .semiBold,
                                                        typeName: TextTypeName
                                                            .headline3,
                                                        color: AppColors
                                                            .textPrimary100,
                                                      ),
                                                    ),
                                                  ];
                                                },
                                                icon:
                                                    const Icon(Icons.more_vert),
                                                onSelected: (value) async {
                                                  switch (value) {
                                                    case 'edit':
                                                      AutoRouter.of(context)
                                                          .push(
                                                        UpdateJobRoute(
                                                          job: data,
                                                        ),
                                                      );

                                                      break;
                                                    case 'delete':
                                                      await showModalBottomSheet(
                                                        shape:
                                                            const RoundedRectangleBorder(
                                                          borderRadius:
                                                              BorderRadius.only(
                                                            topRight:
                                                                Radius.circular(
                                                                    32),
                                                            topLeft:
                                                                Radius.circular(
                                                                    32),
                                                          ),
                                                        ),
                                                        context: context,
                                                        builder: (context) {
                                                          return ConfirmDialogBottomSheet(
                                                            title:
                                                                'Remove Favorite Job ?',
                                                            caption:
                                                                'Are you sure you want to delete ${data.jobTitle}?',
                                                            onTapCancel: () =>
                                                                Navigator.pop(
                                                                    context),
                                                            onTapContinue: () {
                                                              Navigator.pop(
                                                                  context);
                                                            },
                                                          );
                                                        },
                                                      );
                                                      break;
                                                    default:
                                                      break;
                                                  }
                                                },
                                              )
                                            ],
                                          ),
                                        ),
                                        SizedBox(
                                          width: double.infinity,
                                          child: IText.set(
                                            text: data.jobTitle ?? '-',
                                            textAlign: TextAlign.left,
                                            styleName: TextStyleName.semiBold,
                                            typeName: TextTypeName.headline3,
                                            color: AppColors.textPrimary100,
                                          ),
                                        ),
                                        SizedBox(
                                          width: double.infinity,
                                          child: Row(
                                            children: [
                                              IText.set(
                                                text: 'Applied : ',
                                                textAlign: TextAlign.left,
                                                styleName:
                                                    TextStyleName.regular,
                                                typeName: TextTypeName.caption1,
                                                color: AppColors.textPrimary100,
                                              ),
                                              IText.set(
                                                text: (data.appliedJobs ?? [])
                                                    .length
                                                    .toString(),
                                                textAlign: TextAlign.left,
                                                styleName:
                                                    TextStyleName.regular,
                                                typeName: TextTypeName.caption1,
                                                color: AppColors.textPrimary100,
                                              ),
                                            ],
                                          ),
                                        ),
                                        const SpaceWidget(),
                                        SizedBox(
                                          width: double.infinity,
                                          child: Row(
                                            mainAxisAlignment:
                                                MainAxisAlignment.start,
                                            children: [
                                              IText.set(
                                                text: 'Status : ',
                                                textAlign: TextAlign.left,
                                                styleName:
                                                    TextStyleName.regular,
                                                typeName: TextTypeName.caption1,
                                                color: AppColors.textPrimary100,
                                              ),
                                              if (data.status !=
                                                      GlobalConstant
                                                          .jobStatusClose &&
                                                  data.status !=
                                                      GlobalConstant
                                                          .jobStatusDraft) ...[
                                                SizedBox(
                                                  width: 100.w,
                                                  child: PopupMenuButton(
                                                    icon: Row(
                                                      children: [
                                                        IText.set(
                                                          text: GlobalConstant
                                                              .getJobStatus(
                                                                  data.status ??
                                                                      0),
                                                          textAlign:
                                                              TextAlign.left,
                                                          styleName:
                                                              TextStyleName
                                                                  .regular,
                                                          typeName: TextTypeName
                                                              .caption1,
                                                          color: AppColors
                                                              .textPrimary100,
                                                        ),
                                                        const Icon(Icons
                                                            .arrow_drop_down)
                                                      ],
                                                    ),
                                                    onSelected: (value) async {
                                                      await showModalBottomSheet(
                                                        shape:
                                                            const RoundedRectangleBorder(
                                                          borderRadius:
                                                              BorderRadius.only(
                                                            topRight:
                                                                Radius.circular(
                                                                    32),
                                                            topLeft:
                                                                Radius.circular(
                                                                    32),
                                                          ),
                                                        ),
                                                        context: context,
                                                        builder: (context) {
                                                          return ConfirmDialogBottomSheet(
                                                            title:
                                                                'Change Job Status ?',
                                                            caption:
                                                                'Are you sure to change ${data.jobTitle} status to ${GlobalConstant.getJobStatus(value)}?',
                                                            onTapCancel: () =>
                                                                Navigator.pop(
                                                                    context),
                                                            onTapContinue: () {
                                                              Navigator.pop(
                                                                  context);
                                                              context
                                                                  .read<
                                                                      EmployerCubit>()
                                                                  .updateJobStatus(
                                                                    UpdateJobStatusParams(
                                                                      jobId:
                                                                          data.id ??
                                                                              0,
                                                                      status:
                                                                          value,
                                                                    ),
                                                                  );
                                                            },
                                                          );
                                                        },
                                                      );
                                                    },
                                                    itemBuilder: (context) {
                                                      return [
                                                        PopupMenuItem(
                                                          value: GlobalConstant
                                                              .jobStatusLive,
                                                          child: IText.set(
                                                            text: 'Live',
                                                            textAlign:
                                                                TextAlign.left,
                                                            styleName:
                                                                TextStyleName
                                                                    .regular,
                                                            typeName:
                                                                TextTypeName
                                                                    .caption1,
                                                            color: AppColors
                                                                .textPrimary100,
                                                          ),
                                                        ),
                                                        PopupMenuItem(
                                                          value: GlobalConstant
                                                              .jobStatusPause,
                                                          child: IText.set(
                                                            text: 'Pause',
                                                            textAlign:
                                                                TextAlign.left,
                                                            styleName:
                                                                TextStyleName
                                                                    .regular,
                                                            typeName:
                                                                TextTypeName
                                                                    .caption1,
                                                            color: AppColors
                                                                .textPrimary100,
                                                          ),
                                                        ),
                                                        PopupMenuItem(
                                                          value: GlobalConstant
                                                              .jobStatusClose,
                                                          child: IText.set(
                                                            text: 'Close',
                                                            textAlign:
                                                                TextAlign.left,
                                                            styleName:
                                                                TextStyleName
                                                                    .regular,
                                                            typeName:
                                                                TextTypeName
                                                                    .caption1,
                                                            color: AppColors
                                                                .textPrimary100,
                                                          ),
                                                        ),
                                                      ];
                                                    },
                                                  ),
                                                ),
                                              ] else ...[
                                                IText.set(
                                                  text: GlobalConstant
                                                      .getJobStatus(
                                                          data.status ?? 0),
                                                  textAlign: TextAlign.left,
                                                  styleName:
                                                      TextStyleName.regular,
                                                  typeName:
                                                      TextTypeName.caption1,
                                                  color:
                                                      AppColors.textPrimary100,
                                                ),
                                              ],
                                            ],
                                          ),
                                        ),
                                        const Divider(),
                                        const SpaceWidget(),
                                        SizedBox(
                                          width: double.infinity,
                                          child: Row(
                                            children: [
                                              IText.set(
                                                text: 'Submission Status : ',
                                                textAlign: TextAlign.left,
                                                styleName:
                                                    TextStyleName.regular,
                                                typeName: TextTypeName.caption1,
                                                color: AppColors.textPrimary100,
                                              ),
                                              IText.set(
                                                text: data.submissionStatus
                                                        ?.statusName ??
                                                    '',
                                                textAlign: TextAlign.left,
                                                styleName:
                                                    TextStyleName.regular,
                                                typeName: TextTypeName.caption1,
                                                color: AppColors.textPrimary100,
                                              ),
                                            ],
                                          ),
                                        ),
                                        SizedBox(
                                          width: double.infinity,
                                          child: IText.set(
                                            text:
                                                'Expires on ${DateHelper.formatdMy(data.jobExpiryDate)} ',
                                            textAlign: TextAlign.left,
                                            styleName: TextStyleName.regular,
                                            typeName: TextTypeName.caption1,
                                            color: AppColors.textPrimary100,
                                          ),
                                        ),
                                      ],
                                    ),
                                  );
                                },
                              ),
                            )
                          : Column(
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: [
                                SvgPicture.asset(AssetsConstant.illusJobEmpty),
                                const SpaceWidget(),
                                IText.set(
                                  text: 'Job is empty',
                                  textAlign: TextAlign.left,
                                  styleName: TextStyleName.medium,
                                  typeName: TextTypeName.large,
                                  color: AppColors.textPrimary,
                                  lineHeight: 1.2.h,
                                ),
                                const SpaceWidget(),
                                IText.set(
                                  text: 'Please check your keyword or filters',
                                  textAlign: TextAlign.left,
                                  styleName: TextStyleName.regular,
                                  typeName: TextTypeName.caption1,
                                  color: AppColors.textPrimary100,
                                )
                              ],
                            );
                    },
                  ),
                )
              ],
            ),
          ),
        ),
      ),
    );
  }
}
