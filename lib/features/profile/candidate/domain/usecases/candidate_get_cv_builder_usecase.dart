import 'package:dartz/dartz.dart';
import 'package:injectable/injectable.dart';
import 'package:qatjobs/core/error/failures.dart';
import 'package:qatjobs/core/usecases/usecases.dart';
import 'package:qatjobs/features/profile/candidate/data/models/cv_builder_models.codegen.dart';
import 'package:qatjobs/features/profile/candidate/domain/repositories/candidate_profile_repository.dart';

@injectable
class CandidateGetCVBuilderUseCase
    implements UseCase<CvBuilderResponseModels, NoParams> {
  final CandidateProfileRepository _repository;

  const CandidateGetCVBuilderUseCase(this._repository);

  @override
  Future<Either<Failures, CvBuilderResponseModels>> call(
    NoParams params,
  ) async {
    return await _repository.getCVBuilder(params);
  }
}
