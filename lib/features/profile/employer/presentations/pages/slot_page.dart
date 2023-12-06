import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:qatjobs/core/constant/global_constant.dart';
import 'package:qatjobs/core/helpers/date_helper.dart';
import 'package:qatjobs/core/helpers/global_helper.dart';
import 'package:qatjobs/core/styles/color_name_style.dart';
import 'package:qatjobs/core/styles/resolution_style.dart';
import 'package:qatjobs/core/styles/text_name_style.dart';
import 'package:qatjobs/core/widget/custom_appbar_widget.dart';
import 'package:qatjobs/core/widget/custom_text_field.dart';
import 'package:qatjobs/core/widget/loading_dialog_widget.dart';
import 'package:qatjobs/core/widget/section_title_widget.dart';
import 'package:qatjobs/core/widget/vertical_space_widget.dart';

import 'package:qatjobs/features/job_stages/data/models/job_stages_model.codegen.dart';
import 'package:qatjobs/features/slots/domain/usecases/cancel_slot_usecase.dart';
import 'package:qatjobs/features/slots/domain/usecases/create_slot_usecase.dart';
import 'package:qatjobs/features/slots/presentations/cubit/slots_cubit.dart';
import 'package:zoom_tap_animation/zoom_tap_animation.dart';

class JobSlots extends StatefulWidget {
  const JobSlots({
    super.key,
    this.jobStage,
    required this.applicantId,
  });
  final JobStagesModel? jobStage;
  final int applicantId;

  @override
  State<JobSlots> createState() => _JobSlotsState();
}

class _JobSlotsState extends State<JobSlots> {
  final TextEditingController dateController = TextEditingController();
  final TextEditingController timeController = TextEditingController();
  final TextEditingController notesController = TextEditingController();
  final TextEditingController dateController2 = TextEditingController();
  final TextEditingController timeController2 = TextEditingController();
  final TextEditingController notesController2 = TextEditingController();
  final TextEditingController employerNotesController = TextEditingController();
  final GlobalKey<FormState> _formKey = GlobalKey();

