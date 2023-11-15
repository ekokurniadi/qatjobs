import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_html/flutter_html.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:qatjobs/core/styles/color_name_style.dart';
import 'package:qatjobs/core/styles/resolution_style.dart';
import 'package:qatjobs/core/styles/text_name_style.dart';
import 'package:qatjobs/core/widget/custom_appbar_widget.dart';
import 'package:qatjobs/core/widget/section_title_widget.dart';
import 'package:qatjobs/core/widget/vertical_space_widget.dart';
import 'package:qatjobs/features/about/presentations/cubit/about_cubit.dart';
import 'package:qatjobs/injector.dart';

class AboutUsPage extends StatelessWidget {
  const AboutUsPage({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => getIt<AboutCubit>()..getAbout(),
      child: Scaffold(
        appBar: const CustomAppBar(
          title: 'About Us',
          showLeading: true,
        ),
        body: BlocBuilder<AboutCubit, AboutState>(
          builder: (context, state) {
            return state.status == AboutStatus.loading ? const Center(
              child: CircularProgressIndicator(),
            ) : ListView.separated(
              padding: defaultPadding,
              shrinkWrap: true,
              itemBuilder: (context, index) {
                return Column(
                  mainAxisAlignment: MainAxisAlignment.start,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Container(
                      width: double.infinity,
                      child: IText.set(
                        text: state.abouts[index].title,
                        textAlign: TextAlign.left,
                        styleName: TextStyleName.bold,
                        typeName: TextTypeName.headline2,
                        color: AppColors.textPrimary,
                        lineHeight: 1.2.h,
                      ),
                    ),
                    Html(data: state.abouts[index].description),
                  ],
                );
              },
              separatorBuilder: (context, index) {
                return const SpaceWidget();
              },
              itemCount: state.abouts.length,
            );
          },
        ),
      ),
    );
  }
}
