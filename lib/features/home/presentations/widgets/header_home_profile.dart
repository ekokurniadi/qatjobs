import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:qatjobs/core/constant/app_constant.dart';
import 'package:qatjobs/core/constant/assets_constant.dart';
import 'package:qatjobs/core/styles/color_name_style.dart';
import 'package:qatjobs/core/styles/text_name_style.dart';
import 'package:qatjobs/core/widget/custom_cached_image_network.dart';
import 'package:qatjobs/features/users/domain/entitites/users_entity.codegen.dart';
import 'package:qatjobs/injector.dart';
import 'package:shared_preferences/shared_preferences.dart';

class HeaderHomeProfile extends StatefulWidget {
  const HeaderHomeProfile({
    super.key,
    required this.user,
  });

  final UserEntity? user;

  @override
  State<HeaderHomeProfile> createState() => _HeaderHomeProfileState();
}

class _HeaderHomeProfileState extends State<HeaderHomeProfile> {
  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        Expanded(
          flex: 2,
          child: Row(
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              IText.set(
                text: 'Hi,',
                styleName: TextStyleName.medium,
                typeName: TextTypeName.headline2,
                color: AppColors.textPrimary100,
              ),
              IText.set(
                text: ' ${widget.user?.fullName ?? 'QatJobs'}',
                styleName: TextStyleName.medium,
                typeName: TextTypeName.headline2,
                color: AppColors.textPrimary100,
              ),
            ],
          ),
        ),
        Expanded(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.end,
            children: [
              InkWell(
                onTap: () async {
                  await getIt<SharedPreferences>()
                      .remove(AppConstant.prefKeyUserLogin);
                },
                child: Container(
                  width: 56.w,
                  height: 56.w,
                  decoration: BoxDecoration(
                    shape: BoxShape.circle,
                    color: AppColors.bg200,
                    border: Border.all(
                      color: AppColors.secondary100,
                    ),
                  ),
                  child: ClipOval(
                    child: CustomImageNetwork(
                      imageUrl: widget.user?.avatar ?? '',
                      fit: BoxFit.cover,
                      isLoaderShimmer: true,
                      customErrorWidget: SvgPicture.asset(
                        AssetsConstant.svgAssetsLogoApp,
                      ),
                    ),
                  ),
                ),
              )
            ],
          ),
        )
      ],
    );
  }
}
