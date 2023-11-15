import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:qatjobs/core/styles/color_name_style.dart';
import 'package:qatjobs/core/styles/resolution_style.dart';
import 'package:qatjobs/core/styles/text_name_style.dart';
import 'package:qatjobs/core/widget/custom_appbar_widget.dart';
import 'package:qatjobs/core/widget/loading_dialog_widget.dart';
import 'package:qatjobs/core/widget/pull_to_refresh_widget.dart';
import 'package:qatjobs/features/job/data/models/job_alert_request_params.codegen.dart';
import 'package:qatjobs/features/job/presentations/bloc/bloc/jobs_bloc.dart';

class JobAlertPage extends StatefulWidget {
  const JobAlertPage({super.key});

  @override
  State<JobAlertPage> createState() => _JobAlertPageState();
}

class _JobAlertPageState extends State<JobAlertPage> {
  @override
  void initState() {
    context.read<JobsBloc>().add(const JobsEvent.getJobAlert());
    super.initState();
  }

  final ValueNotifier<List<String>> jobAlertId = ValueNotifier([]);
  final ValueNotifier<int> jobAlertActive = ValueNotifier(0);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: const CustomAppBar(
        title: 'Job Alert',
        showLeading: true,
      ),
      body: BlocConsumer<JobsBloc, JobsState>(
        listener: (context, state) {
          if (state.status == JobStatus.loading) {
            LoadingDialog.show(message: 'Loading ...');
          } else if (state.status == JobStatus.failure) {
            LoadingDialog.dismiss();
            LoadingDialog.showError(message: state.message);
          } else if (state.status == JobStatus.getJobAlert) {
            jobAlertId.value = List.from(jobAlertId.value)
              ..addAll(state.jobAlerts.jobAlerts);
            jobAlertActive.value = int.parse(
              state.jobAlerts.candidate.jobAlert.toString(),
            );
            LoadingDialog.dismiss();
          } else if (state.status == JobStatus.insertJobAlert) {
            LoadingDialog.dismiss();
            LoadingDialog.showSuccess(message: state.message);
          } else {
            LoadingDialog.dismiss();
          }
        },
        builder: (context, state) {
          return PullToRefreshWidget(
            onRefresh: () async {
              context.read<JobsBloc>().add(const JobsEvent.getJobAlert());
            },
            child: SingleChildScrollView(
              physics: const AlwaysScrollableScrollPhysics(),
              child: Padding(
                padding: defaultPadding,
                child: Column(
                  children: [
                    Container(
                      width: double.infinity,
                      padding: defaultPadding,
                      decoration: BoxDecoration(
                        borderRadius: defaultRadius,
                        boxShadow: AppColors.defaultShadow,
                        color: AppColors.bg200,
                      ),
                      child: Column(
                        children: [
                          Row(
                            children: [
                              ValueListenableBuilder(
                                  valueListenable: jobAlertActive,
                                  builder: (context, active, _) {
                                    return Switch(
                                      activeColor: AppColors.warning,
                                      value: jobAlertActive.value == 1,
                                      onChanged: (val) {
                                        jobAlertActive.value = val ? 1 : 0;
                                      },
                                    );
                                  }),
                              Expanded(
                                child: IText.set(
                                  text:
                                      'Notify me By Email when a jobs gets posted that is relevant to my choice.',
                                ),
                              )
                            ],
                          ),
                          ValueListenableBuilder(
                              valueListenable: jobAlertActive,
                              builder: (context, active, _) {
                                return ValueListenableBuilder(
                                    valueListenable: jobAlertId,
                                    builder: (context, jobId, _) {
                                      return Container(
                                        padding: EdgeInsets.only(left: 16.w),
                                        child: Column(
                                          children: List.generate(
                                            state.jobAlerts.jobTypes.length,
                                            (index) => Row(
                                              children: [
                                                Switch(
                                                  activeColor:
                                                      AppColors.warning,
                                                  value: jobAlertId.value.any(
                                                    (job) =>
                                                        job ==
                                                        state.jobAlerts
                                                            .jobTypes[index].id
                                                            .toString(),
                                                  ),
                                                  onChanged: (val) {
                                                    if (val) {
                                                      jobAlertId.value = List
                                                          .from(
                                                              jobAlertId.value)
                                                        ..add(
                                                          state
                                                              .jobAlerts
                                                              .jobTypes[index]
                                                              .id
                                                              .toString(),
                                                        );
                                                    } else {
                                                      jobAlertId.value = List
                                                          .from(
                                                              jobAlertId.value)
                                                        ..removeWhere((e) =>
                                                            e ==
                                                            state
                                                                .jobAlerts
                                                                .jobTypes[index]
                                                                .id
                                                                .toString());
                                                    }
                                                    context
                                                        .read<JobsBloc>()
                                                        .add(
                                                          JobsEvent.addJobAlert(
                                                            JobAlertRequestParams(
                                                              jobTypes: active,
                                                              jobAlerts: List<
                                                                  int>.from(
                                                                jobAlertId.value
                                                                    .map(
                                                                  (e) =>
                                                                      int.parse(
                                                                    e,
                                                                  ),
                                                                ),
                                                              ),
                                                            ),
                                                          ),
                                                        );
                                                  },
                                                ),
                                                Expanded(
                                                  child: IText.set(
                                                    text: state.jobAlerts
                                                        .jobTypes[index].name,
                                                  ),
                                                )
                                              ],
                                            ),
                                          ).toList(),
                                        ),
                                      );
                                    });
                              })
                        ],
                      ),
                    )
                  ],
                ),
              ),
            ),
          );
        },
      ),
    );
  }
}
