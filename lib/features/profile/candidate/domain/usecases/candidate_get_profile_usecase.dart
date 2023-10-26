import 'package:dartz/dartz.dart';
import 'package:injectable/injectable.dart';
import 'package:qatjobs/core/error/failures.dart';
import 'package:qatjobs/core/usecases/usecases.dart';
import 'package:qatjobs/features/profile/candidate/data/models/profile_candidate_models.codegen.dart';
import 'package:qatjobs/features/profile/candidate/domain/repositories/candidate_profile_repository.dart';

@injectable
class CandidateGetProfile implements UseCase<ProfileCandidateModels, NoParams> {
  final CandidateProfileRepository _repository;

  const CandidateGetProfile(this._repository);

  @override
  Future<Either<Failures, ProfileCandidateModels>> call(
    NoParams params,
  ) async {
    return await _repository.getProfile(params);
  }
}
