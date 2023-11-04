import 'package:dropdown_search/dropdown_search.dart';
import 'package:flutter/material.dart';
import 'package:qatjobs/core/helpers/global_helper.dart';
import 'package:qatjobs/core/styles/color_name_style.dart';
import 'package:qatjobs/core/styles/resolution_style.dart';
import 'package:qatjobs/core/styles/text_name_style.dart';

class DropdownSearchWidget<T> extends StatelessWidget {
  const DropdownSearchWidget({
    super.key,
    required this.items,
    required this.hintText,
    this.itemAsString,
    this.onChanged,
    this.selectedItem,
    this.alwaysShowLabel = false,
    this.label,
    this.isRequired = false,
  });
  final List<T> items;
  final String Function(T)? itemAsString;
  final void Function(T?)? onChanged;
  final String hintText;
  final String? label;
  final T? selectedItem;
  final bool alwaysShowLabel;
  final bool isRequired;

  @override
  Widget build(BuildContext context) {
    return DropdownSearch<T>(
      items: items,
      selectedItem: selectedItem,
      onChanged: onChanged,
      autoValidateMode: AutovalidateMode.onUserInteraction,
      validator: isRequired
          ? (val) {
              if (GlobalHelper.isEmpty(val)) {
                return 'Please fill out this field';
              }
              return null;
            }
          : null,
      popupProps: const PopupPropsMultiSelection.menu(
        fit: FlexFit.loose,
        showSearchBox: true,
        searchDelay: Duration.zero,
      ),
      dropdownDecoratorProps: DropDownDecoratorProps(
        baseStyle: IText.set(
          text: '',
          typeName: TextTypeName.headline3,
          styleName: TextStyleName.regular,
          color: AppColors.textPrimary,
        ).style,
        dropdownSearchDecoration: InputDecoration(
          hintText: hintText,
          border: InputBorder.none,
          enabledBorder: InputBorder.none,
          focusedBorder: InputBorder.none,
          contentPadding: defaultPadding,
          floatingLabelBehavior:
              alwaysShowLabel ? FloatingLabelBehavior.always : null,
          label: GlobalHelper.isEmpty(label)
              ? null
              : IText.set(
                  text: label!,
                  typeName: TextTypeName.headline3,
                  styleName: TextStyleName.regular,
                  color: AppColors.textPrimary,
                ),
          hintStyle: IText.set(
            text: '',
            typeName: TextTypeName.headline3,
            styleName: TextStyleName.regular,
            color: AppColors.textPrimary,
          ).style,
        ),
      ),
      clearButtonProps: const ClearButtonProps(
        color: AppColors.textPrimary100,
        isVisible: true,
      ),
      enabled: true,
      itemAsString: itemAsString,
    );
  }
}

class DropdownSearchMultiSelectWidget<T> extends StatelessWidget {
  const DropdownSearchMultiSelectWidget({
    super.key,
    required this.items,
    required this.hintText,
    this.itemAsString,
    required this.onChanged,
    required this.selectedItem,
    this.alwaysShowLabel = false,
    this.label,
  });
  final List<T> items;
  final String Function(T)? itemAsString;
  final void Function(List<T>)? onChanged;
  final String hintText;
  final List<T> selectedItem;
  final bool alwaysShowLabel;
  final String? label;

  @override
  Widget build(BuildContext context) {
    return DropdownSearch<T>.multiSelection(
      items: items,
      selectedItems: selectedItem,
      onChanged: onChanged,
      autoValidateMode: AutovalidateMode.onUserInteraction,
      popupProps: const PopupPropsMultiSelection.menu(
        fit: FlexFit.loose,
        showSearchBox: true,
        searchDelay: Duration.zero,
      ),
      dropdownDecoratorProps: DropDownDecoratorProps(
        baseStyle: IText.set(
          text: '',
          typeName: TextTypeName.headline3,
          styleName: TextStyleName.regular,
          color: AppColors.textPrimary,
        ).style,
        dropdownSearchDecoration: InputDecoration(
          hintText: hintText,
          border: InputBorder.none,
          enabledBorder: InputBorder.none,
          focusedBorder: InputBorder.none,
          contentPadding: defaultPadding,
          floatingLabelBehavior:
              alwaysShowLabel ? FloatingLabelBehavior.always : null,
          label: GlobalHelper.isEmpty(label)
              ? null
              : IText.set(
                  text: label!,
                  typeName: TextTypeName.headline3,
                  styleName: TextStyleName.regular,
                  color: AppColors.textPrimary,
                ),
          hintStyle: IText.set(
            text: '',
            typeName: TextTypeName.headline3,
            styleName: TextStyleName.regular,
            color: AppColors.textPrimary,
          ).style,
        ),
      ),
      enabled: true,
      itemAsString: itemAsString,
    );
  }
}
