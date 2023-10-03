import 'package:dartz/dartz.dart';
import 'package:injectable/injectable.dart';
import 'package:qatjobs/core/error/failures.dart';
import 'package:qatjobs/features/auth/data/datasources/remote/auth_remote_datasource.dart';
import 'package:qatjobs/features/auth/data/models/login_model.codegen.dart';
import 'package:qatjobs/features/auth/domain/repositories/auth_repository.dart';
import 'package:qatjobs/features/auth/domain/usecases/login_usecase.dart';

@LazySingleton(as: AuthRepository)
class AuthRepositoryImpl implements AuthRepository {
  const AuthRepositoryImpl(
    this._dataSource,
  );
  final AuthRemoteDataSource _dataSource;

  @override
  Future<Either<Failures, LoginModel>> login(LoginRequestParams params) async {
    return await _dataSource.login(params);
  }
}
