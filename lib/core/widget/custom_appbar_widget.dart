import 'package:flutter/material.dart';
import 'package:qatjobs/core/styles/color_name_style.dart';
import 'package:qatjobs/core/styles/text_name_style.dart';

class CustomAppBar extends StatelessWidget implements PreferredSizeWidget {
  const CustomAppBar({
    super.key,
    required this.title,
    this.actionWidget,
    this.showLeading,
  });
  final String title;
  final List<Widget>? actionWidget;
  final bool? showLeading;

  @override
  Widget build(BuildContext context) {
    return AppBar(
      backgroundColor: AppColors.bg200,
      automaticallyImplyLeading: showLeading ?? false,
      elevation: 0.5,
      title: IText.set(
        text: title,
        textAlign: TextAlign.left,
        styleName: TextStyleName.bold,
        typeName: TextTypeName.headline2,
        color: AppColors.textPrimary,
      ),
      actions: actionWidget ?? [],
    );
  }

  @override
  // TODO: implement preferredSize
  Size get preferredSize => const Size.fromHeight(kToolbarHeight);
}
