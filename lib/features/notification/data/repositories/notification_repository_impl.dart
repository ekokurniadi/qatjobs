import 'package:dartz/dartz.dart';
import 'package:injectable/injectable.dart';
import 'package:qatjobs/core/error/failures.dart';
import 'package:qatjobs/core/usecases/usecases.dart';
import 'package:qatjobs/features/notification/data/datasources/remote/notification_remote_datasource.dart';
import 'package:qatjobs/features/notification/data/models/notification_models.codegen.dart';
import 'package:qatjobs/features/notification/domain/repositories/notification_repository.dart';

@LazySingleton(as: NotificationRepository)
class NotificationRepositoryImpl implements NotificationRepository {
  final NotificationRemoteDataSource _remote;

  const NotificationRepositoryImpl(
    this._remote,
  );
  @override
  Future<Either<Failures, List<NotificationModel>>> getNotif(
    NoParams params,
  ) async {
    return await _remote.getNotif(params);
  }
}
