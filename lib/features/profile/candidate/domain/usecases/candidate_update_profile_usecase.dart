import 'dart:io';

import 'package:dartz/dartz.dart';
import 'package:equatable/equatable.dart';
import 'package:injectable/injectable.dart';
import 'package:qatjobs/core/error/failures.dart';
import 'package:qatjobs/core/usecases/usecases.dart';
import 'package:qatjobs/features/profile/candidate/domain/repositories/candidate_profile_repository.dart';

@injectable
class CandidateUpdateProfile
    implements UseCase<bool, ChangeProfileRequestParams> {
  final CandidateProfileRepository _repository;

  const CandidateUpdateProfile(this._repository);

  @override
  Future<Either<Failures, bool>> call(
    ChangeProfileRequestParams params,
  ) async {
    return await _repository.updateProfile(params);
  }
}

// ignore: must_be_immutable
class ChangeProfileRequestParams extends Equatable {
  String firstName;
  String lastName;
  String email;
  String? phone;
  File? image;

  ChangeProfileRequestParams({
    required this.firstName,
    required this.lastName,
    required this.email,
    this.phone,
    this.image,
  });

  @override
  List<Object?> get props => [firstName, lastName, email, phone, image];
}
