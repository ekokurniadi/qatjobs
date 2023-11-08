import "package:dartz/dartz.dart";
import "package:injectable/injectable.dart";
import "package:qatjobs/core/error/failures.dart";
import "package:qatjobs/core/usecases/usecases.dart";
import "package:qatjobs/features/company/domain/repositories/company_repository.dart";
import "package:qatjobs/features/company/data/datasources/remote/company_remote_datasource.dart";
import "package:qatjobs/features/company/data/models/company_model.codegen.dart";
import "package:qatjobs/features/company/domain/usecases/add_favorite_company_usecase.dart";
import "package:qatjobs/features/company/domain/usecases/get_company_usecase.dart";
import "package:qatjobs/features/company/domain/usecases/report_company_usecase.dart";

@LazySingleton(as: CompanyRepository)
class CompanyRepositoryImpl implements CompanyRepository {
  final CompanyRemoteDataSource _companyRemoteDataSource;

  const CompanyRepositoryImpl({
    required CompanyRemoteDataSource companyRemoteDataSource,
  }) : _companyRemoteDataSource = companyRemoteDataSource;

  @override
  Future<Either<Failures, List<CompanyModel>>> getCompany(
      CompanyRequestParams params) async {
    return await _companyRemoteDataSource.getCompany(params);
  }

  @override
  Future<Either<Failures, bool>> addFavoriteCompany(
      AddFavoriteCompanyRequestParams params) async {
    return await _companyRemoteDataSource.addFavoriteCompany(params);
  }

  @override
  Future<Either<Failures, bool>> report(
      ReportCompanyRequestParams params) async {
    return await _companyRemoteDataSource.report(params);
  }

  @override
  Future<Either<Failures, List<CompanyModel>>> getFavoriteCompany(NoParams params) async{
     return await _companyRemoteDataSource.getFavoriteCompany(params);
  }
}
