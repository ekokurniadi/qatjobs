import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:qatjobs/core/constant/assets_constant.dart';
import 'package:qatjobs/core/constant/url_constant.dart';
import 'package:qatjobs/core/extensions/dio_response_extension.dart';
import 'package:qatjobs/core/helpers/dio_helper.dart';
import 'package:qatjobs/core/styles/color_name_style.dart';
import 'package:qatjobs/core/styles/resolution_style.dart';
import 'package:qatjobs/core/styles/text_name_style.dart';
import 'package:qatjobs/core/widget/custom_appbar_widget.dart';
import 'package:qatjobs/core/widget/custom_cached_image_network.dart';
import 'package:qatjobs/core/widget/custom_text_field.dart';
import 'package:qatjobs/core/widget/loading_dialog_widget.dart';
import 'package:qatjobs/core/widget/pull_to_refresh_widget.dart';
import 'package:qatjobs/core/widget/vertical_space_widget.dart';
import 'package:qatjobs/features/users/data/models/users_model.codegen.dart';

class EmployerFollowersPage extends StatefulWidget {
  const EmployerFollowersPage({super.key});

  @override
  State<EmployerFollowersPage> createState() => _EmployerFollowersPageState();
}

class _EmployerFollowersPageState extends State<EmployerFollowersPage> {
  List<UserModel> users = [];
  List<UserModel> tempUser = [];

  Future<void> getFollowers() async {
    try {
      LoadingDialog.show(message: 'Loading ...');
      final result = await DioHelper.dio!.get(URLConstant.employerFollowers);
      users.clear();
      if (result.isOk) {
        LoadingDialog.dismiss();
        for (var res in result.data['data']) {
          users.add(UserModel.fromJson(res['user']));
        }
        tempUser = users;
        setState(() {});
      } else {
        LoadingDialog.dismiss();
        LoadingDialog.showError(message: result.data['message']);
      }
    } on DioError catch (e) {
      LoadingDialog.dismiss();
      LoadingDialog.showError(message: DioHelper.formatException(e));
    }
  }

  @override
  void initState() {
    getFollowers();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: const CustomAppBar(
        title: 'Followers',
        showLeading: true,
      ),
      body: PullToRefreshWidget(
        onRefresh: () async {
          await getFollowers();
        },
        child: Padding(
          padding: defaultPadding,
          child: Column(
            children: [
              CustomTextField(
                placeholder: 'Search Followers',
                onChange: (val) {
                  if (val.isEmpty) {
                    users = tempUser;
                    setState(() {});
                  } else {
                    users = users
                        .where((element) =>
                            element.fullName!.toLowerCase().contains(val) ||
                            element.email!.toLowerCase().contains(val))
                        .toList();
                    setState(() {});
                  }
                },
              ),
              Flexible(
                child: ListView.separated(
                  separatorBuilder: (context, index) => const SpaceWidget(),
                  shrinkWrap: true,
                  itemCount: users.length,
                  itemBuilder: (context, index) {
                    return InkWell(
                      onTap: () {},
                      child: Container(
                        padding: defaultPadding,
                        decoration: BoxDecoration(
                          borderRadius: defaultRadius,
                          boxShadow: AppColors.defaultShadow,
                          color: AppColors.bg200,
                        ),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Row(
                              crossAxisAlignment: CrossAxisAlignment.center,
                              children: [
                                Container(
                                  width: 80.w,
                                  height: 80.w,
                                  decoration: BoxDecoration(
                                    shape: BoxShape.circle,
                                    border: Border.all(
                                      color: AppColors.neutral,
                                    ),
                                  ),
                                  child: ClipOval(
                                    child: CustomImageNetwork(
                                      imageUrl: users[index].avatar ?? '',
                                      customErrorWidget: SvgPicture.asset(
                                        AssetsConstant.svgAssetsPicture,
                                      ),
                                    ),
                                  ),
                                ),
                                const SpaceWidget(
                                    direction: Direction.horizontal),
                                Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    IText.set(
                                      text: users[index].fullName ?? '',
                                      textAlign: TextAlign.left,
                                      styleName: TextStyleName.semiBold,
                                      typeName: TextTypeName.caption1,
                                      color: AppColors.textPrimary100,
                                    ),
                                    IText.set(
                                      text: users[index].email ?? '-',
                                      textAlign: TextAlign.left,
                                      styleName: TextStyleName.regular,
                                      typeName: TextTypeName.caption1,
                                      color: AppColors.textPrimary100,
                                    ),
                                    IText.set(
                                      text: users[index].phone ?? '-',
                                      textAlign: TextAlign.left,
                                      styleName: TextStyleName.regular,
                                      typeName: TextTypeName.caption1,
                                      color: AppColors.textPrimary100,
                                    ),
                                  ],
                                ),
                              ],
                            ),
                          ],
                        ),
                      ),
                    );
                  },
                ),
              )
            ],
          ),
        ),
      ),
    );
  }
}
