import 'package:auto_route/auto_route.dart';
import 'package:collection/collection.dart';
import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:qatjobs/core/auto_route/auto_route.gr.dart';
import 'package:qatjobs/core/constant/global_constant.dart';
import 'package:qatjobs/core/extensions/dio_response_extension.dart';
import 'package:qatjobs/core/helpers/date_helper.dart';
import 'package:qatjobs/core/helpers/dio_helper.dart';
import 'package:qatjobs/core/helpers/file_downloader_helper.dart';
import 'package:qatjobs/core/helpers/notification_helper.dart';
import 'package:qatjobs/core/styles/color_name_style.dart';
import 'package:qatjobs/core/styles/resolution_style.dart';
import 'package:qatjobs/core/styles/text_name_style.dart';
import 'package:qatjobs/core/widget/confirm_dialog_bottom_sheet.dart';
import 'package:qatjobs/core/widget/custom_appbar_widget.dart';
import 'package:qatjobs/core/widget/dropdown_search_widget.dart';
import 'package:qatjobs/core/widget/loading_dialog_widget.dart';
import 'package:qatjobs/core/widget/section_title_widget.dart';
import 'package:qatjobs/core/widget/vertical_space_widget.dart';
import 'package:qatjobs/core/widget/widget_chip.dart';
import 'package:qatjobs/features/job_stages/presentations/cubit/job_stages_cubit.dart';
import 'package:qatjobs/features/profile/employer/presentations/cubit/employer_cubit.dart';
import 'package:qatjobs/features/profile/employer/presentations/pages/slot_page.dart';

class JobApplicationPage extends StatefulWidget {
  const JobApplicationPage({
    super.key,
    required this.id,
  });
  final int id;

  @override
  State<JobApplicationPage> createState() => _JobApplicationPageState();
}

class _JobApplicationPageState extends State<JobApplicationPage> {
  @override
  void initState() {
    context.read<EmployerCubit>().getApplicant(widget.id);
    super.initState();
  }

  List<PopupMenuItem> button = [];

  Future<void> updateStatus({
    required int applicationsId,
    required int jobId,
    required int status,
  }) async {
    try {
      LoadingDialog.show(message: 'Loading ...');
      final result = await DioHelper.dio!.post(
          '/employer/jobs/applications/$applicationsId/status/$status',
          data: {'jobId': jobId});

      if (result.isOk) {
        LoadingDialog.dismiss();
        LoadingDialog.showSuccess(message: result.data['message']);
        context.read<EmployerCubit>().getApplicant(widget.id);
      } else {
        LoadingDialog.dismiss();
        LoadingDialog.showError(message: result.data['message']);
      }
    } on DioError catch (e) {
      final msg = DioHelper.formatException(e);
      LoadingDialog.dismiss();
      LoadingDialog.showError(
        message: msg,
      );
    }
  }

  Future<void> delete({
    required int applicationsId,
    required int jobId,
  }) async {
    try {
      LoadingDialog.show(message: 'Loading ...');
      final result = await DioHelper.dio!.delete(
          '/employer/jobs/applications/$applicationsId',
          data: {'jobId': jobId});

      if (result.isOk) {
        LoadingDialog.dismiss();
        LoadingDialog.showSuccess(message: result.data['message']);
        await Future.delayed(
          const Duration(seconds: 1),
          () {
            context.read<EmployerCubit>().getApplicant(widget.id);
          },
        );
      } else {
        LoadingDialog.dismiss();
        LoadingDialog.showError(message: result.data['message']);
      }
    } on DioError catch (e) {
      final msg = DioHelper.formatException(e);
      LoadingDialog.dismiss();
      LoadingDialog.showError(
        message: msg,
      );
    }
  }

