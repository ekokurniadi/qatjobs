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
    required String email,
    String? phone,
    String? emailVerifiedAt,
    String? dob,
    int? gender,
    required bool isActive,
    required bool isVerified,
    required int ownerId,
    required String ownerType,
    required String language,
    required String profileViews,
    required String themeMode,
    String? facebookUrl,
    String? twitterUrl,
    String? linkedinUrl,
    String? googlePlusUrl,
    String? pinterestUrl,
    required bool isDefault,
    int? stripeId,
    required String regionCode,
    required String fullName,
    required String avatar,
    List<String>? media,
    required List<RoleModel> roles,
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
        roles: List.from(
          roles.map(
            (e) => e.toDomain(),
          ),
        ),
      );
}
