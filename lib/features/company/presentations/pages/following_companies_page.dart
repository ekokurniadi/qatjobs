import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:qatjobs/core/constant/assets_constant.dart';
import 'package:qatjobs/core/helpers/global_helper.dart';
import 'package:qatjobs/core/styles/color_name_style.dart';
import 'package:qatjobs/core/styles/resolution_style.dart';
import 'package:qatjobs/core/styles/text_name_style.dart';
import 'package:qatjobs/core/widget/custom_appbar_widget.dart';
import 'package:qatjobs/core/widget/custom_cached_image_network.dart';
import 'package:qatjobs/core/widget/shimmer_box_widget.dart';
import 'package:qatjobs/core/widget/vertical_space_widget.dart';
import 'package:qatjobs/core/widget/widget_chip.dart';
import 'package:qatjobs/features/company/presentations/bloc/company_bloc.dart';
import 'package:qatjobs/features/company/presentations/pages/company_detail_page.dart';
import 'package:zoom_tap_animation/zoom_tap_animation.dart';

class FollowingCompanyPage extends StatefulWidget {
  const FollowingCompanyPage({super.key});

  @override
  State<FollowingCompanyPage> createState() => _FollowingCompanyPageState();
}

class _FollowingCompanyPageState extends State<FollowingCompanyPage> {
  @override
  void initState() {
    context.read<CompanyBloc>().add(const CompanyEvent.getFavoriteCompany());
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.bg300,
      appBar: const CustomAppBar(
        title: 'Following Companies',
        showLeading: true,
      ),
      body: Container(
        width: double.infinity,
        height: MediaQuery.sizeOf(context).height,
        padding: defaultPadding,
        child: Column(
          children: [
            BlocBuilder<CompanyBloc, CompanyState>(
              builder: (context, state) {
                return Flexible(
                  child: state.favoriteCompanies.isEmpty
                      ? SizedBox(
                          width: double.infinity,
                          height: MediaQuery.sizeOf(context).height,
                          child: Column(
                            mainAxisAlignment: MainAxisAlignment.center,
                            crossAxisAlignment: CrossAxisAlignment.center,
                            mainAxisSize: MainAxisSize.min,
                            children: [
                              SvgPicture.asset(AssetsConstant.illusJobEmpty),
                              const SpaceWidget(),
                              IText.set(
                                text: 'No Following Company found',
                                textAlign: TextAlign.left,
                                styleName: TextStyleName.medium,
                                typeName: TextTypeName.large,
                                color: AppColors.textPrimary,
                                lineHeight: 1.2.h,
                              ),
                              const SpaceWidget(),
                              IText.set(
                                text: 'Please follow your favorite company',
                                textAlign: TextAlign.center,
                                styleName: TextStyleName.regular,
                                typeName: TextTypeName.caption1,
                                color: AppColors.textPrimary100,
                              )
                            ],
                          ),
                        )
                      : ListView.builder(
                          itemCount: state.favoriteCompanies.length,
                          itemBuilder: (context, index) {
                            final data = state.favoriteCompanies[index];
                            return ZoomTapAnimation(
                              onTap: () {
                                Navigator.push(
                                  context,
                                  MaterialPageRoute(
                                    builder: (context) {
                                      return CompanyDetailPage(
                                        company: data,
                                      );
                                    },
                                  ),
                                );
                              },
                              child: Container(
                                width: MediaQuery.sizeOf(context).width,
                                padding: const EdgeInsets.all(16),
                                margin: EdgeInsets.symmetric(
                                  horizontal: 1.w,
                                  vertical: 8.h,
                                ),
                                decoration: BoxDecoration(
                                  borderRadius: BorderRadius.circular(8.r),
                                  color: AppColors.bg200,
                                  boxShadow: const [
                                    BoxShadow(
                                      color: AppColors.neutral,
                                      spreadRadius: 0.1,
                                      blurRadius: 0.1,
                                    ),
                                    BoxShadow(
                                      color: AppColors.neutral,
                                      spreadRadius: 0.1,
                                      blurRadius: 0.1,
                                    )
                                  ],
                                ),
                                child: Row(
                                  children: [
                                    if (state.status ==
                                        CompanyStatus.loading) ...[
                                      ShimmerBoxWidget(
                                          width: 80.w, height: 80.w),
                                      SizedBox(width: 16.w),
                                      Column(
                                        crossAxisAlignment:
                                            CrossAxisAlignment.start,
                                        mainAxisAlignment:
                                            MainAxisAlignment.center,
                                        children: [
                                          ShimmerBoxWidget(
                                            width: 200.w,
                                            height: 20,
                                          ),
                                          const SpaceWidget(),
                                          SizedBox(
                                            width: MediaQuery.sizeOf(context)
                                                    .width *
                                                0.60,
                                            child: Row(
                                              crossAxisAlignment:
                                                  CrossAxisAlignment.start,
                                              children: [
                                                const Expanded(
                                                  child: ShimmerBoxWidget(
                                                    width: double.infinity,
                                                    height: 20,
                                                  ),
                                                ),
                                                SizedBox(width: 8.w),
                                              ],
                                            ),
                                          ),
                                          const SpaceWidget(),
                                          const ShimmerBoxWidget(
                                            width: 100,
                                            height: 20,
                                          ),
                                        ],
                                      )
                                    ] else ...[
                                      if (!GlobalHelper.isEmptyList(
                                          state.favoriteCompanies)) ...[
                                        SizedBox(
                                          width: 80.w,
                                          height: 80.w,
                                          child: ClipRRect(
                                            borderRadius: defaultRadius,
                                            child: CustomImageNetwork(
                                              width: 80.w,
                                              fit: BoxFit.cover,
                                              imageUrl: data.companyUrl ?? '',
                                              customErrorWidget:
                                                  SvgPicture.asset(
                                                AssetsConstant.svgAssetsPicture,
                                              ),
                                            ),
                                          ),
                                        ),
                                        SizedBox(width: 16.w),
                                        Expanded(
                                          child: Column(
                                            crossAxisAlignment:
                                                CrossAxisAlignment.start,
                                            mainAxisAlignment:
                                                MainAxisAlignment.center,
                                            children: [
                                              IText.set(
                                                text: data.user?.fullName ?? '',
                                                styleName: TextStyleName.bold,
                                                typeName:
                                                    TextTypeName.headline3,
                                                color: AppColors.textPrimary,
                                              ),
                                              SizedBox(
                                                height: 8.h,
                                              ),
                                              WidgetChip(
                                                content:
                                                    '${data.jobs?.length ?? 0} Open Position',
                                              ),
                                            ],
                                          ),
                                        ),
                                      ],
                                    ],
                                  ],
                                ),
                              ),
                            );
                          },
                        ),
                );
              },
            )
          ],
        ),
      ),
    );
  }
}