  Future<void> changeJobStages({
    required int applicationsId,
    required int jobstageId,
  }) async {
    try {
      LoadingDialog.show(message: 'Loading ...');
      final result = await DioHelper.dio!.post(
        '/employer/jobs/applications/$applicationsId/job-stage',
        data: {
          'job_application_id': applicationsId,
          'job_stage': jobstageId,
        },
      );

      if (result.isOk) {
        LoadingDialog.dismiss();
        LoadingDialog.showSuccess(message: result.data['message']);
        await Future.delayed(
          const Duration(seconds: 1),
          () {
            context.read<EmployerCubit>().getApplicant(widget.id);
          },
        );
      } else {
        LoadingDialog.dismiss();
        LoadingDialog.showError(message: result.data['message']);
      }
    } on DioError catch (e) {
      final msg = DioHelper.formatException(e);
      LoadingDialog.dismiss();
      LoadingDialog.showSuccess(
        message: msg,
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: const CustomAppBar(
        title: 'Job Application',
        showLeading: true,
      ),
      body: BlocBuilder<EmployerCubit, EmployerState>(
        builder: (context, state) {
          return ListView.separated(
            padding: defaultPadding,
            itemCount: state.jobApplicants.length,
            itemBuilder: (context, index) {
              return Container(
                padding: defaultPadding,
                decoration: BoxDecoration(
                  color: AppColors.bg200,
                  borderRadius: defaultRadius,
                  boxShadow: AppColors.defaultShadow,
                ),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    Expanded(
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              IText.set(
                                text: state.jobApplicants[index].candidate.user
                                        ?.fullName ??
                                    '',
                                styleName: TextStyleName.semiBold,
                                color: AppColors.primary,
                              ),
                              PopupMenuButton(
                                itemBuilder: (context) {
                                  if (![
                                    GlobalConstant.appliedHired,
                                    GlobalConstant.appliedDeclined,
                                    GlobalConstant.appliedOnGoing
                                  ].contains(
                                      state.jobApplicants[index].status)) {
                                    button = [
                                      PopupMenuItem(
                                        value: 'view_candidate',
                                        child: IText.set(
                                          text: 'Candidate Profile',
                                          textAlign: TextAlign.left,
                                          styleName: TextStyleName.semiBold,
                                          typeName: TextTypeName.headline3,
                                          color: AppColors.textPrimary100,
                                        ),
                                      ),
                                      PopupMenuItem(
                                        value: 'shortlisted',
                                        child: IText.set(
                                          text: 'Shortlisted',
                                          textAlign: TextAlign.left,
                                          styleName: TextStyleName.semiBold,
                                          typeName: TextTypeName.headline3,
                                          color: AppColors.textPrimary100,
                                        ),
                                      ),
                                      PopupMenuItem(
                                        value: 'rejected',
                                        child: IText.set(
                                          text: 'Rejected',
                                          textAlign: TextAlign.left,
                                          styleName: TextStyleName.semiBold,
                                          typeName: TextTypeName.headline3,
                                          color: AppColors.textPrimary100,
                                        ),
                                      ),
                                      PopupMenuItem(
                                        value: 'delete',
                                        child: IText.set(
                                          text: 'Delete',
                                          textAlign: TextAlign.left,
                                          styleName: TextStyleName.semiBold,
                                          typeName: TextTypeName.headline3,
                                          color: AppColors.textPrimary100,
                                        ),
                                      ),
                                    ];
                                  } else if (state
                                          .jobApplicants[index].status ==
                                      GlobalConstant.appliedOnGoing) {
                                    button = [
                                      PopupMenuItem(
                                        value: 'view_candidate',
                                        child: IText.set(
                                          text: 'Candidate Profile',
                                          textAlign: TextAlign.left,
                                          styleName: TextStyleName.semiBold,
                                          typeName: TextTypeName.headline3,
                                          color: AppColors.textPrimary100,
                                        ),
                                      ),
                                      PopupMenuItem(
                                        value: 'job-stages',
                                        child: IText.set(
                                          text: 'Job Stages',
                                          textAlign: TextAlign.left,
                                          styleName: TextStyleName.semiBold,
                                          typeName: TextTypeName.headline3,
                                          color: AppColors.textPrimary100,
                                        ),
                                      ),
                                      if (state.jobApplicants[index].jobStage !=
                                          null) ...[
                                        PopupMenuItem(
                                          value: 'slot',
                                          child: IText.set(
                                            text: 'Slot',
                                            textAlign: TextAlign.left,
                                            styleName: TextStyleName.semiBold,
                                            typeName: TextTypeName.headline3,
                                            color: AppColors.textPrimary100,
                                          ),
                                        ),
                                      ],
                                      PopupMenuItem(
                                        value: 'selected',
                                        child: IText.set(
                                          text: 'Selected',
                                          textAlign: TextAlign.left,
                                          styleName: TextStyleName.semiBold,
                                          typeName: TextTypeName.headline3,
                                          color: AppColors.textPrimary100,
                                        ),
                                      ),
                                      PopupMenuItem(
                                        value: 'rejected',
                                        child: IText.set(
                                          text: 'Rejected',
                                          textAlign: TextAlign.left,
                                          styleName: TextStyleName.semiBold,
                                          typeName: TextTypeName.headline3,
                                          color: AppColors.textPrimary100,
                                        ),
                                      ),
                                      PopupMenuItem(
                                        value: 'delete',
                                        child: IText.set(
                                          text: 'Delete',
                                          textAlign: TextAlign.left,
                                          styleName: TextStyleName.semiBold,
                                          typeName: TextTypeName.headline3,
                                          color: AppColors.textPrimary100,
                                        ),
                                      ),
                                    ];
                                  } else if (state
                                          .jobApplicants[index].status ==
                                      GlobalConstant.appliedHired) {
                                    button = [
                                      PopupMenuItem(
                                        value: 'view_candidate',
                                        child: IText.set(
                                          text: 'Candidate Profile',
                                          textAlign: TextAlign.left,
                                          styleName: TextStyleName.semiBold,
                                          typeName: TextTypeName.headline3,
                                          color: AppColors.textPrimary100,
                                        ),
                                      ),
                                      PopupMenuItem(
                                        value: 'delete',
                                        child: IText.set(
                                          text: 'Delete',
                                          textAlign: TextAlign.left,
                                          styleName: TextStyleName.semiBold,
                                          typeName: TextTypeName.headline3,
                                          color: AppColors.textPrimary100,
                                        ),
                                      ),
                                    ];
                                  } else {
                                    button = [
                                      PopupMenuItem(
                                        value: 'view_candidate',
                                        child: IText.set(
                                          text: 'Candidate Profile',
                                          textAlign: TextAlign.left,
                                          styleName: TextStyleName.semiBold,
                                          typeName: TextTypeName.headline3,
                                          color: AppColors.textPrimary100,
                                        ),
                                      ),
                                      PopupMenuItem(
                                        value: 'delete',
                                        child: IText.set(
                                          text: 'Delete',
                                          textAlign: TextAlign.left,
                                          styleName: TextStyleName.semiBold,
                                          typeName: TextTypeName.headline3,
                                          color: AppColors.textPrimary100,
                                        ),
                                      ),
                                    ];
                                  }
                                  return button;
                                },
                                icon: const Icon(Icons.more_vert),
                                onSelected: (value) async {
                                  switch (value) {
                                    case 'slot':
                                      Navigator.push(
                                        context,
                                        MaterialPageRoute(
                                          builder: (context) {
                                            return JobSlots(
                                              jobStage: state
                                                  .jobApplicants[index]
                                                  .jobStage,
                                              applicantId:
                                                  state.jobApplicants[index].id,
                                            );
                                          },
                                        ),
                                      );
                                      break;
                                    case 'view_candidate':
                                      if (state.jobApplicants[index].candidate
                                              .user !=
                                          null) {
                                        AutoRouter.of(context).push(
                                          CandidateDetailRoute(
                                            userModel: state
                                                .jobApplicants[index].candidate,
                                          ),
                                        );
                                      }
                                      break;
                                    case 'job-stages':
                                      context.read<JobStagesCubit>().get();
                                      final result = await showDialog<int>(
                                        context: context,
                                        builder: (context) {
                                          return Dialog(
                                            shape: RoundedRectangleBorder(
                                              borderRadius: BorderRadius.all(
                                                Radius.circular(8.r),
                                              ),
                                            ),
                                            child: Container(
                                              padding: defaultPadding,
                                              decoration: BoxDecoration(
                                                color: AppColors.bg200,
                                                borderRadius: defaultRadius,
                                              ),
                                              child: Column(
                                                mainAxisSize: MainAxisSize.min,
                                                children: [
                                                  const SectionTitleWidget(
                                                      title:
                                                          'Select Job Stage'),
                                                  BlocBuilder<JobStagesCubit,
                                                      JobStagesState>(
                                                    builder: (context, jState) {
                                                      return DropdownSearchWidget(
                                                        showSearchBox: true,
                                                        alwaysShowLabel: true,
                                                        isRequired: true,
                                                        items: jState.stages,
                                                        hintText:
                                                            'Select Job Stage',
                                                        onChanged: (val) {
                                                          Navigator.pop(
                                                            context,
                                                            val?.id,
                                                          );
                                                        },
                                                        itemAsString: (p0) =>
                                                            p0.name,
                                                        selectedItem: jState
                                                            .stages
                                                            .firstWhereOrNull(
                                                          (e) =>
                                                              e.id ==
                                                              state
                                                                  .jobApplicants[
                                                                      index]
                                                                  .jobStage
                                                                  ?.id,
                                                        ),
                                                      );
                                                    },
                                                  ),
                                                ],
                                              ),
                                            ),
                                          );
                                        },
                                      );
                                      if (result != null) {
                                        await changeJobStages(
                                          applicationsId:
                                              state.jobApplicants[index].id,
                                          jobstageId: result,
                                        );
                                      }
                                      break;
                                    case 'shortlisted':
                                      await showModalBottomSheet(
                                        shape: const RoundedRectangleBorder(
                                          borderRadius: BorderRadius.only(
                                            topRight: Radius.circular(32),
                                            topLeft: Radius.circular(32),
                                          ),
                                        ),
                                        context: context,
                                        builder: (context) {
                                          return ConfirmDialogBottomSheet(
                                            title: 'Update Job Applications?',
                                            caption:
                                                'Are you sure you want to change this applications to Shortlisted?',
                                            onTapCancel: () =>
                                                Navigator.pop(context),
                                            onTapContinue: () async {
                                              Navigator.pop(context);
                                              await updateStatus(
                                                applicationsId: state
                                                    .jobApplicants[index].id,
                                                jobId: state
                                                    .jobApplicants[index]
                                                    .job
                                                    .id!,
                                                status: GlobalConstant
                                                    .appliedOnGoing,
                                              );
                                            },
                                          );
                                        },
                                      );
                                      break;
                                    case 'selected':
                                      await showModalBottomSheet(
                                        shape: const RoundedRectangleBorder(
                                          borderRadius: BorderRadius.only(
                                            topRight: Radius.circular(32),
                                            topLeft: Radius.circular(32),
                                          ),
                                        ),
                                        context: context,
                                        builder: (context) {
                                          return ConfirmDialogBottomSheet(
                                            title: 'Update Job Applications?',
                                            caption:
                                                'Are you sure you want to change this applications to Selected ?',
                                            onTapCancel: () =>
                                                Navigator.pop(context),
                                            onTapContinue: () async {
                                              Navigator.pop(context);
                                              await updateStatus(
                                                applicationsId: state
                                                    .jobApplicants[index].id,
                                                jobId: state
                                                    .jobApplicants[index]
                                                    .job
                                                    .id!,
                                                status:
                                                    GlobalConstant.appliedHired,
                                              );
                                            },
                                          );
                                        },
                                      );
                                      break;
                                    case 'rejected':
                                      await showModalBottomSheet(
                                        shape: const RoundedRectangleBorder(
                                          borderRadius: BorderRadius.only(
                                            topRight: Radius.circular(32),
                                            topLeft: Radius.circular(32),
                                          ),
                                        ),
                                        context: context,
                                        builder: (context) {
                                          return ConfirmDialogBottomSheet(
                                            title: 'Decline Job Applications?',
                                            caption:
                                                'Are you sure to decline this applications?',
                                            onTapCancel: () =>
                                                Navigator.pop(context),
                                            onTapContinue: () async {
                                              Navigator.pop(context);
                                              await updateStatus(
                                                applicationsId: state
                                                    .jobApplicants[index].id,
                                                jobId: state
                                                    .jobApplicants[index]
                                                    .job
                                                    .id!,
                                                status: GlobalConstant
                                                    .appliedDeclined,
                                              );
                                            },
                                          );
                                        },
                                      );
                                      break;

                                    case 'delete':
                                      await showModalBottomSheet(
                                        shape: const RoundedRectangleBorder(
                                          borderRadius: BorderRadius.only(
                                            topRight: Radius.circular(32),
                                            topLeft: Radius.circular(32),
                                          ),
                                        ),
                                        context: context,
                                        builder: (context) {
                                          return ConfirmDialogBottomSheet(
                                            title: 'Delete Applications ?',
                                            caption:
                                                'Are you sure you want to delete this job application',
                                            onTapCancel: () =>
                                                Navigator.pop(context),
                                            onTapContinue: () async {
                                              Navigator.pop(context);
                                              await delete(
                                                applicationsId: state
                                                    .jobApplicants[index].id,
                                                jobId: state
                                                    .jobApplicants[index]
                                                    .job
                                                    .id!,
                                              );
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
                          const SpaceWidget(),
                          if (state.jobApplicants[index].jobStage != null)
                            Row(
                              children: [
                                IText.set(
                                  text: 'Job Stages : ',
                                ),
                                IText.set(
                                  text: state.jobApplicants[index].jobStage
                                          ?.name ??
                                      '',
                                ),
                              ],
                            ),
                          Row(
                            children: [
                              IText.set(
                                text: 'Salary Expected : ',
                              ),
                              IText.set(
                                text:
                                    '${state.jobApplicants[index].job.currency?.currencyIcon ?? ''} ${state.jobApplicants[index].expectedSalary}',
                              ),
                            ],
                          ),
                          Row(
                            children: [
                              IText.set(
                                text: 'Applied On : ',
                              ),
                              IText.set(
                                text: DateHelper.formatdMy(
                                    state.jobApplicants[index].createdAt),
                              ),
                            ],
                          ),
                          Row(
                            children: [
                              IText.set(
                                text: 'Status : ',
                              ),
                              IText.set(
                                text: GlobalConstant.getAppliedStatus(
                                  state.jobApplicants[index].status,
                                ),
                              ),
                            ],
                          ),
                          SpaceWidget(space: 8.h),
                          InkWell(
                            onTap: () async {
                              final filename = state
                                  .jobApplicants[index].resumeUrl
                                  .split('/')
                                  .last;

                              await FileDownloaderHelper.downloadTask(
                                state.jobApplicants[index].resumeUrl,
                                filename,
                              );
                            },
                            child: const WidgetChip(
                              content: 'Download Resume',
                              backgroundColor: AppColors.success,
                              textColor: AppColors.textPrimary100,
                            ),
                          ),
                        ],
                      ),
                    ),
                  ],
                ),
              );
            },
            separatorBuilder: (context, index) {
              return const SpaceWidget();
            },
          );
        },
      ),
    );
  }
}
