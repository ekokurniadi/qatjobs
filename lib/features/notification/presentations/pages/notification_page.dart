import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:qatjobs/core/constant/assets_constant.dart';
import 'package:qatjobs/core/helpers/date_helper.dart';
import 'package:qatjobs/core/styles/color_name_style.dart';
import 'package:qatjobs/core/styles/resolution_style.dart';
import 'package:qatjobs/core/styles/text_name_style.dart';
import 'package:qatjobs/core/widget/custom_appbar_widget.dart';
import 'package:qatjobs/core/widget/vertical_space_widget.dart';
import 'package:qatjobs/features/notification/presentations/cubit/notification_cubit.dart';

class NotificationPage extends StatelessWidget {
  const NotificationPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.bg300,
      appBar: CustomAppBar(
        title: 'Notification',
        actionWidget: [
          BlocBuilder<NotificationCubit, NotificationState>(
            builder: (context, state) {
              return state.notifications.isNotEmpty
                  ? Padding(
                      padding: EdgeInsets.symmetric(horizontal: 16.w),
                      child: TextButton(
                        onPressed: () {
                          context.read<NotificationCubit>().readAll();
                        },
                        child: IText.set(
                          text: 'Read All',
                          styleName: TextStyleName.bold,
                          typeName: TextTypeName.headline3,
                          color: AppColors.warning,
                        ),
                      ),
                    )
                  : const SizedBox();
            },
          )
        ],
      ),
      body: Padding(
        padding: defaultPadding,
        child: BlocListener<NotificationCubit, NotificationState>(
          listener: (context, state) {
            if (state.status == NotifStatus.readAll ||
                state.status == NotifStatus.read) {
              context.read<NotificationCubit>().getNotif();
            }
          },
          child: BlocBuilder<NotificationCubit, NotificationState>(
            builder: (context, state) {
              return state.notifications.isEmpty
                  ? Center(
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        crossAxisAlignment: CrossAxisAlignment.center,
                        children: [
                          SvgPicture.asset(AssetsConstant.illusJobEmpty),
                          const SpaceWidget(),
                          IText.set(
                            text: 'Notification is empty',
                            textAlign: TextAlign.left,
                            styleName: TextStyleName.medium,
                            typeName: TextTypeName.large,
                            color: AppColors.textPrimary,
                            lineHeight: 1.2.h,
                          ),
                          const SpaceWidget(),
                          IText.set(
                            text: 'You currently have no incoming messages',
                            textAlign: TextAlign.left,
                            styleName: TextStyleName.regular,
                            typeName: TextTypeName.caption1,
                            color: AppColors.textPrimary100,
                          )
                        ],
                      ),
                    )
                  : ListView.separated(
                      separatorBuilder: (context, index) => const SpaceWidget(),
                      shrinkWrap: true,
                      itemCount: state.notifications.length,
                      itemBuilder: (context, index) {
                        return InkWell(
                          onTap: () {
                            context
                                .read<NotificationCubit>()
                                .read(state.notifications[index].id);
                          },
                          child: Container(
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
                                  text: state.notifications[index].title,
                                  styleName: TextStyleName.bold,
                                  typeName: TextTypeName.caption1,
                                  color: AppColors.textPrimary100,
                                ),
                                IText.set(
                                  text: DateHelper.formatdMyHis(
                                      state.notifications[index].createdAt ??
                                          ''),
                                  styleName: TextStyleName.regular,
                                  typeName: TextTypeName.caption1,
                                  color: AppColors.neutral100,
                                )
                              ],
                            ),
                          ),
                        );
                      },
                    );
            },
          ),
        ),
      ),
    );
  }
}
