import 'package:auto_route/auto_route.dart';
import 'package:collection/collection.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:lazy_load_scrollview/lazy_load_scrollview.dart';
import 'package:oktoast/oktoast.dart';
import 'package:qatjobs/core/auto_route/auto_route.gr.dart';
import 'package:qatjobs/core/constant/assets_constant.dart';
import 'package:qatjobs/core/models/paging_request_params.codegen.dart';
import 'package:qatjobs/core/styles/color_name_style.dart';
import 'package:qatjobs/core/styles/resolution_style.dart';
import 'package:qatjobs/core/styles/text_name_style.dart';
import 'package:qatjobs/core/widget/custom_appbar_widget.dart';
import 'package:qatjobs/core/widget/loading_dialog_widget.dart';
import 'package:qatjobs/core/widget/pull_to_refresh_widget.dart';
import 'package:qatjobs/core/widget/section_title_widget.dart';
import 'package:qatjobs/core/widget/shimmer_box_widget.dart';
import 'package:qatjobs/core/widget/vertical_space_widget.dart';
import 'package:qatjobs/features/article/presentations/bloc/bloc/article_bloc.dart';
import 'package:qatjobs/features/article/presentations/widgets/article_card_item.dart';
import 'package:qatjobs/features/article_category/presentations/bloc/bloc/article_category_bloc.dart';
import 'package:qatjobs/injector.dart';
import 'package:zoom_tap_animation/zoom_tap_animation.dart';

class ArticleListPage extends StatefulWidget {
  const ArticleListPage({super.key});

  @override
  State<ArticleListPage> createState() => _ArticleListPageState();
}

class _ArticleListPageState extends State<ArticleListPage> {
  late ArticleCategoryBloc articleCategoryBloc;
  late ArticleBloc articleBloc;
  final ValueNotifier<int> selectedCategory = ValueNotifier(0);

  @override
  void initState() {
    articleCategoryBloc = getIt<ArticleCategoryBloc>();
    articleBloc = getIt<ArticleBloc>();
    articleCategoryBloc.add(
      const ArticleCategoryEvent.started(),
    );
    articleBloc.add(ArticleEvent.getArticle(PagingRequestParams()));
    super.initState();
  }

