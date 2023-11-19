import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
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
import 'package:qatjobs/core/widget/loading_dialog_widget.dart';
import 'package:qatjobs/core/widget/vertical_space_widget.dart';
import 'package:qatjobs/core/widget/widget_chip.dart';
import 'package:qatjobs/features/job_stages/presentations/pages/job_stages_list_page.dart';
import 'package:qatjobs/features/profile/employer/presentations/cubit/employer_cubit.dart';

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
      LoadingDialog.showSuccess(
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
                                  return [
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
                                      value: 'job-stages',
                                      child: IText.set(
                                        text: 'Job Stages',
                                        textAlign: TextAlign.left,
                                        styleName: TextStyleName.semiBold,
                                        typeName: TextTypeName.headline3,
                                        color: AppColors.textPrimary100,
                                      ),
                                    ),
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
                                },
                                icon: const Icon(Icons.more_vert),
                                onSelected: (value) async {
                                  switch (value) {
                                    case 'job-stages':
                                      final result = await showDialog<int>(
                                        context: context,
                                        builder: (context) {
                                          return const Dialog(
                                            shape: RoundedRectangleBorder(
                                              borderRadius: BorderRadius.only(
                                                topRight: Radius.circular(32),
                                                topLeft: Radius.circular(32),
                                              ),
                                            ),
                                            child: JobStagesListPage(
                                              isAsOption: true,
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

                              final result =
                                  await FileDownloaderHelper.downloadTask(
                                state.jobApplicants[index].resumeUrl,
                                filename,
                              );

                              if (result != null) {
                                NotificationService().showNotification(
                                  id: 1,
                                  title: 'Download Complete',
                                  body: 'Show Files on Directory',
                                  payLoad: result.path,
                                );
                              }
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
              return Container();
            },
          );
        },
      ),
    );
  }
}
