import "package:dartz/dartz.dart";
import "package:injectable/injectable.dart";
import "package:qatjobs/core/error/failures.dart";
import "package:qatjobs/core/usecases/usecases.dart";
import "package:qatjobs/features/job/data/models/job_alert_request_params.codegen.dart";
import "package:qatjobs/features/job/domain/repositories/job_repository.dart";

@injectable
class AddJobAlertUseCase implements UseCase<bool, JobAlertRequestParams> {
  final JobRepository _jobRepository;

  const AddJobAlertUseCase(this._jobRepository);

  @override
  Future<Either<Failures, bool>> call(JobAlertRequestParams params) async {
    return await _jobRepository.addJobAlert(params);
  }
}
