import 'package:auto_route/auto_route.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/svg.dart';
import 'package:qatjobs/core/auto_route/auto_route.gr.dart';
import 'package:qatjobs/core/constant/assets_constant.dart';
import 'package:qatjobs/core/helpers/global_helper.dart';
import 'package:qatjobs/core/styles/color_name_style.dart';
import 'package:qatjobs/core/styles/resolution_style.dart';
import 'package:qatjobs/core/styles/text_name_style.dart';
import 'package:qatjobs/core/widget/confirm_dialog_bottom_sheet.dart';
import 'package:qatjobs/core/widget/custom_appbar_widget.dart';
import 'package:qatjobs/core/widget/custom_cached_image_network.dart';
import 'package:qatjobs/core/widget/loading_dialog_widget.dart';
import 'package:qatjobs/core/widget/pull_to_refresh_widget.dart';
import 'package:qatjobs/core/widget/vertical_space_widget.dart';
import 'package:qatjobs/features/job/presentations/bloc/bloc/jobs_bloc.dart';
import 'package:qatjobs/features/job/presentations/widgets/email_to_friend_dialog.dart';
import 'package:qatjobs/features/profile/candidate/presentations/bloc/profile_candidate_bloc.dart';
import 'package:timeago/timeago.dart' as timeago;

class FavoriteJobPage extends StatefulWidget {
  const FavoriteJobPage({super.key});

  @override
  State<FavoriteJobPage> createState() => _FavoriteJobPageState();
}

