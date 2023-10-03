import 'package:dartz/dartz.dart';
import 'package:equatable/equatable.dart';
import 'package:injectable/injectable.dart';
import 'package:qatjobs/core/error/failures.dart';
import 'package:qatjobs/core/usecases/usecases.dart';
import 'package:qatjobs/features/auth/data/models/login_model.codegen.dart';
import 'package:qatjobs/features/auth/domain/repositories/auth_repository.dart';

@injectable
class LoginUseCase implements UseCase<LoginModel, LoginRequestParams> {
  const LoginUseCase(
    this._repository,
  );
  final AuthRepository _repository;
  @override
  Future<Either<Failures, LoginModel>> call(LoginRequestParams params) async {
    return await _repository.login(params);
  }
}

class LoginRequestParams extends Equatable {
  const LoginRequestParams({
    required this.email,
    required this.password,
    required this.deviceName,
  });
  final String email;
  final String password;
  final String deviceName;

  Map<String, dynamic> toJson() {
    return {
      'email': email,
      'password': password,
      'device_name': deviceName,
    };
  }

  @override
  List<Object?> get props => [];
}
