import 'package:dartz/dartz.dart';
import 'package:equatable/equatable.dart';
import 'package:injectable/injectable.dart';
import 'package:qatjobs/core/error/failures.dart';
import 'package:qatjobs/core/usecases/usecases.dart';
import 'package:qatjobs/features/auth/domain/repositories/auth_repository.dart';

@injectable
class RegisterUseCase implements UseCase<bool, RegisterRequestParam> {
  const RegisterUseCase(
    this._repository,
  );
  final AuthRepository _repository;
  @override
  Future<Either<Failures, bool>> call(RegisterRequestParam params) async {
    return await _repository.register(params);
  }
}

class RegisterRequestParam extends Equatable {
  const RegisterRequestParam({
    required this.email,
    required this.password,
    required this.firstName,
    required this.type,
  });
  final String email;
  final String password;
  final String firstName;
  final String type;

  Map<String, dynamic> toJson() {
    return {
      'email': email,
      'password': password,
      'first_name': firstName,
      'type': type,
    };
  }

  @override
  List<Object?> get props => [email, password, firstName, type];
}
