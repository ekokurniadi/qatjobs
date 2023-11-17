import 'package:dartz/dartz.dart';
import 'package:equatable/equatable.dart';
import 'package:injectable/injectable.dart';
import 'package:qatjobs/core/error/failures.dart';
import 'package:qatjobs/core/usecases/usecases.dart';
import 'package:qatjobs/features/profile/employer/domain/repositories/employer_repository.dart';

@injectable
class UpdateJobStatus implements UseCase<bool, UpdateJobStatusParams> {
  final EmployerRepository _repository;

  const UpdateJobStatus(this._repository);

  @override
  Future<Either<Failures, bool>> call(
    UpdateJobStatusParams params,
  ) async {
    return await _repository.updateJobStatus(params);
  }
}

// ignore: must_be_immutable
class UpdateJobStatusParams extends Equatable {
  int jobId;
  int status;

  UpdateJobStatusParams({
    required this.jobId,
    required this.status,
  });

  @override
  List<Object?> get props => [jobId, status];
}
