import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:qatjobs/core/helpers/date_helper.dart';
import 'package:qatjobs/core/styles/color_name_style.dart';
import 'package:qatjobs/core/styles/resolution_style.dart';
import 'package:qatjobs/core/styles/text_name_style.dart';
import 'package:qatjobs/core/widget/custom_appbar_widget.dart';
import 'package:qatjobs/core/widget/custom_cached_image_network.dart';
import 'package:qatjobs/core/widget/loading_dialog_widget.dart';
import 'package:qatjobs/core/widget/section_title_widget.dart';
import 'package:qatjobs/core/widget/vertical_space_widget.dart';
import 'package:qatjobs/features/article/data/models/article_model.codegen.dart';
import 'package:flutter_html/flutter_html.dart';
import 'package:qatjobs/features/article/presentations/bloc/bloc/article_bloc.dart';
import 'package:qatjobs/injector.dart';

class ArticleDetailPage extends StatelessWidget {
  const ArticleDetailPage({
    super.key,
    required this.articleModel,
  });
  final ArticleModel? articleModel;

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => getIt<ArticleBloc>()
        ..add(
          ArticleEvent.getDetailArticle(articleModel?.id ?? 0),
        ),
      child: BlocListener<ArticleBloc, ArticleState>(
        listener: (context, state) {
          if (state.status == ArticleStatus.failure) {
            LoadingDialog.showError(message: state.message);
          }
        },
        child: Scaffold(
          backgroundColor: AppColors.bg300,
          appBar: const CustomAppBar(
            title: 'Article Detail',
            showLeading: true,
          ),
          body: Padding(
            padding: defaultPadding,
            child: SingleChildScrollView(
              child: Column(
                children: [
                  SizedBox(
                    width: double.infinity,
                    child: IText.set(
                        text: articleModel?.title ?? '',
                        styleName: TextStyleName.bold,
                        typeName: TextTypeName.headline2,
                        color: AppColors.textPrimary,
                        textAlign: TextAlign.left),
                  ),
                  const SpaceWidget(),
                  Row(
                    children: [
                      Container(
                        width: 40.w,
                        height: 40.w,
                        decoration: BoxDecoration(
                          boxShadow: AppColors.defaultShadow,
                          color: AppColors.bg200,
                          borderRadius: defaultRadius,
                        ),
                        child: ClipRRect(
                          borderRadius: defaultRadius,
                          child: CustomImageNetwork(
                            imageUrl: articleModel?.user.avatar ?? '',
                            fit: BoxFit.cover,
                          ),
                        ),
                      ),
                      const SpaceWidget(
                        direction: Direction.horizontal,
                      ),
                      IText.set(
                        text: articleModel?.user.fullName ?? '',
                        styleName: TextStyleName.regular,
                        typeName: TextTypeName.caption1,
                        color: AppColors.textPrimary100,
                        textAlign: TextAlign.center,
                      ),
                      SpaceWidget(
                        direction: Direction.horizontal,
                        space: 8.w,
                      ),
                      IText.set(
                        text: '|',
                        styleName: TextStyleName.regular,
                        typeName: TextTypeName.caption1,
                        color: AppColors.danger100,
                        textAlign: TextAlign.center,
                      ),
                      SpaceWidget(
                        direction: Direction.horizontal,
                        space: 8.w,
                      ),
                      IText.set(
                        text:
                            DateHelper.formatdMy(articleModel?.createdAt ?? ''),
                        styleName: TextStyleName.regular,
                        typeName: TextTypeName.caption1,
                        color: AppColors.textPrimary100,
                        textAlign: TextAlign.center,
                      ),
                    ],
                  ),
                  const Divider(),
                  const SpaceWidget(),
                  SizedBox(
                    width: double.infinity,
                    height: 250.h,
                    child: ClipRRect(
                      borderRadius: defaultRadius,
                      child: CustomImageNetwork(
                        imageUrl: articleModel?.blogImageUrl ?? '',
                        fit: BoxFit.cover,
                      ),
                    ),
                  ),
                  const SpaceWidget(),
                  SizedBox(
                    width: double.infinity,
                    child: Wrap(
                      children: List.generate(
                        (articleModel?.postAssignCategories ?? []).length,
                        (index) => Container(
                          decoration: BoxDecoration(
                            color: AppColors.secondary,
                            boxShadow: AppColors.defaultShadow,
                            borderRadius: BorderRadius.circular(
                              8.r,
                            ),
                          ),
                          margin: EdgeInsets.only(right: 8.w, bottom: 8.w),
                          padding: const EdgeInsets.all(8),
                          child: IText.set(
                            text: articleModel?.postAssignCategories[index]
                                ['name'],
                            textAlign: TextAlign.left,
                            styleName: TextStyleName.regular,
                            typeName: TextTypeName.caption2,
                            color: AppColors.textPrimary,
                          ),
                        ),
                      ),
                    ),
                  ),
                  const SpaceWidget(),
                  Html(
                    data: articleModel?.description,
                  ),
                  const SpaceWidget(),
                  BlocBuilder<ArticleBloc, ArticleState>(
                    builder: (context, state) {
                      return SectionTitleWidget(
                        title:
                            'Comments (${(state.articleDetail?.comments ?? []).length})',
                      );
                    },
                  ),
                  const SpaceWidget(),
                  BlocBuilder<ArticleBloc, ArticleState>(
                    builder: (context, state) {
                      return ListView.separated(
                        separatorBuilder: (context, index) =>
                            const SpaceWidget(),
                        physics: const NeverScrollableScrollPhysics(),
                        shrinkWrap: true,
                        itemCount: (state.articleDetail?.comments ?? []).length,
                        itemBuilder: (context, index) {
                          return Container(
                            width: double.infinity,
                            padding: defaultPadding,
                            decoration: BoxDecoration(
                              boxShadow: AppColors.defaultShadow,
                              color: AppColors.bg200,
                              borderRadius: defaultRadius,
                            ),
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.start,
                              children: [
                                Icon(
                                  Icons.person_pin,
                                  size: 32.sp,
                                ),
                                SizedBox(width: 16.w),
                                Expanded(
                                  child: Row(
                                    children: [
                                      Expanded(
                                        child: Column(
                                          mainAxisAlignment:
                                              MainAxisAlignment.start,
                                          crossAxisAlignment:
                                              CrossAxisAlignment.start,
                                          children: [
                                            IText.set(
                                              text: state.articleDetail
                                                  ?.comments?[index]['name'],
                                              textAlign: TextAlign.left,
                                              styleName: TextStyleName.bold,
                                              typeName: TextTypeName.caption1,
                                              color: AppColors.textPrimary,
                                            ),
                                            IText.set(
                                              text: state.articleDetail
                                                  ?.comments?[index]['comment'],
                                              textAlign: TextAlign.left,
                                              styleName: TextStyleName.regular,
                                              typeName: TextTypeName.caption2,
                                              color: AppColors.textPrimary,
                                            ),
                                          ],
                                        ),
                                      ),
                                      Expanded(
                                        child: IText.set(
                                          text: DateHelper.formatdMy(
                                            state.articleDetail
                                                    ?.comments?[index]
                                                ['created_at'],
                                          ),
                                          textAlign: TextAlign.right,
                                          styleName: TextStyleName.regular,
                                          typeName: TextTypeName.caption2,
                                          color: AppColors.textPrimary,
                                        ),
                                      )
                                    ],
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
