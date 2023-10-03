import 'package:freezed_annotation/freezed_annotation.dart';

part "users_entity.codegen.freezed.dart";

@freezed
class UserEntity with _$UserEntity {
  factory UserEntity({
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
    required List<RoleEntity> roles,
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
