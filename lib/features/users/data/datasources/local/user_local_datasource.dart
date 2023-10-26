import 'dart:convert';

import 'package:dartz/dartz.dart';
import 'package:injectable/injectable.dart';
import 'package:qatjobs/core/constant/app_constant.dart';
import 'package:qatjobs/core/error/failures.dart';
import 'package:qatjobs/core/helpers/global_helper.dart';
import 'package:qatjobs/core/usecases/usecases.dart';
import 'package:qatjobs/features/users/data/models/users_model.codegen.dart';
import 'package:shared_preferences/shared_preferences.dart';

abstract class UserLocalDataSource {
  Future<Either<Failures, UserModel?>> getLogedinUser(NoParams params);
}

@LazySingleton(as: UserLocalDataSource)
class UserLocalDataSourceImpl implements UserLocalDataSource {
  final SharedPreferences _preferences;

  const UserLocalDataSourceImpl(this._preferences);

  @override
  Future<Either<Failures, UserModel?>> getLogedinUser(
    NoParams params,
  ) async {
    try {
      final response = _preferences.getString(AppConstant.prefKeyUserLogin);

      if (!GlobalHelper.isEmpty(response)) {
        return right(UserModel.fromJson(jsonDecode(response!)));
      }
      return right(null);
    } catch (e) {
      return left(DatabaseFailure(errorMessage: e.toString()));
    }
  }
}
