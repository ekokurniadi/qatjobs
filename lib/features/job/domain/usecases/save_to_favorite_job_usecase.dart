import "package:dartz/dartz.dart";
import "package:equatable/equatable.dart";
import "package:injectable/injectable.dart";
import "package:qatjobs/core/error/failures.dart";
import "package:qatjobs/core/usecases/usecases.dart";
import "package:qatjobs/features/job/domain/repositories/job_repository.dart";

@injectable
class SaveToFavoriteJobUseCase
    implements UseCase<bool, FavoriteJobRequestParams> {
  final JobRepository _jobRepository;

  SaveToFavoriteJobUseCase({
    required JobRepository jobRepository,
  }) : _jobRepository = jobRepository;

  @override
  Future<Either<Failures, bool>> call(FavoriteJobRequestParams params) async {
    return await _jobRepository.saveToFavorite(params);
  }
}

class FavoriteJobRequestParams extends Equatable {
  final int jobId;
  final int userId;
  const FavoriteJobRequestParams({
    required this.jobId,
    required this.userId,
  });

  Map<String, dynamic> toJson() {
    return {
      'jobId': jobId,
      'userId': userId,
    };
  }

  @override
  List<Object?> get props => [jobId, userId];
}
