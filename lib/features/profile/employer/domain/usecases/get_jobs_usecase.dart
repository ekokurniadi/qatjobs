import 'package:dartz/dartz.dart';
import 'package:injectable/injectable.dart';
import 'package:qatjobs/core/error/failures.dart';
import 'package:qatjobs/core/usecases/usecases.dart';
import 'package:qatjobs/features/job/data/models/job_model.codegen.dart';
import 'package:qatjobs/features/profile/employer/data/models/job_request_params.codegen.dart';
import 'package:qatjobs/features/profile/employer/domain/repositories/employer_repository.dart';

@injectable
class GetJobsEmployerUserCase
    implements UseCase<List<JobModel>, JobRequestParams> {
  final EmployerRepository _repository;

  const GetJobsEmployerUserCase(this._repository);

  @override
  Future<Either<Failures, List<JobModel>>> call(JobRequestParams params) async {
    return await _repository.getJobs(params);
  }
}
