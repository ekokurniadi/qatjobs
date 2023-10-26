import 'package:dartz/dartz.dart';
import 'package:injectable/injectable.dart';
import 'package:qatjobs/core/error/failures.dart';
import 'package:qatjobs/core/usecases/usecases.dart';
import 'package:qatjobs/features/profile/candidate/domain/repositories/candidate_profile_repository.dart';

@injectable
class CandidateDeleteResume implements UseCase<bool, int> {
  final CandidateProfileRepository _repository;

  const CandidateDeleteResume(this._repository);

  @override
  Future<Either<Failures, bool>> call(
    int resumeId,
  ) async {
    return await _repository.deleteResume(resumeId);
  }
}
