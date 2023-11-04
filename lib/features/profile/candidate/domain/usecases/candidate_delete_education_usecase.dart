import 'package:dartz/dartz.dart';
import 'package:injectable/injectable.dart';
import 'package:qatjobs/core/error/failures.dart';
import 'package:qatjobs/core/usecases/usecases.dart';
import 'package:qatjobs/features/profile/candidate/domain/repositories/candidate_profile_repository.dart';

@injectable
class CandidateDeleteEducationUseCase implements UseCase<bool, int> {
  final CandidateProfileRepository _repository;

  const CandidateDeleteEducationUseCase(this._repository);

  @override
  Future<Either<Failures, bool>> call(
    int id,
  ) async {
    return await _repository.deleteEducation(id);
  }
}
