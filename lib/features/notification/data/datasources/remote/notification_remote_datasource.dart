import 'dart:convert';

import 'package:dartz/dartz.dart';
import 'package:dio/dio.dart';
import 'package:injectable/injectable.dart';
import 'package:qatjobs/core/constant/url_constant.dart';
import 'package:qatjobs/core/error/failures.dart';
import 'package:qatjobs/core/extensions/dio_response_extension.dart';
import 'package:qatjobs/core/helpers/dio_helper.dart';
import 'package:qatjobs/core/helpers/global_helper.dart';
import 'package:qatjobs/core/helpers/notification_helper.dart';
import 'package:qatjobs/core/usecases/usecases.dart';
import 'package:qatjobs/features/notification/data/models/notification_models.codegen.dart';
import 'package:qatjobs/injector.dart';
import 'package:shared_preferences/shared_preferences.dart';

abstract class NotificationRemoteDataSource {
  Future<Either<Failures, List<NotificationModel>>> getNotif(NoParams params);
}

@LazySingleton(as: NotificationRemoteDataSource)
class NotificationLocalDataSourceImpl implements NotificationRemoteDataSource {
  final Dio _dio;
  const NotificationLocalDataSourceImpl(this._dio);

  @override
  Future<Either<Failures, List<NotificationModel>>> getNotif(
    NoParams params,
  ) async {
    try {
      final response = await _dio.get(URLConstant.employerNotification);
      if (response.isOk) {
        final tempNotif = getIt<SharedPreferences>().getStringList('notifData');
        final result = List<NotificationModel>.from(
          response.data['message'].map(
            (e) => NotificationModel.fromJson(e),
          ),
        );

        if (!GlobalHelper.isEmptyList(tempNotif)) {
          await getIt<SharedPreferences>().remove('notifData');
          for (var notif in tempNotif!) {
            final notifModel = NotificationModel.fromJson(jsonDecode(notif));
            for (var remoteNotif in result) {
              if (notifModel.id != remoteNotif.id &&
                  !GlobalHelper.isEmpty(remoteNotif.readAt)) {
                NotificationService().showNotification(
                  id: remoteNotif.id,
                  title: 'Notification',
                  body: remoteNotif.title,
                  payLoad: jsonEncode(
                    {
                      'action': 'open',
                      'data': remoteNotif.toJson(),
                    },
                  ),
                );
              }
            }
          }

          await getIt<SharedPreferences>().setStringList(
            'notifData',
            List<String>.from(
              result.map(
                (e) => jsonEncode(
                  e.toJson(),
                ),
              ),
            ).toList(),
          );
        } else {
          await getIt<SharedPreferences>().setStringList(
            'notifData',
            List<String>.from(
              result.map(
                (e) => jsonEncode(
                  e.toJson(),
                ),
              ),
            ).toList(),
          );

          for (var remoteNotif in result) {
            NotificationService().showNotification(
              id: remoteNotif.id,
              title: 'Notification',
              body: remoteNotif.title,
              payLoad: jsonEncode(
                {
                  'action': 'open',
                  'data': remoteNotif.toJson(),
                },
              ),
            );
          }
        }

        return right(result);
      }
      return left(
        ServerFailure(
          errorMessage: response.data['message'],
        ),
      );
    } on DioError catch (e) {
      final message = DioHelper.formatException(e);
      return left(
        ServerFailure(
          errorMessage: message,
        ),
      );
    } catch (e) {
      return left(
        ServerFailure(
          errorMessage: e.toString(),
        ),
      );
    }
  }
}
