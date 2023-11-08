import "package:dartz/dartz.dart";
import "package:equatable/equatable.dart";
import "package:injectable/injectable.dart";
import "package:qatjobs/core/error/failures.dart";
import "package:qatjobs/core/usecases/usecases.dart";
import "package:qatjobs/features/job/domain/repositories/job_repository.dart";

@injectable
class ApplyJobUseCase
    implements UseCase<bool, ApplyJobRequestParams> {
  final JobRepository _jobRepository;

  ApplyJobUseCase({
    required JobRepository jobRepository,
  }) : _jobRepository = jobRepository;

  @override
  Future<Either<Failures, bool>> call(ApplyJobRequestParams params) async {
    return await _jobRepository.applyJob(params);
  }
}

class ApplyJobRequestParams extends Equatable {
  final int jobId;
  final int expectedSalary;
  final String applicationType;
  final int resumeId;
  const ApplyJobRequestParams({
    required this.jobId,
    required this.expectedSalary,
    required this.applicationType,
    required this.resumeId,
  });

  Map<String, dynamic> toJson() {
    return {
      'expected_salary': expectedSalary,
      'application_type': applicationType,
      'resume_id': resumeId,
    };
  }

  @override
  List<Object?> get props => [expectedSalary,applicationType,resumeId,jobId];
}
