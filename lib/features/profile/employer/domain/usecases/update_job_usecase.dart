import 'package:dartz/dartz.dart';
import 'package:injectable/injectable.dart';
import 'package:qatjobs/core/error/failures.dart';
import 'package:qatjobs/core/usecases/usecases.dart';
import 'package:qatjobs/features/job/data/models/job_model.codegen.dart';
import 'package:qatjobs/features/profile/employer/domain/repositories/employer_repository.dart';

@injectable
class UpdateJobUseCase implements UseCase<bool, JobModel> {
  final EmployerRepository _repository;

  const UpdateJobUseCase(this._repository);

  @override
  Future<Either<Failures, bool>> call(
    JobModel params,
  ) async {
    return await _repository.updateJob(params);
  }
}
