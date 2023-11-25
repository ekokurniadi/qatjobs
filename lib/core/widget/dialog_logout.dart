import 'package:flutter/material.dart';
import 'package:qatjobs/core/styles/color_name_style.dart';
import 'package:qatjobs/core/styles/text_name_style.dart';
import 'package:qatjobs/core/widget/vertical_space_widget.dart';

class DialogLogout {
  static Future<bool?> show(
    BuildContext context, {
    required VoidCallback onOk,
    required VoidCallback onCancel,
  }) async {
    return await showDialog(
      context: context,
      builder: (context) {
        return AlertDialog(
          title: IText.set(
            text: 'Logout Confirmation',
            styleName: TextStyleName.bold,
            typeName: TextTypeName.headline2,
            color: AppColors.primary,
          ),
          content: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              IText.set(
                text: 'Are you sure to logout from this application?',
                styleName: TextStyleName.regular,
                typeName: TextTypeName.headline4,
              ),
              const SpaceWidget(),
              Row(
                mainAxisAlignment: MainAxisAlignment.end,
                children: [
                  TextButton(
                    onPressed: onOk,
                    child: IText.set(
                      text: 'Yes',
                      styleName: TextStyleName.semiBold,
                      typeName: TextTypeName.headline2,
                      color: AppColors.primary,
                    ),
                  ),
                  TextButton(
                    onPressed: onCancel,
                    child: IText.set(
                      text: 'No',
                      styleName: TextStyleName.semiBold,
                      typeName: TextTypeName.headline2,
                      color: AppColors.textPrimary100,
                    ),
                  )
                ],
              )
            ],
          ),
        );
      },
    );
  }
}
