import 'package:dropdown_search/dropdown_search.dart';
import 'package:flutter/material.dart';
import 'package:qatjobs/core/styles/color_name_style.dart';
import 'package:qatjobs/core/styles/resolution_style.dart';

class DropdownSearchWidget<T> extends StatelessWidget {
  const DropdownSearchWidget({
    super.key,
    required this.items,
    required this.hintText,
    this.itemAsString,
    this.onChanged,
    this.selectedItem,
  });
  final List<T> items;
  final String Function(T)? itemAsString;
  final void Function(T?)? onChanged;
  final String hintText;
  final T? selectedItem;

  @override
  Widget build(BuildContext context) {
    return DropdownSearch<T>(
      items: items,
      selectedItem: selectedItem,
      onChanged: onChanged,
      autoValidateMode: AutovalidateMode.onUserInteraction,
      popupProps: const PopupPropsMultiSelection.menu(
        showSearchBox: true,
        searchDelay: Duration.zero,
      ),
      dropdownDecoratorProps: DropDownDecoratorProps(
        dropdownSearchDecoration: InputDecoration(
          hintText: hintText,
          border: InputBorder.none,
          enabledBorder: InputBorder.none,
          focusedBorder: InputBorder.none,
          contentPadding: defaultPadding,
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