  @override
  void initState() {
    context.read<SlotsCubit>().getSlot(widget.applicantId);
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.bg300,
      appBar: const CustomAppBar(
        title: 'Job Slot',
        showLeading: true,
      ),
      body: Column(
        children: [
          SizedBox(
            width: double.infinity,
            child: Row(
              mainAxisAlignment: MainAxisAlignment.end,
              children: [
                InkWell(
                  onTap: () async {
                    await showDialog(
                      context: context,
                      builder: (context) {
                        return Container(
                          padding: defaultPadding,
                          height: MediaQuery.sizeOf(context).height,
                          decoration: BoxDecoration(
                            color: AppColors.bg200,
                            boxShadow: AppColors.defaultShadow,
                            borderRadius: defaultRadius,
                          ),
                          child: Form(
                            key: _formKey,
                            child: SingleChildScrollView(
                              child: SizedBox(
                                width: double.infinity,
                                height: MediaQuery.sizeOf(context).height,
                                child: Column(
                                  mainAxisSize: MainAxisSize.min,
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    Row(
                                      children: [
                                        IconButton(
                                          onPressed: () {
                                            Navigator.pop(context);
                                          },
                                          icon: const Icon(Icons.arrow_back),
                                        ),
                                        IText.set(text: 'Back'),
                                      ],
                                    ),
                                    const SpaceWidget(),
                                    const SectionTitleWidget(title: 'Slots 1'),
                                    const SpaceWidget(),
                                    CustomTextField(
                                      isAlwaysShowLabel: true,
                                      placeholder: 'Date',
                                      label: 'Date',
                                      isCalendarPicker: true,
                                      isReadOnly: true,
                                      isRequired: true,
                                      onTap: () async {
                                        final result = await showDatePicker(
                                          context: context,
                                          initialDate: DateTime.now(),
                                          firstDate: DateTime.now(),
                                          lastDate: DateTime.now().add(
                                            const Duration(days: 365),
                                          ),
                                        );
                                        if (result != null) {
                                          dateController.text =
                                              DateHelper.getOnlyDate(
                                            result.toString(),
                                          );
                                        }
                                      },
                                      controller: dateController,
                                    ),
                                    CustomTextField(
                                      isAlwaysShowLabel: true,
                                      label: 'Time',
                                      placeholder: 'Time',
                                      isCalendarPicker: true,
                                      isReadOnly: true,
                                      isRequired: true,
                                      onTap: () async {
                                        final result = await showTimePicker(
                                          context: context,
                                          initialTime: TimeOfDay.now(),
                                        );
                                        if (result != null) {
                                          timeController.text =
                                              '${result.hour.toString().padLeft(2, '0')}:${result.minute.toString().padLeft(2, '0')}:00';
                                        }
                                      },
                                      controller: timeController,
                                    ),
                                    CustomTextField(
                                      label: 'Notes',
                                      isAlwaysShowLabel: true,
                                      placeholder: 'Notes',
                                      maxLines: 8,
                                      controller: notesController,
                                    ),
                                    const Divider(),
                                    const SpaceWidget(),
                                    const SectionTitleWidget(title: 'Slots 2'),
                                    const SpaceWidget(),
                                    CustomTextField(
                                      isAlwaysShowLabel: true,
                                      placeholder: 'Date',
                                      label: 'Date',
                                      isCalendarPicker: true,
                                      isReadOnly: true,
                                      isRequired: true,
                                      onTap: () async {
                                        final result = await showDatePicker(
                                          context: context,
                                          initialDate: DateTime.now(),
                                          firstDate: DateTime.now(),
                                          lastDate: DateTime.now().add(
                                            const Duration(days: 365),
                                          ),
                                        );
                                        if (result != null) {
                                          dateController2.text =
                                              DateHelper.getOnlyDate(
                                            result.toString(),
                                          );
                                        }
                                      },
                                      controller: dateController2,
                                    ),
                                    CustomTextField(
                                      isAlwaysShowLabel: true,
                                      label: 'Time',
                                      placeholder: 'Time',
                                      isCalendarPicker: true,
                                      isReadOnly: true,
                                      isRequired: true,
                                      onTap: () async {
                                        final result = await showTimePicker(
                                          context: context,
                                          initialTime: TimeOfDay.now(),
                                        );
                                        if (result != null) {
                                          timeController2.text =
                                              '${result.hour.toString().padLeft(2, '0')}:${result.minute.toString().padLeft(2, '0')}:00';
                                        }
                                      },
                                      controller: timeController2,
                                    ),
                                    CustomTextField(
                                      label: 'Notes',
                                      isAlwaysShowLabel: true,
                                      placeholder: 'Notes',
                                      maxLines: 8,
                                      controller: notesController2,
                                    ),
                                    SizedBox(
                                      height: 50,
                                      width: double.infinity,
                                      child: ElevatedButton(
                                        onPressed: () {
                                          if (!_formKey.currentState!
                                              .validate()) {
                                            return;
                                          }
                                          context.read<SlotsCubit>().createSlot(
                                            [
                                              SlotRequestParams(
                                                applicationsId:
                                                    widget.applicantId,
                                                date: dateController.text,
                                                time: timeController.text,
                                                notes: notesController.text,
                                              ),
                                              SlotRequestParams(
                                                applicationsId:
                                                    widget.applicantId,
                                                date: dateController2.text,
                                                time: timeController2.text,
                                                notes: notesController2.text,
                                              ),
                                            ],
                                          );
                                          Navigator.pop(context);
                                        },
                                        child: const Text('Save'),
                                      ),
                                    ),
                                  ],
                                ),
                              ),
                            ),
                          ),
                        );
                      },
                    );

                    // AutoRouter.of(context).push(FormJobStagesRoute());
                  },
                  child: ZoomTapAnimation(
                    child: Container(
                      padding: defaultPadding,
                      child: Row(
                        children: [
                          IText.set(
                            text: 'Add Job Slots',
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
            child: BlocListener<SlotsCubit, SlotsState>(
              listener: (context, state) {
                if (state.status == SlotStatus.created) {
                  LoadingDialog.dismiss();
                  LoadingDialog.showSuccess(message: state.message);
                  Future.delayed(const Duration(seconds: 2), () {
                    context.read<SlotsCubit>().getSlot(widget.applicantId);
                  });
                } else if (state.status == SlotStatus.loading) {
                  LoadingDialog.show(message: 'Loading ...');
                } else if (state.status == SlotStatus.failure) {
                  LoadingDialog.dismiss();
                  LoadingDialog.showError(message: state.message);
                } else {
                  LoadingDialog.dismiss();
                }
              },
              child: BlocBuilder<SlotsCubit, SlotsState>(
                builder: (context, state) {
                  return state.slots.fold(
                    () => const SizedBox(),
                    (a) => a.fold(
                      (l) => const SizedBox(),
                      (r) => ListView.separated(
                        separatorBuilder: (context, index) =>
                            const SpaceWidget(),
                        padding: EdgeInsets.symmetric(horizontal: 16.w),
                        shrinkWrap: true,
                        itemCount: r.jobSchedules.length,
                        itemBuilder: (context, index) {
                          return Container(
                            padding: defaultPadding,
                            decoration: BoxDecoration(
                              borderRadius: defaultRadius,
                              color: r.jobSchedules[index].status ==
                                      GlobalConstant.slotStatusSend
                                  ? AppColors.success
                                  : r.jobSchedules[index].status ==
                                          GlobalConstant.slotStatusRejected
                                      ? AppColors.danger50
                                      : AppColors.bg200,
                              boxShadow: AppColors.defaultShadow,
                            ),
                            child: Column(
                              mainAxisSize: MainAxisSize.min,
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                SizedBox(
                                  width: double.infinity,
                                  child: Row(
                                    children: [
                                      IText.set(
                                        text:
                                            'Batch ${r.jobSchedules[index].batch}',
                                        styleName: TextStyleName.bold,
                                      ),
                                      if (r.jobSchedules[index].status ==
                                          GlobalConstant.slotStatusSend) ...[
                                        const Icon(
                                          Icons.check_circle,
                                          color: AppColors.success,
                                        ),
                                      ] else if (r.jobSchedules[index].status ==
                                          GlobalConstant
                                              .slotStatusRejected) ...[
                                        const Icon(
                                          Icons.cancel,
                                          color: AppColors.danger100,
                                        )
                                      ]
                                    ],
                                  ),
                                ),
                                const SpaceWidget(),
                                SlotInfo(
                                  title: 'Date',
                                  value: DateHelper.formatdMy(
                                      r.jobSchedules[index].date),
                                ),
                                SlotInfo(
                                  title: 'Time',
                                  value: r.jobSchedules[index].time,
                                ),
                                SlotInfo(
                                  title: 'Notes',
                                  value: r.jobSchedules[index].notes ?? '-',
                                ),
                                if (!GlobalHelper.isEmpty(r.jobSchedules[index]
                                    .rejectedSlotNotes)) ...[
                                  const Divider(),
                                  const SpaceWidget(),
                                  SlotInfo(
                                    title: 'Candidate Notes',
                                    value: r.jobSchedules[index]
                                            .rejectedSlotNotes ??
                                        '-',
                                  ),
                                ],
                                if (!GlobalHelper.isEmpty(r.jobSchedules[index]
                                    .employerCancelSlotNotes)) ...[
                                  SlotInfo(
                                    title: 'Employer Notes',
                                    value: r.jobSchedules[index]
                                            .employerCancelSlotNotes ??
                                        '-',
                                  ),
                                ],
                                if (r.jobSchedules[index].status ==
                                    GlobalConstant.slotStatusSend) ...[
                                  CustomTextField(
                                    placeholder: 'Your Notes',
                                    label: 'Your Notes',
                                    isRequired: true,
                                    controller: employerNotesController,
                                  ),
                                  ElevatedButton(
                                    style: ElevatedButton.styleFrom(
                                      backgroundColor: AppColors.danger100,
                                    ),
                                    onPressed: () {
                                      context.read<SlotsCubit>().cancelSLot(
                                            CancelSlotRequestParams(
                                              applicationsId:
                                                  widget.applicantId,
                                              slotId: r.jobSchedules[index].id,
                                              notes:
                                                  employerNotesController.text,
                                            ),
                                          );
                                    },
                                    child: const Text('Cancel'),
                                  )
                                ]
                              ],
                            ),
                          );
                        },
                      ),
                    ),
                  );
                },
              ),
            ),
          )
        ],
      ),
    );
  }
}

class SlotInfo extends StatelessWidget {
  const SlotInfo({
    super.key,
    required this.title,
    required this.value,
  });

  final String title;
  final String value;

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.symmetric(
        horizontal: 16.w,
        vertical: 8.h,
      ),
      width: double.infinity,
      margin: EdgeInsets.only(bottom: 16.h),
      decoration: BoxDecoration(
        color: AppColors.bg200,
        border: Border.all(
          color: AppColors.neutral,
        ),
        borderRadius: defaultRadius,
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          IText.set(
            text: title,
            styleName: TextStyleName.bold,
          ),
          IText.set(
            text: value,
          ),
        ],
      ),
    );
  }
}
