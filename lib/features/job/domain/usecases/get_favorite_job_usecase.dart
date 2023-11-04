import "package:dartz/dartz.dart";
import "package:injectable/injectable.dart";
import "package:qatjobs/core/error/failures.dart";
import "package:qatjobs/core/usecases/usecases.dart";
import "package:qatjobs/features/job/data/models/favorite_job_model.codegen.dart";
import "package:qatjobs/features/job/domain/repositories/job_repository.dart";

@injectable
class GetFavoriteJobUseCase implements UseCase<List<FavoriteJobModel>, NoParams> {
  final JobRepository _jobRepository;

  GetFavoriteJobUseCase({
    required JobRepository jobRepository,
  }) : _jobRepository = jobRepository;

  @override
  Future<Either<Failures, List<FavoriteJobModel>>> call(NoParams params) async {
    return await _jobRepository.getFavoriteJob(params);
  }
}
