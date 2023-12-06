import 'package:auto_route/auto_route.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_html/flutter_html.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:qatjobs/core/auto_route/auto_route.gr.dart';
import 'package:qatjobs/core/constant/assets_constant.dart';
import 'package:qatjobs/core/helpers/global_helper.dart';
import 'package:qatjobs/core/helpers/url_launcher_helper.dart';
import 'package:qatjobs/core/styles/color_name_style.dart';
import 'package:qatjobs/core/styles/resolution_style.dart';
import 'package:qatjobs/core/styles/text_name_style.dart';
import 'package:qatjobs/core/widget/custom_appbar_widget.dart';
import 'package:qatjobs/core/widget/custom_cached_image_network.dart';
import 'package:qatjobs/core/widget/loading_dialog_widget.dart';
import 'package:qatjobs/core/widget/section_title_widget.dart';
import 'package:qatjobs/core/widget/vertical_space_widget.dart';
import 'package:qatjobs/features/company/data/models/company_model.codegen.dart';
import 'package:qatjobs/features/company/domain/usecases/add_favorite_company_usecase.dart';
import 'package:qatjobs/features/company/presentations/bloc/company_bloc.dart';
import 'package:qatjobs/features/users/presentations/bloc/user_bloc.dart';
import 'package:zoom_tap_animation/zoom_tap_animation.dart';
import 'package:timeago/timeago.dart' as timeago;

class CompanyDetailPage extends StatefulWidget {
  const CompanyDetailPage({
    super.key,
    required this.company,
  });

  final CompanyModel company;

  @override
  State<CompanyDetailPage> createState() => _CompanyDetailPageState();
}

class _CompanyDetailPageState extends State<CompanyDetailPage> {
  @override
  void initState() {
    super.initState();
    context.read<CompanyBloc>().add(const CompanyEvent.getFavoriteCompany());
  }

