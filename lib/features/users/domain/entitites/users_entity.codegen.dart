import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:qatjobs/features/users/data/models/users_model.codegen.dart';

part "users_entity.codegen.freezed.dart";

@freezed
class UserEntity with _$UserEntity {
  factory UserEntity({
    required int id,
    required String firstName,
    String? lastName,
    String? email,
    dynamic phone,
    String? emailVerifiedAt,
    String? dob,
    int? gender,
    bool? isActive,
    bool? isVerified,
    int? ownerId,
    String? ownerType,
    String? language,
    dynamic profileViews,
    dynamic themeMode,
    String? facebookUrl,
    String? twitterUrl,
    String? linkedinUrl,
    String? googlePlusUrl,
    String? pinterestUrl,
    bool? isDefault,
    dynamic stripeId,
    dynamic regionCode,
    String? fullName,
    String? avatar,
    List<Map<String, dynamic>>? media,
    List<RoleEntity>? roles,
  }) = _UserEntity;
}

@freezed
class RoleEntity with _$RoleEntity {
  factory RoleEntity({
    required int id,
    required String name,
    required String guardName,
  }) = _RoleEntity;
}

extension RoleEntityX on RoleEntity {
  RoleModel toModel() => RoleModel(
        id: id,
        name: name,
        guardName: guardName,
      );
}

extension UserEntityX on UserEntity {
  UserModel toModel() => UserModel(
        id: id,
        dob: dob,
        emailVerifiedAt: emailVerifiedAt,
        facebookUrl: facebookUrl,
        googlePlusUrl: googlePlusUrl,
        linkedinUrl: linkedinUrl,
        phone: phone,
        pinterestUrl: pinterestUrl,
        stripeId: stripeId,
        twitterUrl: twitterUrl,
        firstName: firstName,
        lastName: lastName,
        email: email,
        gender: gender,
        isActive: isActive,
        isVerified: isVerified,
        ownerId: ownerId,
        ownerType: ownerType,
        language: language,
        profileViews: profileViews,
        themeMode: themeMode,
        isDefault: isDefault,
        regionCode: regionCode,
        fullName: fullName,
        avatar: avatar,
        roles: roles != null
            ? List.from(
                roles!.map(
                  (e) => e.toModel(),
                ),
              )
            : [],
      );
}
