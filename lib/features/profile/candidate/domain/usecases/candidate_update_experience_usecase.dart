import 'package:dartz/dartz.dart';
import 'package:injectable/injectable.dart';
import 'package:qatjobs/core/error/failures.dart';
import 'package:qatjobs/core/usecases/usecases.dart';
import 'package:qatjobs/features/profile/candidate/data/models/candidate_experience_models.codegen.dart';
import 'package:qatjobs/features/profile/candidate/domain/repositories/candidate_profile_repository.dart';

@injectable
class CandidateUpdateExperienceUseCase
    implements UseCase<bool, CandidateExperienceModels> {
  final CandidateProfileRepository _repository;

  const CandidateUpdateExperienceUseCase(this._repository);

  @override
  Future<Either<Failures, bool>> call(
    CandidateExperienceModels params,
  ) async {
    return await _repository.updateExperience(params);
  }
}
