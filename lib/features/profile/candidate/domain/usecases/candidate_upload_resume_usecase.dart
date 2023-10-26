import 'dart:io';

import 'package:dartz/dartz.dart';
import 'package:equatable/equatable.dart';
import 'package:injectable/injectable.dart';
import 'package:qatjobs/core/error/failures.dart';
import 'package:qatjobs/core/usecases/usecases.dart';
import 'package:qatjobs/features/profile/candidate/domain/repositories/candidate_profile_repository.dart';

@injectable
class CandidateUploadResume
    implements UseCase<bool, ResumeRequestParams> {
  final CandidateProfileRepository _repository;

  const CandidateUploadResume(this._repository);

  @override
  Future<Either<Failures, bool>> call(
    ResumeRequestParams params,
  ) async {
    return await _repository.uploadResume(params);
  }
}

class ResumeRequestParams extends Equatable {
  final int isDefault;
  final String title;
  final File file;

  const ResumeRequestParams({
    required this.title,
    required this.file,
    required this.isDefault,
  });

  @override
  List<Object?> get props => [title, file, isDefault];
}
