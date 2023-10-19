import 'package:auto_route/auto_route.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:qatjobs/core/auto_route/auto_route.gr.dart';
import 'package:qatjobs/core/constant/assets_constant.dart';
import 'package:qatjobs/core/constant/url_constant.dart';
import 'package:qatjobs/core/extensions/dio_response_extension.dart';
import 'package:qatjobs/core/helpers/dio_helper.dart';
import 'package:qatjobs/core/styles/color_name_style.dart';
import 'package:flutter_typeahead/flutter_typeahead.dart';
import 'package:qatjobs/features/job/presentations/widgets/job_filter.dart';

class AutoCompleteBoxWidget extends StatefulWidget {
  const AutoCompleteBoxWidget({
    super.key,
  });

  @override
  State<AutoCompleteBoxWidget> createState() => _AutoCompleteBoxWidgetState();
}

class _AutoCompleteBoxWidgetState extends State<AutoCompleteBoxWidget> {
  final TextEditingController typeAheadController = TextEditingController();

  Future<List<String>> getSuggestion(String pattern) async {
    List<String> suggestion = [];
    try {
      final response = await DioHelper.dio!.get(
        URLConstant.jobSearchAutoComplete,
        queryParameters: {'searchTerm': pattern.toLowerCase()},
      );
      if (response.isOk) {
        return suggestion = List.from(
          response.data.map((e) => e),
        );
      }
      return suggestion;
    } catch (e) {
      return suggestion;
    }
  }

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: double.infinity,
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.center,
        mainAxisAlignment: MainAxisAlignment.start,
        children: [
          Expanded(
            child: Container(
              decoration: BoxDecoration(
                color: AppColors.bg100,
                borderRadius: BorderRadius.circular(8.r),
              ),
              child: TypeAheadField(
                hideOnLoading: true,
                suggestionsBoxDecoration: SuggestionsBoxDecoration(
                  borderRadius: BorderRadius.circular(8.r),
                ),
                textFieldConfiguration: TextFieldConfiguration(
                  controller: typeAheadController,
                  autofocus: false,
                  decoration: const InputDecoration(
                    contentPadding: EdgeInsets.all(16),
                    hintText: 'Job title, keywords, or company',
                    isCollapsed: true,
                    hintStyle: TextStyle(
                      color: AppColors.textPrimary100,
                    ),
                  ),
                ),
                suggestionsCallback: (pattern) async =>
                    await getSuggestion(pattern),
                itemBuilder: (context, suggestion) {
                  return ListTile(
                    title: Text(suggestion),
                  );
                },
                onSuggestionSelected: (suggestion) {
                  typeAheadController.text = suggestion;
                  setState(() {});
                },
              ),
            ),
          ),
          SizedBox(width: 8.w),
          SizedBox(
            height: 52.h,
            child: ElevatedButton(
              style: ElevatedButton.styleFrom(
                backgroundColor: AppColors.warning,
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(
                    8.r,
                  ),
                ),
              ),
              onPressed: () async{
               AutoRouter.of(context).push(const JobFilterRoute());
              },
              child: SvgPicture.asset(AssetsConstant.svgAssetsIconFilter),
            ),
          )
        ],
      ),
    );
  }
}