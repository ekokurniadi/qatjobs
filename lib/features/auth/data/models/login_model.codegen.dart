import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:qatjobs/features/auth/domain/entities/login_entity.codegen.dart';
import 'package:qatjobs/features/users/data/models/users_model.codegen.dart';

part "login_model.codegen.freezed.dart";
part "login_model.codegen.g.dart";

@freezed
class LoginModel with _$LoginModel {
  factory LoginModel({
    required String accessToken,
    required UserModel user,
    required List<String> roles,
  }) = _LoginModel;

  factory LoginModel.fromJson(Map<String, dynamic> json) =>
      _$LoginModelFromJson(json);
}

extension LoginModelX on LoginModel {
  LoginEntity toDomain() => LoginEntity(
        accessToken: accessToken,
        user: user.toDomain(),
        roles: roles,
      );
}
