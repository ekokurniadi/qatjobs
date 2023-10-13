import "package:dartz/dartz.dart";
import "package:qatjobs/core/error/failures.dart";
import "package:qatjobs/core/usecases/usecases.dart";
import "package:qatjobs/features/job_shift/data/models/job_shift_model.codegen.dart";
import "package:qatjobs/features/job_shift/domain/repositories/job_shift_repository.dart";

class GetJobShiftUseCase implements UseCase<JobShiftModel, JobShiftModel> {
  final JobShiftRepository _jobShiftRepository;

  GetJobShiftUseCase({
    required JobShiftRepository jobShiftRepository,
  }) : _jobShiftRepository = jobShiftRepository;

  @override
  Future<Either<Failures, JobShiftModel>> call(JobShiftModel params) async {
    return await _jobShiftRepository.getJobShift(params);
  }
}
