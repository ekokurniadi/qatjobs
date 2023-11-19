import 'package:dartz/dartz.dart';
import 'package:qatjobs/core/error/failures.dart';
import 'package:qatjobs/core/usecases/usecases.dart';
import 'package:qatjobs/features/notification/data/models/notification_models.codegen.dart';

abstract class NotificationRepository {
  Future<Either<Failures, List<NotificationModel>>> getNotif(NoParams params);
}