  void getArticle() {
    if (selectedCategory.value == 0) {
      articleBloc.add(
        ArticleEvent.getArticle(
          PagingRequestParams(),
        ),
      );
    } else {
      articleBloc.add(
        ArticleEvent.getArticleByCategory(
          PagingRequestParams(
            id: selectedCategory.value == 0 ? null : selectedCategory.value,
          ),
        ),
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      resizeToAvoidBottomInset: false,
      backgroundColor: AppColors.bg300,
      appBar: const CustomAppBar(title: 'Article'),
      body: MultiBlocProvider(
        providers: [
          BlocProvider(
            create: (context) => articleBloc,
          ),
          BlocProvider(
            create: (context) => articleCategoryBloc,
          ),
        ],
        child: MultiBlocListener(
          listeners: [
            BlocListener<ArticleBloc, ArticleState>(
              listener: (context, state) {
                if (state.status == ArticleStatus.failure) {
                   LoadingDialog.showError(message: state.message);
                }
              },
            ),
            BlocListener<ArticleCategoryBloc, ArticleCategoryState>(
              listener: (context, state) {
                if (state.status == ArticleCategoryStatus.failure) {
                   LoadingDialog.showError(message: state.message);
                }
              },
            ),
          ],
          child: PullToRefreshWidget(
            onRefresh: () async {
              articleCategoryBloc.add(
                const ArticleCategoryEvent.started(),
              );
              getArticle();
            },
            child: SingleChildScrollView(
              child: SizedBox(
                width: double.infinity,
                height: MediaQuery.sizeOf(context).height,
                child: Padding(
                  padding: defaultPadding,
                  child: Column(
                    children: [
                      const SectionTitleWidget(title: 'Category'),
                      const SpaceWidget(),
                      SizedBox(
                        width: double.infinity,
                        height: 50.h,
                        child: BlocBuilder<ArticleCategoryBloc,
                            ArticleCategoryState>(
                          builder: (context, state) {
                            return ListView.builder(
                              scrollDirection: Axis.horizontal,
                              itemCount:
                                  state.status == ArticleCategoryStatus.loading
                                      ? 5
                                      : state.articleCategories.length,
                              itemBuilder: (context, index) {
                                if (state.status ==
                                    ArticleCategoryStatus.loading) {
                                  return Container(
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
                                    child: ShimmerBoxWidget(
                                      width: 80.w,
                                      height: 10.h,
                                    ),
                                  );
                                } else {
                                  return ZoomTapAnimation(
                                    onTap: () {
                                      selectedCategory.value =
                                          state.articleCategories[index].id;
                                      getArticle();
                                    },
                                    child: ValueListenableBuilder(
                                        valueListenable: selectedCategory,
                                        builder: (context, selected, _) {
                                          return Container(
                                            decoration: BoxDecoration(
                                              color: selected ==
                                                      state
                                                          .articleCategories[
                                                              index]
                                                          .id
                                                  ? AppColors.secondary
                                                  : AppColors.bg200,
                                              boxShadow:
                                                  AppColors.defaultShadow,
                                              borderRadius:
                                                  BorderRadius.circular(
                                                8.r,
                                              ),
                                            ),
                                            margin: EdgeInsets.only(
                                                right: 8.w, bottom: 8.w),
                                            padding: const EdgeInsets.all(8),
                                            child: Center(
                                              child: IText.set(
                                                text: state
                                                    .articleCategories[index]
                                                    .name,
                                                textAlign: TextAlign.left,
                                                styleName: selected ==
                                                        state
                                                            .articleCategories[
                                                                index]
                                                            .id
                                                    ? TextStyleName.bold
                                                    : TextStyleName.regular,
                                                typeName: TextTypeName.caption2,
                                                color: AppColors.textPrimary,
                                              ),
                                            ),
                                          );
                                        }),
                                  );
                                }
                              },
                            );
                          },
                        ),
                      ),
                      const SpaceWidget(),
                      const SectionTitleWidget(title: 'Article List'),
                      const SpaceWidget(),
                      Flexible(
                        child: BlocBuilder<ArticleBloc, ArticleState>(
                          builder: (context, state) {
                            return (state.isByCategory
                                        ? state.articlesByCategory.isEmpty
                                        : state.articles.isEmpty &&
                                            state.status !=
                                                ArticleStatus.loading) ||
                                    state.status == ArticleStatus.failure
                                ? BlocBuilder<ArticleCategoryBloc,
                                        ArticleCategoryState>(
                                    builder: (context, state) {
                                    return Column(
                                      mainAxisAlignment:
                                          MainAxisAlignment.start,
                                      crossAxisAlignment:
                                          CrossAxisAlignment.center,
                                      mainAxisSize: MainAxisSize.max,
                                      children: [
                                        SpaceWidget(
                                          space: MediaQuery.sizeOf(context)
                                                  .height *
                                              0.15,
                                        ),
                                        SvgPicture.asset(
                                            AssetsConstant.illusJobEmpty),
                                        const SpaceWidget(),
                                        IText.set(
                                          text: 'Article is empty',
                                          textAlign: TextAlign.left,
                                          styleName: TextStyleName.medium,
                                          typeName: TextTypeName.large,
                                          color: AppColors.textPrimary,
                                          lineHeight: 1.2.h,
                                        ),
                                        if (selectedCategory.value != 0) ...[
                                          const SpaceWidget(),
                                          IText.set(
                                            text:
                                                'Article with category name ${state.articleCategories.firstWhereOrNull((element) => element.id == selectedCategory.value)?.name ?? ''} not found, please select another category',
                                            textAlign: TextAlign.center,
                                            styleName: TextStyleName.regular,
                                            typeName: TextTypeName.caption1,
                                            color: AppColors.textPrimary100,
                                          )
                                        ],
                                      ],
                                    );
                                  })
                                : LazyLoadScrollView(
                                    onEndOfPage: () {
                                      if (!state.hasMaxReached) {
                                        if (selectedCategory.value == 0) {
                                          articleBloc.add(
                                            ArticleEvent.getArticle(
                                              PagingRequestParams(
                                                page: state.currentPage + 1,
                                              ),
                                            ),
                                          );
                                        } else {
                                          articleBloc.add(
                                            ArticleEvent.getArticleByCategory(
                                              PagingRequestParams(
                                                id: selectedCategory.value,
                                                page: state.currentPage + 1,
                                              ),
                                            ),
                                          );
                                        }
                                      }
                                    },
                                    child: ListView.builder(
                                      padding: EdgeInsets.only(bottom: 150.h),
                                      shrinkWrap: true,
                                      itemCount: state.status ==
                                                  ArticleStatus.loading &&
                                              (state.isByCategory
                                                  ? state.articlesByCategory
                                                      .isEmpty
                                                  : state.articles.isEmpty)
                                          ? 3
                                          : state.isByCategory
                                              ? state.articlesByCategory.length
                                              : state.articles.length,
                                      primary: true,
                                      itemBuilder: (context, index) {
                                        if (state.status ==
                                                ArticleStatus.loading &&
                                            (state.isByCategory
                                                ? state
                                                    .articlesByCategory.isEmpty
                                                : state.articles.isEmpty)) {
                                          return Container(
                                            padding: defaultPadding,
                                            margin:
                                                EdgeInsets.only(bottom: 16.h),
                                            decoration: BoxDecoration(
                                              borderRadius:
                                                  BorderRadius.circular(8.r),
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
                                            child: const Column(
                                              children: [
                                                ShimmerBoxWidget(
                                                  width: double.infinity,
                                                  height: 200,
                                                ),
                                                SpaceWidget(),
                                                ShimmerBoxWidget(
                                                  width: double.infinity,
                                                  height: 20,
                                                ),
                                                SpaceWidget(),
                                                Row(
                                                  mainAxisAlignment:
                                                      MainAxisAlignment
                                                          .spaceBetween,
                                                  children: [
                                                    Expanded(
                                                      child: ShimmerBoxWidget(
                                                        width: double.infinity,
                                                        height: 20,
                                                      ),
                                                    ),
                                                    SpaceWidget(
                                                      direction:
                                                          Direction.horizontal,
                                                    ),
                                                    Expanded(
                                                      child: ShimmerBoxWidget(
                                                        width: double.infinity,
                                                        height: 20,
                                                      ),
                                                    ),
                                                  ],
                                                )
                                              ],
                                            ),
                                          );
                                        } else {
                                          return ArticleCardItem(
                                            isLoading: false,
                                            articleModel: state.isByCategory
                                                ? state
                                                    .articlesByCategory[index]
                                                : state.articles[index],
                                            onTap: () {
                                              AutoRouter.of(context).push(
                                                ArticleDetailRoute(
                                                  articleModel: state
                                                          .isByCategory
                                                      ? state.articlesByCategory[
                                                          index]
                                                      : state.articles[index],
                                                ),
                                              );
                                            },
                                          );
                                        }
                                      },
                                    ),
                                  );
                          },
                        ),
                      ),
                    ],
                  ),
                ),
              ),
            ),
          ),
        ),
      ),
    );
  }
}
