import "package:dartz/dartz.dart";
import "package:equatable/equatable.dart";
import "package:injectable/injectable.dart";
import "package:qatjobs/core/error/failures.dart";
import "package:qatjobs/core/usecases/usecases.dart";
import "package:qatjobs/features/job/domain/repositories/job_repository.dart";

@injectable
class EmailToFriendUseCase
    implements UseCase<bool, EmailToFriendRequestParams> {
  final JobRepository _jobRepository;

  EmailToFriendUseCase({
    required JobRepository jobRepository,
  }) : _jobRepository = jobRepository;

  @override
  Future<Either<Failures, bool>> call(EmailToFriendRequestParams params) async {
    return await _jobRepository.emailToFriend(params);
  }
}

class EmailToFriendRequestParams extends Equatable {
  final int jobId;
  final String friendName;
  final String email;
  const EmailToFriendRequestParams({
    required this.jobId,
    required this.friendName,
    required this.email,
  });

  Map<String, dynamic> toJson() {
    return {
      'friend_name': friendName,
      'friend_email': email,
    };
  }

  @override
  List<Object?> get props => [jobId,friendName,email];
}
