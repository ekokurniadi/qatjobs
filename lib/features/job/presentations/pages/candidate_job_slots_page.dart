import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:qatjobs/core/helpers/global_helper.dart';
import 'package:qatjobs/core/styles/color_name_style.dart';
import 'package:qatjobs/core/styles/resolution_style.dart';
import 'package:qatjobs/core/styles/text_name_style.dart';
import 'package:qatjobs/core/widget/custom_appbar_widget.dart';
import 'package:qatjobs/core/widget/custom_text_field.dart';
import 'package:qatjobs/core/widget/loading_dialog_widget.dart';
import 'package:qatjobs/core/widget/section_title_widget.dart';
import 'package:qatjobs/core/widget/vertical_space_widget.dart';
import 'package:qatjobs/features/slots/presentations/cubit/slots_cubit.dart';

class CandidateJobSlotPage extends StatefulWidget {
  const CandidateJobSlotPage({
    super.key,
    required this.jobApplicationId,
  });
  final int jobApplicationId;

  @override
  State<CandidateJobSlotPage> createState() => _CandidateJobSlotPageState();
}

class _CandidateJobSlotPageState extends State<CandidateJobSlotPage> {
  ValueNotifier<int?> selectedSlot = ValueNotifier(null);
  TextEditingController notesController = TextEditingController();
  final GlobalKey<FormState> _formKey = GlobalKey();

