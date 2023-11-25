import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:qatjobs/core/helpers/date_helper.dart';
import 'package:qatjobs/core/styles/color_name_style.dart';
import 'package:qatjobs/core/styles/resolution_style.dart';
import 'package:qatjobs/core/styles/text_name_style.dart';
import 'package:qatjobs/core/widget/custom_appbar_widget.dart';
import 'package:qatjobs/core/widget/custom_text_field.dart';
import 'package:qatjobs/core/widget/vertical_space_widget.dart';

import 'package:qatjobs/features/job_stages/data/models/job_stages_model.codegen.dart';
import 'package:zoom_tap_animation/zoom_tap_animation.dart';

class JobSlots extends StatefulWidget {
  const JobSlots({
    super.key,
    this.jobStage,
  });
  final JobStagesModel? jobStage;

  @override
  State<JobSlots> createState() => _JobSlotsState();
}

class _JobSlotsState extends State<JobSlots> {
  List<Map<String, dynamic>> formSlots = [];
  final TextEditingController dateController = TextEditingController();
  final TextEditingController timeController = TextEditingController();
  final TextEditingController notesController = TextEditingController();

  @override
  void initState() {
    formSlots.add({
      'id': 0,
      'date': DateHelper.formatdMy(DateTime.now().toString()),
      'time': '',
      'notes': '',
      'jobStages': widget.jobStage,
    });
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
                          decoration: BoxDecoration(
                            color: AppColors.bg200,
                            boxShadow: AppColors.defaultShadow,
                            borderRadius: defaultRadius,
                          ),
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
                                    icon: Icon(Icons.arrow_back),
                                  ),
                                  IText.set(text: 'Back'),
                                ],
                              ),
                              SpaceWidget(),
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
                                        '${result.hour}:${result.minute}';
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
                              const Spacer(),
                              SizedBox(
                                height: 50,
                                width: double.infinity,
                                child: ElevatedButton(
                                  onPressed: () {},
                                  child: const Text('Save'),
                                ),
                              ),
                            ],
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
            child: ListView.separated(
              separatorBuilder: (context, index) => const SpaceWidget(),
              padding: EdgeInsets.symmetric(horizontal: 16.w),
              shrinkWrap: true,
              itemCount: formSlots.length,
              itemBuilder: (context, index) {
                return Container(
                  padding: defaultPadding,
                  decoration: BoxDecoration(
                    color: AppColors.bg200,
                    boxShadow: AppColors.defaultShadow,
                    borderRadius: defaultRadius,
                  ),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      IText.set(
                        text: 'Batch ${index + 1}',
                        styleName: TextStyleName.semiBold,
                      ),
                      Divider(),
                      CustomTextField(
                        placeholder: 'Date',
                        isCalendarPicker: true,
                        isReadOnly: true,
                        isRequired: true,
                        onTap: () {},
                      ),
                      CustomTextField(
                        placeholder: 'Time',
                        isCalendarPicker: true,
                        isReadOnly: true,
                        isRequired: true,
                        onTap: () {},
                      ),
                      CustomTextField(
                        placeholder: 'Notes',
                        maxLines: 8,
                      ),
                    ],
                  ),
                );
              },
            ),
          )
        ],
      ),
    );
  }
}
