import 'package:email_validator/email_validator.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/svg.dart';
import 'package:image_picker/image_picker.dart';
import 'package:qatjobs/core/constant/assets_constant.dart';
import 'package:qatjobs/core/helpers/image_picker_helper.dart';
import 'package:qatjobs/core/styles/color_name_style.dart';
import 'package:qatjobs/core/styles/resolution_style.dart';
import 'package:qatjobs/core/styles/text_name_style.dart';
import 'package:qatjobs/core/widget/custom_text_field.dart';
import 'package:qatjobs/core/widget/vertical_space_widget.dart';
import 'package:qatjobs/features/job/domain/usecases/email_to_friend_usecase.dart';
import 'package:qatjobs/features/job/presentations/bloc/bloc/jobs_bloc.dart';

class EmailToFriendDialogBottomSheet extends StatefulWidget {
  const EmailToFriendDialogBottomSheet({
    super.key,
    required this.title,
    required this.caption,
    required this.jobId,
  });
  final String title;
  final String caption;
  final int jobId;

  @override
  State<EmailToFriendDialogBottomSheet> createState() =>
      _EmailToFriendDialogBottomSheetState();
}

class _EmailToFriendDialogBottomSheetState
    extends State<EmailToFriendDialogBottomSheet> {
  final TextEditingController friendName = TextEditingController();
  final TextEditingController friendEmail = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: defaultPadding,
      decoration: BoxDecoration(
        borderRadius: defaultRadius,
        boxShadow: AppColors.defaultShadow,
        color: AppColors.bg300,
      ),
      child: Column(
          mainAxisSize: MainAxisSize.min,
          mainAxisAlignment: MainAxisAlignment.start,
          children: [
            const SpaceWidget(),
            Container(
              width: 80.w,
              height: 5,
              decoration: BoxDecoration(
                color: AppColors.textPrimary100,
                borderRadius: defaultRadius,
              ),
            ),
            SpaceWidget(
              space: 32.h,
            ),
            IText.set(
              text: widget.title,
              styleName: TextStyleName.semiBold,
              typeName: TextTypeName.headline3,
              overflow: TextOverflow.ellipsis,
            ),
            SpaceWidget(space: 16.h),
            IText.set(
              text: widget.caption,
              styleName: TextStyleName.regular,
              color: AppColors.textPrimary100,
            ),
            SpaceWidget(space: 32.h),
            CustomTextField(
              placeholder: 'Friend Name',
              isRequired: true,
              controller: friendName,
              showBorder: true,
            ),
            CustomTextField(
              placeholder: 'Friend Email',
              controller: friendEmail,
              showBorder: true,
              validator: (val) {
                if (val!.isEmpty) {
                  return 'Please fill out this field !';
                } else if (!EmailValidator.validate(val)) {
                  return 'Invalid format email';
                }
                return null;
              },
            ),
            const SpaceWidget(),
            const Spacer(),
            SizedBox(
              width: double.infinity,
              height: 60.h,
              child: ElevatedButton(
                onPressed: () {
                  Navigator.pop(context);
                  context.read<JobsBloc>().add(
                        JobsEvent.emailToFriend(
                          EmailToFriendRequestParams(
                            jobId: widget.jobId,
                            friendName: friendName.text,
                            email: friendEmail.text,
                          ),
                        ),
                      );
                },
                child: IText.set(
                  text: 'CONTINUE',
                  styleName: TextStyleName.semiBold,
                  color: AppColors.bg100,
                ),
              ),
            ),
            const SpaceWidget(),
            SizedBox(
                width: double.infinity,
                height: 60.h,
                child: ElevatedButton(
                  style: ElevatedButton.styleFrom(
                    backgroundColor: AppColors.secondary,
                  ),
                  onPressed: () {
                    Navigator.pop(context);
                  },
                  child: IText.set(
                    text: 'UNDO CHANGES',
                    styleName: TextStyleName.semiBold,
                    color: AppColors.textPrimary100,
                  ),
                )),
          ]),
    );
  }
}