class _FavoriteJobPageState extends State<FavoriteJobPage> {
  @override
  void initState() {
    super.initState();
    context.read<JobsBloc>().add(const JobsEvent.getFavoriteJob());
    context
        .read<ProfileCandidateBloc>()
        .add(const ProfileCandidateEvent.getResume());
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.bg300,
      appBar: const CustomAppBar(
        title: 'Favorite Jobs',
        showLeading: true,
      ),
      body: MultiBlocListener(
        listeners: [
          BlocListener<JobsBloc, JobsState>(
            listener: (context, state) {
              if (state.status == JobStatus.loading) {
                LoadingDialog.show(message: 'Loading...');
              } else if (state.status == JobStatus.deleted ||
                  state.status == JobStatus.emailToFriendSuccess) {
                LoadingDialog.dismiss();
                LoadingDialog.showSuccess(message: state.message);
                Future.delayed(const Duration(milliseconds: 500), () {
                  context
                      .read<JobsBloc>()
                      .add(const JobsEvent.getFavoriteJob());
                });
              } else if (state.status == JobStatus.failure) {
                LoadingDialog.dismiss();
                LoadingDialog.showError(message: state.message);
              } else {
                LoadingDialog.dismiss();
              }
            },
          ),
          BlocListener<ProfileCandidateBloc, ProfileCandidateState>(
            listener: (context, state) {
              if (state.status == ProfileCandidateStatus.failure) {
                LoadingDialog.showError(message: state.message);
              }
            },
          ),
        ],
        child: PullToRefreshWidget(
          onRefresh: () async {
            context.read<JobsBloc>().add(const JobsEvent.getFavoriteJob());
            context
                .read<ProfileCandidateBloc>()
                .add(const ProfileCandidateEvent.getResume());
          },
          child: BlocBuilder<JobsBloc, JobsState>(
            builder: (context, state) {
              return state.favoriteJobs.isEmpty
                  ? SizedBox(
                      width: double.infinity,
                      height: MediaQuery.sizeOf(context).height,
                      child: SingleChildScrollView(
                        child: SizedBox(
                          height: MediaQuery.sizeOf(context).height,
                          child: Column(
                            mainAxisAlignment: MainAxisAlignment.center,
                            mainAxisSize: MainAxisSize.min,
                            children: [
                              SvgPicture.asset(AssetsConstant.illusJobEmpty),
                              const SpaceWidget(),
                              IText.set(
                                text: 'No Savings',
                                textAlign: TextAlign.left,
                                styleName: TextStyleName.medium,
                                typeName: TextTypeName.large,
                                color: AppColors.textPrimary,
                                lineHeight: 1.2.h,
                              ),
                              const SpaceWidget(),
                              IText.set(
                                text:
                                    'You don\'t have any favorite jobs saved, please\n find it in search to save jobs',
                                textAlign: TextAlign.center,
                                styleName: TextStyleName.regular,
                                typeName: TextTypeName.caption1,
                                color: AppColors.textPrimary100,
                              )
                            ],
                          ),
                        ),
                      ),
                    )
                  : ListView.builder(
                      padding: defaultPadding,
                      itemCount: state.favoriteJobs.length,
                      itemBuilder: (context, index) {
                        final data = state.favoriteJobs[index].job;
                        return Container(
                          width: double.infinity,
                          padding: defaultPadding,
                          margin: EdgeInsets.only(bottom: 16.h),
                          decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(8.r),
                            color: AppColors.bg200,
                            boxShadow: AppColors.defaultShadow,
                          ),
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              SizedBox(
                                width: double.infinity,
                                child: Row(
                                  mainAxisAlignment:
                                      MainAxisAlignment.spaceBetween,
                                  children: [
                                    Container(
                                      width: 40.w,
                                      height: 40.w,
                                      decoration: const BoxDecoration(
                                          shape: BoxShape.circle),
                                      child: ClipOval(
                                        child: CustomImageNetwork(
                                          imageUrl:
                                              data.company?.companyUrl ?? '',
                                          customErrorWidget: SvgPicture.asset(
                                            AssetsConstant.svgAssetsPicture,
                                          ),
                                        ),
                                      ),
                                    ),
                                    BlocBuilder<ProfileCandidateBloc,
                                        ProfileCandidateState>(
                                      builder: (context, profileState) {
                                        return PopupMenuButton(
                                          itemBuilder: (context) {
                                            return [
                                              PopupMenuItem(
                                                value: 'apply',
                                                child: IText.set(
                                                  text: 'Apply',
                                                  textAlign: TextAlign.left,
                                                  styleName:
                                                      TextStyleName.semiBold,
                                                  typeName:
                                                      TextTypeName.headline3,
                                                  color:
                                                      AppColors.textPrimary100,
                                                ),
                                              ),
                                              PopupMenuItem(
                                                value: 'delete',
                                                child: IText.set(
                                                  text: 'Delete',
                                                  textAlign: TextAlign.left,
                                                  styleName:
                                                      TextStyleName.semiBold,
                                                  typeName:
                                                      TextTypeName.headline3,
                                                  color:
                                                      AppColors.textPrimary100,
                                                ),
                                              ),
                                              PopupMenuItem(
                                                value: 'email',
                                                child: Row(
                                                  children: [
                                                    IText.set(
                                                      text: 'Email to friends',
                                                      textAlign: TextAlign.left,
                                                      styleName: TextStyleName
                                                          .semiBold,
                                                      typeName: TextTypeName
                                                          .headline3,
                                                      color: AppColors
                                                          .textPrimary100,
                                                    ),
                                                  ],
                                                ),
                                              ),
                                            ];
                                          },
                                          icon: const Icon(Icons.more_vert),
                                          onSelected: (value) async {
                                            switch (value) {
                                              case 'apply':
                                                if (profileState
                                                    .resumes.isEmpty) {
                                                  LoadingDialog.showError(
                                                    message:
                                                        'Please add your resume first before apply this job',
                                                  );
                                                  return;
                                                }
                                                AutoRouter.of(context).push(
                                                  ApplyJobRoute(
                                                    favoritJobId: state
                                                        .favoriteJobs[index].id,
                                                    jobId: data.id ?? 0,
                                                    jobTitle:
                                                        data.jobTitle ?? '',
                                                  ),
                                                );
                                                break;
                                              case 'delete':
                                                await showModalBottomSheet(
                                                  shape:
                                                      const RoundedRectangleBorder(
                                                    borderRadius:
                                                        BorderRadius.only(
                                                      topRight:
                                                          Radius.circular(32),
                                                      topLeft:
                                                          Radius.circular(32),
                                                    ),
                                                  ),
                                                  context: context,
                                                  builder: (context) {
                                                    return ConfirmDialogBottomSheet(
                                                      title:
                                                          'Remove Favorite Job ?',
                                                      caption:
                                                          'Are you sure you want to delete ${data.jobTitle}?',
                                                      onTapCancel: () =>
                                                          Navigator.pop(
                                                              context),
                                                      onTapContinue: () {
                                                        Navigator.pop(context);
                                                        context
                                                            .read<JobsBloc>()
                                                            .add(JobsEvent
                                                                .deleteFavoriteJob(
                                                              state
                                                                  .favoriteJobs[
                                                                      index]
                                                                  .id,
                                                            ));
                                                      },
                                                    );
                                                  },
                                                );
                                                break;
                                              default:
                                                await showDialog(
                                                  context: context,
                                                  builder: (context) {
                                                    return EmailToFriendDialogBottomSheet(
                                                      title: 'Email to Friend',
                                                      caption:
                                                          'Send this job to your friend',
                                                      jobId: data.id ?? 0,
                                                    );
                                                  },
                                                );
                                            }
                                          },
                                        );
                                      },
                                    )
                                  ],
                                ),
                              ),
                              const SpaceWidget(),
                              SizedBox(
                                width: double.infinity,
                                child: IText.set(
                                  text: data.jobTitle ?? '-',
                                  textAlign: TextAlign.left,
                                  styleName: TextStyleName.semiBold,
                                  typeName: TextTypeName.headline3,
                                  color: AppColors.textPrimary100,
                                ),
                              ),
                              Row(
                                children: [
                                  IText.set(
                                    text: data.company?.user?.firstName ?? '',
                                    textAlign: TextAlign.left,
                                    styleName: TextStyleName.bold,
                                    typeName: TextTypeName.headline2,
                                    color: AppColors.textPrimary100,
                                  ),
                                  SpaceWidget(
                                    direction: Direction.horizontal,
                                    space: 8.w,
                                  ),
                                  if (!GlobalHelper.isEmpty(
                                    data.jobShift,
                                  ))
                                    Container(
                                      padding: const EdgeInsets.all(8),
                                      decoration: BoxDecoration(
                                        borderRadius:
                                            BorderRadius.circular(8.r),
                                        color: AppColors.danger50,
                                      ),
                                      child: IText.set(
                                        text: data.jobShift?.shift ?? '',
                                        textAlign: TextAlign.left,
                                        styleName: TextStyleName.bold,
                                        typeName: TextTypeName.caption2,
                                        color: AppColors.danger100,
                                      ),
                                    ),
                                ],
                              ),
                              if (!GlobalHelper.isEmpty(
                                  data.company?.location)) ...[
                                SpaceWidget(
                                  space: 8.h,
                                ),
                                SizedBox(
                                  width: double.infinity,
                                  child: IText.set(
                                    text:
                                        '${data.company?.location ?? ''} ${data.company?.location2 ?? ''}',
                                    textAlign: TextAlign.left,
                                    styleName: TextStyleName.regular,
                                    typeName: TextTypeName.caption1,
                                    color: AppColors.textPrimary100,
                                  ),
                                ),
                              ],
                              if (!GlobalHelper.isEmptyList(data.jobsTag)) ...[
                                SpaceWidget(
                                  space: 8.h,
                                ),
                                SizedBox(
                                  width: double.infinity,
                                  child: Wrap(
                                    children: List.generate(
                                      data.jobsTag!.length > 2
                                          ? 3
                                          : data.jobsTag!.length,
                                      (i) => Container(
                                        decoration: BoxDecoration(
                                          color: AppColors.bg300,
                                          boxShadow: AppColors.defaultShadow,
                                          borderRadius: BorderRadius.circular(
                                            8.r,
                                          ),
                                        ),
                                        margin: EdgeInsets.only(
                                            right: 8.w, bottom: 8.w),
                                        padding: const EdgeInsets.all(8),
                                        child: IText.set(
                                          text: data.jobsTag![i].name,
                                          textAlign: TextAlign.left,
                                          styleName: TextStyleName.regular,
                                          typeName: TextTypeName.caption2,
                                          color: AppColors.textPrimary,
                                        ),
                                      ),
                                    ).toList(),
                                  ),
                                ),
                              ],
                              if (!(data.hideSalary ?? true)) ...[
                                SpaceWidget(
                                  space: 8.h,
                                ),
                                Row(
                                  children: [
                                    IText.set(
                                      text: data.currency?.currencyIcon ?? '',
                                      textAlign: TextAlign.left,
                                      styleName: TextStyleName.regular,
                                      typeName: TextTypeName.caption1,
                                      color: AppColors.textPrimary,
                                    ),
                                    SpaceWidget(
                                      direction: Direction.horizontal,
                                      space: 4.w,
                                    ),
                                    IText.set(
                                      text: (data.salaryFrom ?? 0).toString(),
                                      textAlign: TextAlign.left,
                                      styleName: TextStyleName.regular,
                                      typeName: TextTypeName.caption1,
                                      color: AppColors.textPrimary,
                                    ),
                                    IText.set(
                                      text: '-',
                                      textAlign: TextAlign.left,
                                      styleName: TextStyleName.regular,
                                      typeName: TextTypeName.caption1,
                                      color: AppColors.textPrimary,
                                    ),
                                    IText.set(
                                      text: (data.salaryTo ?? 0).toString(),
                                      textAlign: TextAlign.left,
                                      styleName: TextStyleName.regular,
                                      typeName: TextTypeName.caption1,
                                      color: AppColors.textPrimary,
                                    )
                                  ],
                                ),
                              ],
                              const SpaceWidget(),
                              Row(
                                children: [
                                  Icon(
                                    Icons.history,
                                    size: 18.sp,
                                    color: AppColors.neutral50,
                                  ),
                                  SpaceWidget(
                                    direction: Direction.horizontal,
                                    space: 4.w,
                                  ),
                                  IText.set(
                                    text: timeago.format(
                                      DateTime.parse(data.createdAt!),
                                    ),
                                    textAlign: TextAlign.left,
                                    styleName: TextStyleName.regular,
                                    typeName: TextTypeName.caption2,
                                    color: AppColors.neutral50,
                                  ),
                                ],
                              )
                            ],
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
