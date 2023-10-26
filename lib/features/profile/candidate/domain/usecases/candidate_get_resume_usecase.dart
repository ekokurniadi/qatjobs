import 'package:dartz/dartz.dart';
import 'package:injectable/injectable.dart';
import 'package:qatjobs/core/error/failures.dart';
import 'package:qatjobs/core/usecases/usecases.dart';
import 'package:qatjobs/features/profile/candidate/data/models/resume_models.codegen.dart';
import 'package:qatjobs/features/profile/candidate/domain/repositories/candidate_profile_repository.dart';

@injectable
class CandidateGetResume implements UseCase<List<ResumeModels>, NoParams> {
  final CandidateProfileRepository _repository;

  const CandidateGetResume(this._repository);

  @override
  Future<Either<Failures, List<ResumeModels>>> call(
    NoParams params,
  ) async {
    return await _repository.getResume(params);
  }
}
