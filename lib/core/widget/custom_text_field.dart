import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:qatjobs/core/styles/color_name_style.dart';

import 'dart:math' as math;

import 'package:qatjobs/core/styles/text_name_style.dart';

class CustomTextField extends StatefulWidget {
  const CustomTextField(
      {super.key,
      required this.placeholder,
      this.isPassword = false,
      this.textInputType = TextInputType.text,
      this.controller,
      this.isReadOnly = false,
      this.validator,
      this.isOption = false,
      this.onTap,
      this.mouseCursor,
      this.maxLines = 1,
      this.minLines = 1,
      this.onChange,
      this.inputFormatters,
      this.isRequired = false,
      this.label,
      this.isAlwaysShowLabel = false,
      this.isCalendarPicker = false,
      this.showBorder = false,
      this.isSearch = false,
      this.scrollController});

  final String placeholder;
  final bool isPassword;
  final TextInputType? textInputType;
  final TextEditingController? controller;
  final bool isReadOnly;
  final String? label;
  final String? Function(String?)? validator;
  final bool isOption;
  final void Function()? onTap;
  final void Function(String)? onChange;
  final MouseCursor? mouseCursor;
  final int? maxLines;
  final int? minLines;
  final List<TextInputFormatter>? inputFormatters;
  final bool isRequired;
  final bool isAlwaysShowLabel;
  final bool isCalendarPicker;
  final bool showBorder;
  final bool isSearch;
  final ScrollController? scrollController;

  @override
  State<CustomTextField> createState() => _CustomTextFieldState();
}

class _CustomTextFieldState extends State<CustomTextField> {
  final ValueNotifier<bool> obsecureText = ValueNotifier(true);

  @override
  Widget build(BuildContext context) {
    return ValueListenableBuilder(
      valueListenable: obsecureText,
      builder: (context, val, _) {
        return GestureDetector(
          onTap: widget.onTap,
          child: Padding(
            padding: EdgeInsets.only(bottom: 16.h),
            child: Container(
              // padding: const EdgeInsets.all(4),
              decoration: BoxDecoration(
                color: AppColors.bg200,
                borderRadius: BorderRadius.circular(
                  8.r,
                ),
                boxShadow: AppColors.defaultShadow,
              ),
              width: double.infinity,
              child: TextFormField(
                scrollController: widget.scrollController,
                inputFormatters: widget.inputFormatters,
                onChanged: widget.onChange,
                minLines: widget.minLines,
                maxLines: widget.maxLines,
                mouseCursor: widget.mouseCursor,
                onTap: widget.onTap,
                obscureText: widget.isPassword ? obsecureText.value : false,
                keyboardType: widget.textInputType,
                controller: widget.controller,
                readOnly: widget.isReadOnly,
                validator: widget.isRequired
                    ? (v) {
                        if (v!.isEmpty) {
                          return 'Please fill out this field !';
                        }
                        return null;
                      }
                    : widget.validator,
                autovalidateMode: AutovalidateMode.onUserInteraction,
                decoration: InputDecoration(
                  border: widget.showBorder
                      ? const OutlineInputBorder()
                      : InputBorder.none,
                  focusedBorder: widget.showBorder
                      ? const OutlineInputBorder()
                      : InputBorder.none,
                  enabledBorder: widget.showBorder
                      ? const OutlineInputBorder()
                      : InputBorder.none,
                  floatingLabelBehavior: widget.isAlwaysShowLabel
                      ? FloatingLabelBehavior.always
                      : null,
                  contentPadding: const EdgeInsets.all(16),
                  hintText: widget.placeholder,
                  hintStyle: const TextStyle(
                    color: AppColors.textPrimary100,
                  ),
                  labelStyle: const TextStyle(height: 0.5),
                  label: widget.label != null
                      ? RichText(
                          text: TextSpan(
                            children: [
                              TextSpan(
                                text: widget.label!,
                                style: IText.set(
                                  text: widget.label!,
                                  typeName: TextTypeName.headline3,
                                  styleName: TextStyleName.regular,
                                  color: AppColors.textPrimary,
                                ).style,
                              ),
                              if (widget.isRequired)
                                TextSpan(
                                  text: ' *',
                                  style: IText.set(
                                    text: '*',
                                    typeName: TextTypeName.headline1,
                                    styleName: TextStyleName.regular,
                                    color: AppColors.danger100,
                                  ).style,
                                ),
                            ],
                          ),
                        )
                      : null,
                  suffixIcon: widget.isPassword
                      ? TextButton(
                          onPressed: () {
                            obsecureText.value = !obsecureText.value;
                          },
                          child: !obsecureText.value
                              ? Icon(
                                  Icons.remove_red_eye_outlined,
                                  color: AppColors.neutral200,
                                  size: 24.w,
                                )
                              : Icon(
                                  Icons.visibility_off,
                                  color: AppColors.neutral200,
                                  size: 24.w,
                                ),
                        )
                      : widget.isCalendarPicker
                          ? TextButton(
                              onPressed: widget.onTap,
                              child: Icon(
                                Icons.calendar_month,
                                color: AppColors.neutral200,
                                size: 21.w,
                              ),
                            )
                          : widget.isOption
                              ? TextButton(
                                  onPressed: widget.onTap,
                                  child: Icon(
                                    Icons.arrow_forward_ios_rounded,
                                    color: AppColors.neutral200,
                                    size: 21.w,
                                  ))
                              : widget.isSearch
                                  ? Padding(
                                      padding: const EdgeInsets.only(right: 8),
                                      child: ElevatedButton(
                                        style: ElevatedButton.styleFrom(
                                          backgroundColor: AppColors.warning,
                                        ),
                                        onPressed: widget.onTap,
                                        child: Icon(
                                          Icons.search,
                                          color: AppColors.bg100,
                                          size: 28.w,
                                        ),
                                      ),
                                    )
                                  : null,
                ),
              ),
            ),
          ),
        );
      },
    );
  }
}

class DecimalTextInputFormatter extends TextInputFormatter {
  const DecimalTextInputFormatter({
    this.decimalRange = 1,
  });

  final int? decimalRange;

  FilteringTextInputFormatter get allowDot =>
      FilteringTextInputFormatter.allow(RegExp(r'(^\d*\.?\d{0,2})'));

  @override
  TextEditingValue formatEditUpdate(
    TextEditingValue oldValue, // unused.
    TextEditingValue newValue,
  ) {
    TextSelection newSelection = newValue.selection;
    String truncated = newValue.text;

    if (decimalRange != null) {
      String value = newValue.text;

      if (value.contains(".") &&
          value.substring(value.indexOf(".") + 1).length > decimalRange!) {
        truncated = oldValue.text;
        newSelection = oldValue.selection;
      } else if (value == ".") {
        truncated = "0.";

        newSelection = newValue.selection.copyWith(
          baseOffset: math.min(truncated.length, truncated.length + 1),
          extentOffset: math.min(truncated.length, truncated.length + 1),
        );
      }

      return TextEditingValue(
        text: truncated,
        selection: newSelection,
        composing: TextRange.empty,
      );
    }
    return newValue;
  }
}
