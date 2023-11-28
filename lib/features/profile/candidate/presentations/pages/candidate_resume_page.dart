import 'package:auto_route/auto_route.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:qatjobs/core/auto_route/auto_route.gr.dart';
import 'package:qatjobs/core/constant/app_constant.dart';
import 'package:qatjobs/core/constant/assets_constant.dart';
import 'package:qatjobs/core/helpers/file_downloader_helper.dart';
import 'package:qatjobs/core/helpers/notification_helper.dart';
import 'package:qatjobs/core/styles/color_name_style.dart';
import 'package:qatjobs/core/styles/resolution_style.dart';
import 'package:qatjobs/core/styles/text_name_style.dart';
import 'package:qatjobs/core/widget/confirm_dialog_bottom_sheet.dart';
import 'package:qatjobs/core/widget/custom_appbar_widget.dart';
import 'package:qatjobs/core/widget/loading_dialog_widget.dart';
import 'package:qatjobs/core/widget/pull_to_refresh_widget.dart';
import 'package:qatjobs/core/widget/vertical_space_widget.dart';
import 'package:qatjobs/features/profile/candidate/presentations/bloc/profile_candidate_bloc.dart';
import 'package:zoom_tap_animation/zoom_tap_animation.dart';

class CandidateResumePage extends StatefulWidget {
  const CandidateResumePage({super.key});

  @override
  State<CandidateResumePage> createState() => _CandidateResumePageState();
}

