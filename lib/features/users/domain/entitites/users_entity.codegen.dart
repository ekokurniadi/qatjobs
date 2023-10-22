import 'package:freezed_annotation/freezed_annotation.dart';

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