  bool isFollowed = false;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.bg300,
      appBar: const CustomAppBar(
        title: 'Company Details',
        showLeading: true,
      ),
      body: Container(
        width: double.infinity,
        height: MediaQuery.sizeOf(context).height,
        padding: defaultPadding,
        child: SingleChildScrollView(
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
                child: Row(
                  children: [
                    Container(
                      width: 80.w,
                      height: 80.w,
                      decoration: BoxDecoration(
                        color: AppColors.success,
                        shape: BoxShape.circle,
                        boxShadow: AppColors.defaultShadow,
                      ),
                      child: Center(
                        child: ClipRRect(
                          borderRadius: defaultRadius,
                          child: CustomImageNetwork(
                            imageUrl: widget.company.companyUrl ?? '',
                            fit: BoxFit.cover,
                            width: 80.w,
                            customErrorWidget: SvgPicture.asset(
                              AssetsConstant.svgAssetsPicture,
                            ),
                          ),
                        ),
                      ),
                    ),
                    SizedBox(width: 8.w),
                    Expanded(
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          IText.set(
                            text: widget.company.user?.fullName ?? '',
                            styleName: TextStyleName.bold,
                            typeName: TextTypeName.headline3,
                            color: AppColors.textPrimary,
                          ),
                          BlocConsumer<CompanyBloc, CompanyState>(
                            listener: (context, state) {
                              if (state.status ==
                                  CompanyStatus.addFavoriteCompany) {
                                context.read<CompanyBloc>().add(
                                    const CompanyEvent.getFavoriteCompany());
                              } else if (state.status ==
                                  CompanyStatus.loading) {
                                LoadingDialog.show(message: 'Loading ...');
                              } else {
                                LoadingDialog.dismiss();
                              }
                            },
                            builder: (context, state) {
                              return const SizedBox();
                            },
                          ),
                        ],
                      ),
                    ),
                    BlocBuilder<CompanyBloc, CompanyState>(
                      builder: (context, state) {
                        isFollowed = state.favoriteCompanies
                            .any((element) => element.id == widget.company.id);
                        return BlocBuilder<UserBloc, UserState>(
                          builder: (context, userState) {
                            return TextButton(
                              onPressed: () {
                                if (userState.user == null ||
                                    userState.user?.id == null ||
                                    userState.user?.id == 0) {
                                  AutoRouter.of(context)
                                      .push(const LoginRoute());
                                  return;
                                } else {
                                  context.read<CompanyBloc>().add(
                                        CompanyEvent.addFavoriteCompany(
                                          AddFavoriteCompanyRequestParams(
                                            userId: userState.user?.id ?? 0,
                                            companyId: widget.company.id ?? 0,
                                          ),
                                        ),
                                      );
                                }
                              },
                              child: Row(
                                children: [
                                  Icon(
                                      isFollowed
                                          ? Icons.favorite
                                          : Icons.favorite_border,
                                      color: isFollowed
                                          ? AppColors.danger100
                                          : AppColors.textPrimary100)
                                ],
                              ),
                            );
                          },
                        );
                      },
                    ),
                  ],
                ),
              ),
              const SpaceWidget(),
              Container(
                padding: defaultPadding,
                decoration: BoxDecoration(
                  borderRadius: defaultRadius,
                  boxShadow: AppColors.defaultShadow,
                  color: AppColors.bg200,
                ),
                child: Column(
                  children: [
                    const Padding(
                      padding:
                          EdgeInsets.symmetric(horizontal: 8, vertical: 16),
                      child: SectionTitleWidget(title: 'About Company'),
                    ),
                    Html(
                      data: widget.company.details ?? '-',
                    ),
                  ],
                ),
              ),
              const SpaceWidget(),
              Container(
                padding: defaultPadding,
                decoration: BoxDecoration(
                  borderRadius: defaultRadius,
                  boxShadow: AppColors.defaultShadow,
                  color: AppColors.bg200,
                ),
                child: Column(
                  children: [
                    const Padding(
                      padding: EdgeInsets.symmetric(
                        horizontal: 8,
                        vertical: 16,
                      ),
                      child: SectionTitleWidget(title: 'Contact'),
                    ),
                    _CompanyContactItem(
                      icon: FaIcon(
                        FontAwesomeIcons.phone,
                        color: AppColors.warning,
                        size: 28.sp,
                      ),
                      title: 'Phone',
                      value: widget.company.user?.phone ?? '',
                    ),
                    const SpaceWidget(),
                    _CompanyContactItem(
                      icon: FaIcon(
                        FontAwesomeIcons.locationPin,
                        color: AppColors.warning,
                        size: 28.sp,
                      ),
                      title: 'Location',
                      value: widget.company.location ?? '',
                    ),
                    const SpaceWidget(),
                    _CompanyContactItem(
                      icon: FaIcon(
                        FontAwesomeIcons.globe,
                        color: AppColors.warning,
                        size: 28.sp,
                      ),
                      title: 'Website',
                      value: widget.company.website ?? '',
                      onTap: () async {
                        if (!GlobalHelper.isEmpty(widget.company.website)) {
                          await UrlLauncherHelper.openUrl(
                            widget.company.website!,
                          );
                        }
                      },
                    ),
                    const SpaceWidget(),
                    _CompanyContactItem(
                      icon: FaIcon(
                        FontAwesomeIcons.envelope,
                        color: AppColors.warning,
                        size: 28.sp,
                      ),
                      title: 'Email',
                      value: widget.company.user?.email ?? '',
                    )
                  ],
                ),
              ),
              const SpaceWidget(),
              Container(
                padding: defaultPadding,
                decoration: BoxDecoration(
                  borderRadius: defaultRadius,
                  boxShadow: AppColors.defaultShadow,
                  color: AppColors.bg200,
                ),
                child: Column(
                  children: [
                    const Padding(
                      padding: EdgeInsets.symmetric(
                        horizontal: 8,
                        vertical: 16,
                      ),
                      child: SectionTitleWidget(title: 'Social Media'),
                    ),
                    _CompanyContactItem(
                      icon: FaIcon(
                        FontAwesomeIcons.facebook,
                        color: AppColors.warning,
                        size: 28.sp,
                      ),
                      title: 'Facebook',
                      value: widget.company.user?.facebookUrl ?? '',
                    ),
                    const SpaceWidget(),
                    _CompanyContactItem(
                      icon: FaIcon(
                        FontAwesomeIcons.linkedin,
                        color: AppColors.warning,
                        size: 28.sp,
                      ),
                      title: 'Linkedin',
                      value: widget.company.user?.linkedinUrl ?? '',
                    ),
                    const SpaceWidget(),
                    _CompanyContactItem(
                      icon: FaIcon(
                        FontAwesomeIcons.twitter,
                        color: AppColors.warning,
                        size: 28.sp,
                      ),
                      title: 'Twitter',
                      value: widget.company.user?.twitterUrl ?? '',
                    ),
                    const SpaceWidget(),
                    _CompanyContactItem(
                      icon: FaIcon(
                        FontAwesomeIcons.googlePlus,
                        color: AppColors.warning,
                        size: 28.sp,
                      ),
                      title: 'Google+',
                      value: widget.company.user?.googlePlusUrl ?? '',
                    ),
                    const SpaceWidget(),
                    _CompanyContactItem(
                      icon: FaIcon(
                        FontAwesomeIcons.pinterest,
                        color: AppColors.warning,
                        size: 28.sp,
                      ),
                      title: 'Pinterest',
                      value: widget.company.user?.pinterestUrl ?? '',
                    )
                  ],
                ),
              ),
              if (!GlobalHelper.isEmptyList(widget.company.jobs)) ...[
                const SpaceWidget(),
                const Padding(
                  padding: EdgeInsets.symmetric(
                    horizontal: 8,
                    vertical: 16,
                  ),
                  child: SectionTitleWidget(title: 'Latest Jobs'),
                ),
                ListView.builder(
                  physics: const NeverScrollableScrollPhysics(),
                  itemCount: widget.company.jobs?.length,
                  shrinkWrap: true,
                  itemBuilder: (context, index) {
                    final data = widget.company.jobs?[index];
                    return ZoomTapAnimation(
                      onTap: () {
                        AutoRouter.of(context)
                            .push(JobDetailRoute(jobModel: data));
                      },
                      child: Container(
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
                                children: [
                                  Container(
                                    width: 40.w,
                                    height: 40.w,
                                    decoration: const BoxDecoration(
                                        shape: BoxShape.circle),
                                    child: ClipOval(
                                      child: CustomImageNetwork(
                                        imageUrl:
                                            data?.company?.companyUrl ?? '',
                                      ),
                                    ),
                                  ),
                                  const SpaceWidget(
                                      direction: Direction.horizontal),
                                  Expanded(
                                    child: Row(
                                      children: [
                                        IText.set(
                                          text:
                                              data?.company?.user?.firstName ??
                                                  '',
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
                                          data?.jobShift,
                                        ))
                                          Container(
                                            padding: const EdgeInsets.all(8),
                                            decoration: BoxDecoration(
                                              borderRadius:
                                                  BorderRadius.circular(8.r),
                                              color: AppColors.danger50,
                                            ),
                                            child: IText.set(
                                              text: data?.jobShift?.shift ?? '',
                                              textAlign: TextAlign.left,
                                              styleName: TextStyleName.bold,
                                              typeName: TextTypeName.caption2,
                                              color: AppColors.danger100,
                                            ),
                                          ),
                                      ],
                                    ),
                                  ),
                                ],
                              ),
                            ),
                            const SpaceWidget(),
                            SizedBox(
                              width: double.infinity,
                              child: IText.set(
                                text: data?.jobTitle ?? '-',
                                textAlign: TextAlign.left,
                                styleName: TextStyleName.semiBold,
                                typeName: TextTypeName.headline3,
                                color: AppColors.textPrimary100,
                              ),
                            ),
                            if (!GlobalHelper.isEmpty(
                                data?.company?.location)) ...[
                              SpaceWidget(
                                space: 8.h,
                              ),
                              SizedBox(
                                width: double.infinity,
                                child: IText.set(
                                  text:
                                      '${data?.company?.location ?? ''} ${data?.company?.location2 ?? ''}',
                                  textAlign: TextAlign.left,
                                  styleName: TextStyleName.regular,
                                  typeName: TextTypeName.caption1,
                                  color: AppColors.textPrimary100,
                                ),
                              ),
                            ],
                            if (!GlobalHelper.isEmptyList(data?.jobsTag)) ...[
                              SpaceWidget(
                                space: 8.h,
                              ),
                              SizedBox(
                                width: double.infinity,
                                child: Wrap(
                                  children: List.generate(
                                    data!.jobsTag!.length > 2
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
                            if (!(data!.hideSalary ?? true)) ...[
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
                      ),
                    );
                  },
                )
              ],
            ],
          ),
        ),
      ),
    );
  }
}

class _CompanyContactItem extends StatelessWidget {
  const _CompanyContactItem({
    required this.icon,
    required this.title,
    required this.value,
    this.onTap,
  });

  final FaIcon icon;
  final String title;
  final String value;
  final VoidCallback? onTap;

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        SizedBox(
          width: double.infinity,
          child: Row(
            children: [
              icon,
              SizedBox(width: 8.w),
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  IText.set(
                    text: title,
                    styleName: TextStyleName.regular,
                    typeName: TextTypeName.headline3,
                    color: AppColors.textPrimary100,
                  ),
                  ZoomTapAnimation(
                    onTap: onTap,
                    child: Row(
                      children: [
                        IText.set(
                          text: value,
                          styleName: TextStyleName.bold,
                          typeName: TextTypeName.headline3,
                          color: AppColors.textPrimary,
                        ),
                        if (onTap != null) ...[
                          SizedBox(width: 8.w),
                          FaIcon(
                            FontAwesomeIcons.externalLink,
                            size: 16.sp,
                          )
                        ],
                      ],
                    ),
                  ),
                ],
              ),
            ],
          ),
        )
      ],
    );
  }
}
