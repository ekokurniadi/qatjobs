import 'package:dartz/dartz.dart';
import 'package:injectable/injectable.dart';
import 'package:qatjobs/core/error/failures.dart';
import 'package:qatjobs/core/usecases/usecases.dart';
import 'package:qatjobs/features/profile/candidate/data/models/candidate_education_models.codegen.dart';
import 'package:qatjobs/features/profile/candidate/domain/repositories/candidate_profile_repository.dart';

@injectable
class CandidateGetEducationUseCase
    implements UseCase<List<CandidateEducationModels>, NoParams> {
  final CandidateProfileRepository _repository;

  const CandidateGetEducationUseCase(this._repository);

  @override
  Future<Either<Failures, List<CandidateEducationModels>>> call(
    NoParams params,
  ) async {
    return await _repository.getEducation(params);
  }
}
