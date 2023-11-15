import 'dart:io';

import 'package:dartz/dartz.dart';
import 'package:equatable/equatable.dart';
import 'package:injectable/injectable.dart';
import 'package:qatjobs/core/error/failures.dart';
import 'package:qatjobs/core/usecases/usecases.dart';
import 'package:qatjobs/features/profile/employer/domain/repositories/employer_repository.dart';

@injectable
class EmployerUpdateProfile
    implements UseCase<bool, EmployerProfileRequestParams> {
  final EmployerRepository _repository;

  const EmployerUpdateProfile(this._repository);

  @override
  Future<Either<Failures, bool>> call(
    EmployerProfileRequestParams params,
  ) async {
    return await _repository.updateProfile(params);
  }
}

// ignore: must_be_immutable
class EmployerProfileRequestParams extends Equatable {
  String firstName;
  String email;
  String? phone;
  File? image;

  EmployerProfileRequestParams({
    required this.firstName,
    required this.email,
    this.phone,
    this.image,
  });

  @override
  List<Object?> get props => [firstName, email, phone, image];
}
