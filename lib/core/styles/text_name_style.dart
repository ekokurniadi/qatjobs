import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:qatjobs/core/styles/color_name_style.dart';

enum TextStyleName {
  bold,
  semiBold,
  medium,
  regular,
  light,
}

enum TextTypeName {
  display1,
  display2,
  body1,
  body2,
  caption1,
  caption2,
  caption3,
  headline1,
  headline2,
  headline3,
  headline4,
  buttonLarge,
  buttonMedium,
  buttonSmall,
}

class InstaTexts {
  static Text getStyle({
    String? text,
    TextTypeName? typeName,
    TextStyleName? styleName,
    Color? color,
  }) {
    FontWeight style = FontWeight.normal;
    double size = 14.w;

    switch (typeName) {
      case TextTypeName.body1:
        size = 16.w;
        break;
      case TextTypeName.body2:
        size = 14.w;
        break;
      case TextTypeName.buttonLarge:
        size = 16.w;
        break;
      case TextTypeName.buttonMedium:
        size = 14.w;
        break;
      case TextTypeName.buttonSmall:
        size = 12.w;
        break;
      case TextTypeName.caption1:
        size = 14.w;
        break;
      case TextTypeName.caption2:
        size = 12.w;
        break;
      case TextTypeName.caption3:
        size = 10.w;
        break;
      case TextTypeName.display1:
        size = 28.w;
        break;
      case TextTypeName.display2:
        size = 24.w;
        break;
      case TextTypeName.headline1:
        size = 20.w;
        break;
      case TextTypeName.headline2:
        size = 18.w;
        break;
      case TextTypeName.headline3:
        size = 16.w;
        break;
      case TextTypeName.headline4:
        size = 14.w;
        break;
      default:
        break;
    }

    switch (styleName) {
      case TextStyleName.bold:
        style = FontWeight.w700;
        break;
      case TextStyleName.semiBold:
        style = FontWeight.w600;
        break;
      case TextStyleName.medium:
        style = FontWeight.w500;
        break;
      case TextStyleName.regular:
        style = FontWeight.w400;
        break;
      case TextStyleName.light:
        style = FontWeight.w300;
        break;
      default:
        break;
    }

    return Text(text ?? '',
      style: TextStyle(
        fontSize: size,
        fontWeight: style,
        color: color ?? AppColors.text500,
      ),
    );
  }
}