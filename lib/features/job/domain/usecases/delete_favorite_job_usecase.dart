import "package:dartz/dartz.dart";
import "package:injectable/injectable.dart";
import "package:qatjobs/core/error/failures.dart";
import "package:qatjobs/core/usecases/usecases.dart";
import "package:qatjobs/features/job/domain/repositories/job_repository.dart";

@injectable
class DeleteFavoriteJobUseCase
    implements UseCase<bool, int> {
  final JobRepository _jobRepository;

  DeleteFavoriteJobUseCase({
    required JobRepository jobRepository,
  }) : _jobRepository = jobRepository;

  @override
  Future<Either<Failures, bool>> call(int params) async {
    return await _jobRepository.deleteFavoriteJob(params);
  }
}