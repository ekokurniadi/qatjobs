import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:qatjobs/core/helpers/date_helper.dart';
import 'package:qatjobs/core/helpers/global_helper.dart';
import 'package:qatjobs/core/helpers/html_parse_helper.dart';
import 'package:qatjobs/core/styles/color_name_style.dart';
import 'package:qatjobs/core/styles/resolution_style.dart';
import 'package:qatjobs/core/styles/text_name_style.dart';
import 'package:qatjobs/core/widget/custom_cached_image_network.dart';
import 'package:qatjobs/core/widget/shimmer_box_widget.dart';
import 'package:qatjobs/core/widget/vertical_space_widget.dart';
import 'package:qatjobs/features/article/data/models/article_model.codegen.dart';
import 'package:zoom_tap_animation/zoom_tap_animation.dart';

class ArticleCardItem extends StatefulWidget {
  const ArticleCardItem({
    super.key,
    this.articleModel,
    this.onTap,
    required this.isLoading,
  });
  final ArticleModel? articleModel;
  final VoidCallback? onTap;
  final bool isLoading;

  @override
  State<ArticleCardItem> createState() => _ArticleCardItemState();
}

class _ArticleCardItemState extends State<ArticleCardItem> {

  String _createReadMore(String? text){
    if(GlobalHelper.isEmpty(text)){
      return '';
    }

    final word = HtmlParseHelper.stripHtmlIfNeeded(text!);
    if(word.length > 100){
      return '${word.substring(0,100)}...';
    }else{
      return word;
    }
  }


  @override
  Widget build(BuildContext context) {
    return ZoomTapAnimation(
      onTap: widget.isLoading ? null : widget.onTap,
      child: Container(
        padding: defaultPadding,
        margin: EdgeInsets.only(bottom: 16.h),
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
        child: Column(
          children: [
            if (widget.isLoading) ...[
              const ShimmerBoxWidget(
                width: double.infinity,
                height: 200,
              ),
              const SpaceWidget(),
              const ShimmerBoxWidget(
                width: double.infinity,
                height: 20,
              ),
              const SpaceWidget(),
              const Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Expanded(
                    child: ShimmerBoxWidget(
                      width: double.infinity,
                      height: 20,
                    ),
                  ),
                  SpaceWidget(
                    direction: Direction.horizontal,
                  ),
                  Expanded(
                    child: ShimmerBoxWidget(
                      width: double.infinity,
                      height: 20,
                    ),
                  ),
                ],
              )
            ] else ...[
              SizedBox(
                width: double.infinity,
                height: 200,
                child: ClipRRect(
                  borderRadius: defaultRadius,
                  child: CustomImageNetwork(
                    imageUrl: widget.articleModel?.blogImageUrl ?? '',
                    fit: BoxFit.cover,
                  ),
                ),
              ),
              const SpaceWidget(),
              IText.set(
                  text: widget.articleModel?.title ?? '',
                  styleName: TextStyleName.bold,
                  typeName: TextTypeName.headline2,
                  color: AppColors.textPrimary,
                  textAlign: TextAlign.center),
              const SpaceWidget(),
              SizedBox(
                width: double.infinity,
                child: IText.set(
                  text: _createReadMore('hallo'),
                  styleName: TextStyleName.regular,
                  typeName: TextTypeName.caption1,
                  color: AppColors.textPrimary100,
                  textAlign: TextAlign.justify,
                ),
              ),
              const SpaceWidget(),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  IText.set(
                    text: DateHelper.formatdMy(
                      widget.articleModel?.createdAt,
                    ),
                    styleName: TextStyleName.regular,
                    typeName: TextTypeName.caption1,
                    color: AppColors.textPrimary,
                  ),
                  IText.set(
                    text: '${widget.articleModel?.commentsCount ?? 0} Comment',
                    styleName: TextStyleName.regular,
                    typeName: TextTypeName.caption1,
                    color: AppColors.textPrimary,
                  ),
                ],
              ),
              const SpaceWidget(),
              Row(
                children: [
                  ElevatedButton(
                    onPressed: widget.onTap,
                    child: const Text('Read More'),
                  ),
                ],
              )
            ],
          ],
        ),
      ),
    );
  }
}
