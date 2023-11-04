import "package:dartz/dartz.dart";
import "package:injectable/injectable.dart";
import "package:qatjobs/core/error/failures.dart";
import "package:qatjobs/core/usecases/usecases.dart";
import "package:qatjobs/features/job/data/models/applied_job_model.codegen.dart";
import "package:qatjobs/features/job/domain/repositories/job_repository.dart";

@injectable
class GetAppliedJobUseCase implements UseCase<List<AppliedJobModel>, NoParams> {
  final JobRepository _jobRepository;

  GetAppliedJobUseCase({
    required JobRepository jobRepository,
  }) : _jobRepository = jobRepository;

  @override
  Future<Either<Failures, List<AppliedJobModel>>> call(NoParams params) async {
    return await _jobRepository.getAppliedJob(params);
  }
}
