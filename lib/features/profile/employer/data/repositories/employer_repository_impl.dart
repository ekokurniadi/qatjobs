import 'package:dartz/dartz.dart';
import 'package:injectable/injectable.dart';
import 'package:qatjobs/core/error/failures.dart';
import 'package:qatjobs/core/usecases/usecases.dart';
import 'package:qatjobs/features/company/data/models/company_model.codegen.dart';
import 'package:qatjobs/features/profile/employer/data/datasources/remote/employer_remote_datasource.dart';
import 'package:qatjobs/features/profile/employer/domain/repositories/employer_repository.dart';
import 'package:qatjobs/features/profile/employer/domain/usecases/change_password_usecase.dart';
import 'package:qatjobs/features/profile/employer/domain/usecases/update_profile_usecase.dart';

@LazySingleton(as: EmployerRepository)
class EmployerRepositoryImpl implements EmployerRepository {
  final EmployerRemoteDataSource _dataSource;
  const EmployerRepositoryImpl(this._dataSource);

  @override
  Future<Either<Failures, CompanyModel>> getProfileEmployer(
    NoParams params,
  ) async {
    return await _dataSource.getProfileEmployer(params);
  }

  @override
  Future<Either<Failures, bool>> updateProfile(
      EmployerProfileRequestParams params) async {
    return await _dataSource.updateProfile(params);
  }

  @override
  Future<Either<Failures, bool>> changePassword(
    ChangePasswordRequestParams params,
  ) async {
  return await _dataSource.changePassword(params);
  }
  
  @override
  Future<Either<Failures, bool>> updateCompanyProfile(CompanyModel params) async{
   return await _dataSource.updateCompanyProfile(params);
  }
}
