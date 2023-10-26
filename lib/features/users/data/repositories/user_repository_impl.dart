import 'package:dartz/dartz.dart';
import 'package:injectable/injectable.dart';
import 'package:qatjobs/core/error/failures.dart';
import 'package:qatjobs/core/usecases/usecases.dart';
import 'package:qatjobs/features/users/data/datasources/local/user_local_datasource.dart';
import 'package:qatjobs/features/users/data/models/users_model.codegen.dart';
import 'package:qatjobs/features/users/domain/repositories/user_repository.dart';

@LazySingleton(as:UserRepository)
class UserRepositoryImpl implements UserRepository {
  final UserLocalDataSource _dataSource;
  const UserRepositoryImpl(this._dataSource);

  @override
  Future<Either<Failures, UserModel?>> getLogedinUser(
    NoParams params,
  ) async {
    return await _dataSource.getLogedinUser(params);
  }
}
