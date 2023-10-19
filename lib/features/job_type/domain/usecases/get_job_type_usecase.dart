import "package:dartz/dartz.dart";
import "package:injectable/injectable.dart";
import "package:qatjobs/core/error/failures.dart";
import "package:qatjobs/core/usecases/usecases.dart";
import "package:qatjobs/features/job_type/data/models/jobs_type_model.codegen.dart";
import "package:qatjobs/features/job_type/domain/repositories/job_type_repository.dart";


@injectable
class GetJobTypeUseCase implements UseCase<List<JobTypeModel>, NoParams> {
  final JobTypeRepository _jobTypeRepository;

  const GetJobTypeUseCase(
   this._jobTypeRepository,
  );

  @override
  Future<Either<Failures, List<JobTypeModel>>> call(NoParams params) async {
    return await _jobTypeRepository.getJobType(params);
  }
}
