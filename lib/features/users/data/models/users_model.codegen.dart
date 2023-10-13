import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:qatjobs/features/users/domain/entitites/users_entity.codegen.dart';

part "users_model.codegen.freezed.dart";
part "users_model.codegen.g.dart";

@freezed
class UserModel with _$UserModel {
  factory UserModel({
    required int id,
    required String firstName,
    String? lastName,
    String? email,
    String? phone,
    String? emailVerifiedAt,
    String? dob,
    int? gender,
    bool? isActive,
    bool? isVerified,
    int? ownerId,
    String? ownerType,
    String? language,
    String? profileViews,
    String? themeMode,
    String? facebookUrl,
    String? twitterUrl,
    String? linkedinUrl,
    String? googlePlusUrl,
    String? pinterestUrl,
    bool? isDefault,
    int? stripeId,
    String? regionCode,
    String? fullName,
    String? avatar,
    List<Map<String, dynamic>>? media,
    List<RoleModel>? roles,
  }) = _UserModel;

  factory UserModel.fromJson(Map<String, dynamic> json) =>
      _$UserModelFromJson(json);
}

@freezed
class RoleModel with _$RoleModel {
  factory RoleModel({
    required int id,
    required String name,
    required String guardName,
  }) = _RoleModel;

  factory RoleModel.fromJson(Map<String, dynamic> json) =>
      _$RoleModelFromJson(json);
}

extension RoleModelX on RoleModel {
  RoleEntity toDomain() => RoleEntity(
        id: id,
        name: name,
        guardName: guardName,
      );
}

extension UserModelX on UserModel {
  UserEntity toDomain() => UserEntity(
        id: id,
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
                  (e) => e.toDomain(),
                ),
              )
            : [],
      );
}
