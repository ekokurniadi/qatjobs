import 'package:dartz/dartz.dart';
import 'package:equatable/equatable.dart';
import 'package:injectable/injectable.dart';
import 'package:qatjobs/core/error/failures.dart';
import 'package:qatjobs/core/usecases/usecases.dart';
import 'package:qatjobs/features/profile/employer/domain/repositories/employer_repository.dart';

@injectable
class EmployerChangePasswordUseCase
    implements UseCase<bool, ChangePasswordRequestParams> {
  final EmployerRepository _repository;

  const EmployerChangePasswordUseCase(this._repository);

  @override
  Future<Either<Failures, bool>> call(
    ChangePasswordRequestParams params,
  ) async {
    return await _repository.changePassword(params);
  }
}

// ignore: must_be_immutable
class ChangePasswordRequestParams extends Equatable {
  String? passwordCurrent;
  String? password;
  String? passwordConfirmation;

  ChangePasswordRequestParams({
    this.passwordCurrent,
    this.password,
    this.passwordConfirmation,
  });

  Map<String, dynamic> toJson() => {
        'password': password,
        'password_current': passwordCurrent,
        'password_confirmation': passwordConfirmation,
      };

  @override
  List<Object?> get props => [passwordCurrent,password,passwordConfirmation];
}
