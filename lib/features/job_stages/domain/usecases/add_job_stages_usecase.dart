import "package:dartz/dartz.dart";
import "package:equatable/equatable.dart";
import "package:injectable/injectable.dart";
import "package:qatjobs/core/error/failures.dart";
import "package:qatjobs/core/usecases/usecases.dart";
import "package:qatjobs/features/job_stages/domain/repositories/job_stages_repository.dart";

@injectable
class AddJobStagesUseCase implements UseCase<bool, JobStagesRequestParams> {
  final JobStagesRepository _jobStagesRepository;

  AddJobStagesUseCase({
    required JobStagesRepository jobStagesRepository,
  }) : _jobStagesRepository = jobStagesRepository;

  @override
  Future<Either<Failures, bool>> call(JobStagesRequestParams params) async {
    return await _jobStagesRepository.addJobStages(params);
  }
}

// ignore: must_be_immutable
class JobStagesRequestParams extends Equatable {
  int? id;
  String name;
  String description;
  JobStagesRequestParams({
    this.id,
    required this.name,
    required this.description,
  });

  Map<String, dynamic> toJson() => {
        'name': name,
        'description': description,
      };

  @override
  List<Object?> get props => [name, description, id];
}
