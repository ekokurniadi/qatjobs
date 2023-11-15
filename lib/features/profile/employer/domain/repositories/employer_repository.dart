import 'package:dartz/dartz.dart';
import 'package:qatjobs/core/error/failures.dart';
import 'package:qatjobs/core/usecases/usecases.dart';
import 'package:qatjobs/features/company/data/models/company_model.codegen.dart';
import 'package:qatjobs/features/profile/employer/domain/usecases/change_password_usecase.dart';
import 'package:qatjobs/features/profile/employer/domain/usecases/update_profile_usecase.dart';

abstract class EmployerRepository {
  Future<Either<Failures, CompanyModel>> getProfileEmployer(NoParams params);
  Future<Either<Failures, bool>> updateProfile(
    EmployerProfileRequestParams params,
  );
  Future<Either<Failures, bool>> changePassword(
    ChangePasswordRequestParams params,
  );
  Future<Either<Failures, bool>> updateCompanyProfile(
    CompanyModel params,
  ) ;
}