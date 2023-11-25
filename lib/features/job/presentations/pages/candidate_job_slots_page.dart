import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:qatjobs/core/styles/color_name_style.dart';
import 'package:qatjobs/core/styles/resolution_style.dart';
import 'package:qatjobs/core/widget/custom_appbar_widget.dart';

class CandidateJobSlotPage extends StatefulWidget {
  const CandidateJobSlotPage({super.key});

  @override
  State<CandidateJobSlotPage> createState() => _CandidateJobSlotPageState();
}

class _CandidateJobSlotPageState extends State<CandidateJobSlotPage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: CustomAppBar(
        title: 'Choose Job Slots',
        showLeading: true,
      ),
      body: Column(
        children: [],
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
                  child: Text('Reject All Slots'),
                ),
              ),
            )
          ],
        ),
      ),
    );
  }
}
