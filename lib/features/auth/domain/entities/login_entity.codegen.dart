import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:qatjobs/features/users/domain/entitites/users_entity.codegen.dart';

part "login_entity.codegen.freezed.dart";

@freezed
class LoginEntity with _$LoginEntity {
  factory LoginEntity({
    required String accessToken,
    required UserEntity user,
    required List<String> roles,
  }) = _LoginEntity;
}
