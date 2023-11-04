import 'package:dartz/dartz.dart';
import 'package:injectable/injectable.dart';
import 'package:qatjobs/core/error/failures.dart';
import 'package:qatjobs/core/usecases/usecases.dart';
import 'package:qatjobs/features/profile/candidate/data/models/candidate_education_models.codegen.dart';
import 'package:qatjobs/features/profile/candidate/domain/repositories/candidate_profile_repository.dart';

@injectable
class CandidateUpdateEducationUseCase
    implements UseCase<bool, CandidateEducationModels> {
  final CandidateProfileRepository _repository;

  const CandidateUpdateEducationUseCase(this._repository);

  @override
  Future<Either<Failures, bool>> call(
    CandidateEducationModels params,
  ) async {
    return await _repository.updateEducation(params);
  }
}
