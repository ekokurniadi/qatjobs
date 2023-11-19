import 'package:dartz/dartz.dart';
import 'package:injectable/injectable.dart';
import 'package:qatjobs/core/error/failures.dart';
import 'package:qatjobs/core/usecases/usecases.dart';
import 'package:qatjobs/features/profile/employer/data/models/job_application_models.codegen.dart';
import 'package:qatjobs/features/profile/employer/domain/repositories/employer_repository.dart';

@injectable
class GetJobApplicantCase implements UseCase<List<JobApplicationModel>, int> {
  final EmployerRepository _repository;

  const GetJobApplicantCase(this._repository);

  @override
  Future<Either<Failures, List<JobApplicationModel>>> call(int id) async {
    return await _repository.getJobApplicant(id);
  }
}