  @override
  void initState() {
    context.read<SlotsCubit>().getCandidateSlot(widget.jobApplicationId);
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      resizeToAvoidBottomInset: false,
      appBar: const CustomAppBar(
        title: 'Choose Job Slots',
        showLeading: true,
      ),
      body: BlocConsumer<SlotsCubit, SlotsState>(
        listener: (context, state) {
          if (state.status == SlotStatus.loading) {
            LoadingDialog.show(message: 'Loading ...');
          } else if (state.status == SlotStatus.created) {
            LoadingDialog.dismiss();
            LoadingDialog.showSuccess(message: state.message);
            context
                .read<SlotsCubit>()
                .getCandidateSlot(widget.jobApplicationId);
          } else if (state.status == SlotStatus.failure) {
            LoadingDialog.dismiss();
            LoadingDialog.showError(message: state.message);
          } else {
            LoadingDialog.dismiss();
          }
        },
        builder: (context, state) {
          return state.candidateSlots.fold(
            () => const SizedBox(),
            (a) => a.fold(
              (l) => const SizedBox(),
              (r) {
                return Padding(
                  padding: defaultPadding,
                  child: Column(
                    children: [
                      if (!GlobalHelper.isEmptyList(r.selectSlot)) ...[
                        Container(
                          width: double.infinity,
                          padding: defaultPadding,
                          decoration: BoxDecoration(
                            borderRadius: defaultRadius,
                            boxShadow: AppColors.defaultShadow,
                            color: AppColors.success,
                          ),
                          child: IText.set(
                            text: 'You Have Selected this Slot',
                          ),
                        ),
                        const SpaceWidget(),
                        ...List.generate(
                          r.selectSlot!.length,
                          (index) => Container(
                            width: double.infinity,
                            padding: EdgeInsets.all(16.w),
                            decoration: BoxDecoration(
                              color: AppColors.bg200,
                              borderRadius: defaultRadius,
                              boxShadow: AppColors.defaultShadow,
                            ),
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Row(
                                  children: [
                                    IText.set(
                                      text: r.selectSlot?[index]['date'] ?? '',
                                      styleName: TextStyleName.bold,
                                    ),
                                    IText.set(
                                      text: ' - ',
                                      styleName: TextStyleName.bold,
                                    ),
                                    IText.set(
                                      text: r.selectSlot?[index]['time'] ?? '',
                                      styleName: TextStyleName.bold,
                                    ),
                                  ],
                                ),
                                IText.set(
                                  text: r.selectSlot?[index]['notes'] ?? '',
                                ),
                              ],
                            ),
                          ),
                        ).toList(),
                        const SpaceWidget(),
                      ],
                      if (r.slots.isNotEmpty) ...[
                        const SectionTitleWidget(title: 'Slot'),
                        const SpaceWidget(),
                        Flexible(
                          child: ListView.separated(
                            itemBuilder: (context, index) {
                              if (index > r.slots.length - 1) {
                                return Form(
                                  key: _formKey,
                                  child: CustomTextField(
                                    placeholder: 'Enter Notes',
                                    label: 'Notes',
                                    controller: notesController,
                                    maxLines: 3,
                                    textInputType: TextInputType.multiline,
                                    isRequired: true,
                                  ),
                                );
                              }
                              return ValueListenableBuilder(
                                  valueListenable: selectedSlot,
                                  builder: (context, selected, _) {
                                    return InkWell(
                                      onTap: () => selectedSlot.value =
                                          r.slots[index].slotId,
                                      child: Container(
                                        width: double.infinity,
                                        padding: EdgeInsets.all(16.w),
                                        decoration: BoxDecoration(
                                          color:
                                              selected == r.slots[index].slotId
                                                  ? AppColors.success
                                                  : AppColors.bg200,
                                          borderRadius: defaultRadius,
                                          boxShadow: AppColors.defaultShadow,
                                        ),
                                        child: Row(
                                          mainAxisAlignment:
                                              MainAxisAlignment.spaceBetween,
                                          children: [
                                            Column(
                                              crossAxisAlignment:
                                                  CrossAxisAlignment.start,
                                              children: [
                                                IText.set(
                                                  text: r.slots[index]
                                                      .scheduleDate,
                                                  styleName: TextStyleName.bold,
                                                ),
                                                IText.set(
                                                  text: r.slots[index]
                                                      .scheduleTime,
                                                  styleName: TextStyleName.bold,
                                                ),
                                                IText.set(
                                                  text: r.slots[index].notes,
                                                ),
                                              ],
                                            ),
                                          ],
                                        ),
                                      ),
                                    );
                                  });
                            },
                            separatorBuilder: (context, index) {
                              return SizedBox(height: 16.h);
                            },
                            itemCount: r.slots.length + 1,
                          ),
                        ),
                      ],
                      const SpaceWidget(),
                      const SectionTitleWidget(title: 'History'),
                      const SpaceWidget(),
                      Flexible(
                        child: ListView.separated(
                          itemBuilder: (context, index) {
                            return Container(
                              width: double.infinity,
                              padding: EdgeInsets.all(16.w),
                              decoration: BoxDecoration(
                                color: AppColors.bg200,
                                borderRadius: defaultRadius,
                                boxShadow: AppColors.defaultShadow,
                              ),
                              child: Row(
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceBetween,
                                children: [
                                  Column(
                                    crossAxisAlignment:
                                        CrossAxisAlignment.start,
                                    children: [
                                      IText.set(
                                        text: r.histories[index].companyName,
                                        styleName: TextStyleName.bold,
                                      ),
                                      IText.set(
                                        text: r.histories[index].notes,
                                      ),
                                    ],
                                  ),
                                  IText.set(
                                    text: r.histories[index].scheduleCreatedAt,
                                  ),
                                ],
                              ),
                            );
                          },
                          separatorBuilder: (context, index) {
                            return SizedBox(height: 16.h);
                          },
                          itemCount: r.histories.length,
                        ),
                      )
                    ],
                  ),
                );
              },
            ),
          );
        },
      ),
      bottomNavigationBar: Container(
        padding: defaultPadding,
        decoration: BoxDecoration(
          color: AppColors.bg200,
          boxShadow: AppColors.defaultShadow,
        ),
        child: Row(
          children: [
            Expanded(
              child: SizedBox(
                height: 50.h,
                child: ElevatedButton(
                  onPressed: () {
                    if (!_formKey.currentState!.validate()) {
                      return;
                    }
                    if (!GlobalHelper.isEmpty(selectedSlot.value)) {
                      context.read<SlotsCubit>().candidateChoosePreference(
                            widget.jobApplicationId,
                            chooseSlotNotes: notesController.text,
                            slotId: selectedSlot.value,
                          );
                    }
                  },
                  child: const Text('Send Slots'),
                ),
              ),
            ),
            SizedBox(width: 16.w),
            Expanded(
              child: SizedBox(
                height: 50.h,
                child: ElevatedButton(
                  style: ElevatedButton.styleFrom(
                    backgroundColor: AppColors.danger100,
                  ),
                  onPressed: () {
                    context.read<SlotsCubit>().candidateChoosePreference(
                          widget.jobApplicationId,
                          chooseSlotNotes: notesController.text,
                        );
                  },
                  child: const Text('Reject All Slots'),
                ),
              ),
            )
          ],
        ),
      ),
    );
  }
}
