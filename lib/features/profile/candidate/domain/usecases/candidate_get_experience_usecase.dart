import 'package:dartz/dartz.dart';
import 'package:injectable/injectable.dart';
import 'package:qatjobs/core/error/failures.dart';
import 'package:qatjobs/core/usecases/usecases.dart';
import 'package:qatjobs/features/profile/candidate/data/models/candidate_experience_models.codegen.dart';
import 'package:qatjobs/features/profile/candidate/domain/repositories/candidate_profile_repository.dart';

@injectable
class CandidateGetExperienceUseCase implements UseCase<List<CandidateExperienceModels>, NoParams> {
  final CandidateProfileRepository _repository;

  const CandidateGetExperienceUseCase(this._repository);

  @override
  Future<Either<Failures, List<CandidateExperienceModels>>> call(
    NoParams params,
  ) async {
    return await _repository.getExperiences(params);
  }
}
