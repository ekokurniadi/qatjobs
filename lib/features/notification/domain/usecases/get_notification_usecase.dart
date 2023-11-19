import "package:dartz/dartz.dart";
import "package:injectable/injectable.dart";

import "package:qatjobs/core/error/failures.dart";
import "package:qatjobs/core/usecases/usecases.dart";
import "package:qatjobs/features/notification/data/models/notification_models.codegen.dart";
import "package:qatjobs/features/notification/domain/repositories/notification_repository.dart";

@injectable
class GetNotification implements UseCase<List<NotificationModel>, NoParams> {
  final NotificationRepository _repository;

  const GetNotification(this._repository);

  @override
  Future<Either<Failures, List<NotificationModel>>> call(
      NoParams params) async {
    return await _repository.getNotif(params);
  }
}
