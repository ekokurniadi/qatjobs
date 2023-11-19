import 'dart:math';

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:qatjobs/core/constant/assets_constant.dart';
import 'package:qatjobs/core/constant/global_constant.dart';
import 'package:qatjobs/core/helpers/date_helper.dart';
import 'package:qatjobs/core/helpers/file_downloader_helper.dart';
import 'package:qatjobs/core/helpers/global_helper.dart';
import 'package:qatjobs/core/helpers/html_parse_helper.dart';
import 'package:qatjobs/core/helpers/notification_helper.dart';
import 'package:qatjobs/core/helpers/url_launcher_helper.dart';
import 'package:qatjobs/core/styles/color_name_style.dart';
import 'package:qatjobs/core/styles/resolution_style.dart';
import 'package:qatjobs/core/styles/text_name_style.dart';
import 'package:qatjobs/core/widget/custom_appbar_widget.dart';
import 'package:qatjobs/core/widget/vertical_space_widget.dart';
import 'package:qatjobs/core/widget/widget_chip.dart';
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
                                      value: 'job Stages',
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
                                    case 'edit':
                                      // AutoRouter.of(context).push(
                                      //   UpdateJobRoute(
                                      //     job: data,
                                      //   ),
                                      // );

                                      break;
                                    case 'applications':
                                      // AutoRouter.of(context).push(
                                      //   JobApplicationRoute(
                                      //     id: data.id ?? 0,
                                      //   ),
                                      // );

                                      break;
                                    case 'delete':
                                    // await showModalBottomSheet(
                                    //   shape: const RoundedRectangleBorder(
                                    //     borderRadius: BorderRadius.only(
                                    //       topRight: Radius.circular(32),
                                    //       topLeft: Radius.circular(32),
                                    //     ),
                                    //   ),
                                    //   context: context,
                                    //   builder: (context) {
                                    //     return ConfirmDialogBottomSheet(
                                    //       title: 'Remove Favorite Job ?',
                                    //       caption:
                                    //           'Are you sure you want to delete ${data.jobTitle}?',
                                    //       onTapCancel: () =>
                                    //           Navigator.pop(context),
                                    //       onTapContinue: () {
                                    //         Navigator.pop(context);
                                    //       },
                                    //     );
                                    //   },
                                    // );
                                    // break;
                                    default:
                                      break;
                                  }
                                },
                              )
                            ],
                          ),
                          const SpaceWidget(),
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
