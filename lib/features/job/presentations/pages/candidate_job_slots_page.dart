import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:qatjobs/core/helpers/date_helper.dart';
import 'package:qatjobs/core/styles/color_name_style.dart';
import 'package:qatjobs/core/styles/resolution_style.dart';
import 'package:qatjobs/core/styles/text_name_style.dart';
import 'package:qatjobs/core/widget/custom_appbar_widget.dart';
import 'package:qatjobs/core/widget/section_title_widget.dart';
import 'package:qatjobs/core/widget/vertical_space_widget.dart';
import 'package:qatjobs/features/profile/employer/presentations/pages/slot_page.dart';
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
  @override
  void initState() {
    context.read<SlotsCubit>().getCandidateSlot(widget.jobApplicationId);
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: const CustomAppBar(
        title: 'Choose Job Slots',
        showLeading: true,
      ),
      body: BlocConsumer<SlotsCubit, SlotsState>(
        listener: (context, state) {
          // TODO: implement listener
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
                      if (r.selectSlot.entries.isNotEmpty) ...[
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
                          r.selectSlot.length,
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
                                      text: r.selectSlot.entries
                                          .elementAt(index)
                                          .value['date'],
                                      styleName: TextStyleName.bold,
                                    ),
                                    IText.set(
                                      text: ' - ',
                                      styleName: TextStyleName.bold,
                                    ),
                                    IText.set(
                                      text: r.selectSlot.entries
                                          .elementAt(index)
                                          .value['time'],
                                      styleName: TextStyleName.bold,
                                    ),
                                  ],
                                ),
                                IText.set(
                                  text: r.selectSlot.entries
                                      .elementAt(index)
                                      .value['notes'],
                                ),
                              ],
                            ),
                          ),
                        ).toList(),
                        const SpaceWidget(),
                      ],
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
                  onPressed: () {},
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
                  onPressed: () {},
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