class _CandidateResumePageState extends State<CandidateResumePage> {
  @override
  void initState() {
    context.read<ProfileCandidateBloc>().add(
          const ProfileCandidateEvent.getResume(),
        );
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return BlocListener<ProfileCandidateBloc, ProfileCandidateState>(
      listener: (context, state) {
        if (state.status == ProfileCandidateStatus.loading) {
          LoadingDialog.show(message: 'Loading ...');
        } else if (state.status == ProfileCandidateStatus.failure) {
          LoadingDialog.dismiss();
          LoadingDialog.showError(message: state.message);
        } else if (state.status == ProfileCandidateStatus.insertResume ||
            state.status == ProfileCandidateStatus.deleteResume) {
          LoadingDialog.dismiss();
          context.read<ProfileCandidateBloc>().add(
                const ProfileCandidateEvent.getResume(),
              );
        } else {
          LoadingDialog.dismiss();
        }
      },
      child: Scaffold(
        resizeToAvoidBottomInset: false,
        backgroundColor: AppColors.bg300,
        extendBody: true,
        appBar: const CustomAppBar(
          title: 'Resume',
          showLeading: true,
        ),
        body: PullToRefreshWidget(
          onRefresh: () async {
            context.read<ProfileCandidateBloc>().add(
                  const ProfileCandidateEvent.getResume(),
                );
          },
          child: Container(
            width: double.infinity,
            height: MediaQuery.sizeOf(context).height,
            padding: defaultPadding,
            child: SingleChildScrollView(
              physics: const AlwaysScrollableScrollPhysics(),
              child: Column(
                children: [
                  SizedBox(
                    width: double.infinity,
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.end,
                      children: [
                        InkWell(
                          onTap: () {
                            AutoRouter.of(context)
                                .push(const CandidateAddResumeRoute());
                          },
                          child: ZoomTapAnimation(
                            child: Container(
                              padding: defaultPadding,
                              child: Row(
                                children: [
                                  IText.set(
                                    text: 'Add New Resume',
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
                  BlocBuilder<ProfileCandidateBloc, ProfileCandidateState>(
                    builder: (context, state) {
                      return ListView.separated(
                        physics: const NeverScrollableScrollPhysics(),
                        shrinkWrap: true,
                        itemCount: state.resumes.length,
                        separatorBuilder: (context, index) =>
                            const SpaceWidget(),
                        itemBuilder: (context, index) {
                          return Container(
                            padding: defaultPadding,
                            decoration: BoxDecoration(
                              borderRadius: defaultRadius,
                              color: AppColors.bg200,
                              boxShadow: AppColors.defaultShadow,
                            ),
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: [
                                Row(
                                  mainAxisAlignment: MainAxisAlignment.start,
                                  children: [
                                    SvgPicture.asset(
                                      state.resumes[index].mimeType
                                              .contains(AppConstant.mimeTypePDF)
                                          ? AssetsConstant.svgAssetsPDF
                                          : state.resumes[index].mimeType
                                                  .contains(
                                                      AppConstant.mimeTypeImage)
                                              ? AssetsConstant.svgAssetsPicture
                                              : AssetsConstant.svgAssetsDoc,
                                      width: 42.w,
                                    ),
                                    SizedBox(width: 8.w),
                                    Expanded(
                                      child: Column(
                                        mainAxisAlignment:
                                            MainAxisAlignment.start,
                                        crossAxisAlignment:
                                            CrossAxisAlignment.start,
                                        children: [
                                          IText.set(
                                            text: state.resumes[index]
                                                .customProperties['title'],
                                            styleName: TextStyleName.semiBold,
                                            typeName: TextTypeName.headline3,
                                            overflow: TextOverflow.ellipsis,
                                          ),
                                          IText.set(
                                            text:
                                                '${(double.parse(state.resumes[index].size) / 1024).toStringAsFixed(0)}KB',
                                            styleName: TextStyleName.regular,
                                            color: AppColors.textPrimary100,
                                          ),
                                        ],
                                      ),
                                    ),
                                    IconButton(
                                      onPressed: () async {
                                        await showModalBottomSheet(
                                          shape: const RoundedRectangleBorder(
                                              borderRadius: BorderRadius.only(
                                            topRight: Radius.circular(32),
                                            topLeft: Radius.circular(32),
                                          )),
                                          context: context,
                                          builder: (context) {
                                            return ConfirmDialogBottomSheet(
                                              title: 'Remove Resume ?',
                                              caption:
                                                  'Are you sure you want to delete ${state.resumes[index].customProperties['title']}?',
                                              onTapCancel: () =>
                                                  Navigator.pop(context),
                                              onTapContinue: () {
                                                Navigator.pop(context);
                                                context
                                                    .read<
                                                        ProfileCandidateBloc>()
                                                    .add(
                                                      ProfileCandidateEvent
                                                          .deleteResume(
                                                        state.resumes[index].id,
                                                      ),
                                                    );
                                              },
                                            );
                                          },
                                        );
                                      },
                                      icon: SvgPicture.asset(
                                        AssetsConstant.svgAssetsDelete,
                                      ),
                                    ),
                                  ],
                                ),
                                SizedBox(
                                  width: 120.w,
                                  child: TextButton(
                                    onPressed: () async {
                                      final ext = state
                                          .resumes[index].originalUrl
                                          .split('/')
                                          .last;
                                      final fileName = state.resumes[index]
                                              .customProperties['title'] +
                                          '.' +
                                          ext.split('.').last;

                                      final result = await FileDownloaderHelper
                                          .downloadTask(
                                        state.resumes[index].originalUrl,
                                        fileName,
                                      );

                                      if (result != null) {
                                        await NotificationService()
                                            .showNotification(
                                          id: 1,
                                          title: 'Download Complete',
                                          body: 'Show Files on Directory',
                                          payLoad: result.path,
                                        );
                                      }
                                    },
                                    child: Row(
                                      children: [
                                        const Icon(Icons.download),
                                        IText.set(
                                          text: 'Download',
                                          styleName: TextStyleName.semiBold,
                                          typeName: TextTypeName.headline3,
                                          overflow: TextOverflow.ellipsis,
                                        ),
                                      ],
                                    ),
                                  ),
                                )
                              ],
                            ),
                          );
                        },
                      );
                    },
                  )
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}
