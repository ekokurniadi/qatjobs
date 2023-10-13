import "package:dartz/dartz.dart";
import "package:qatjobs/core/error/failures.dart";
import "package:qatjobs/core/usecases/usecases.dart";
import "package:qatjobs/features/company/domain/repositories/company_repository.dart";
import "package:qatjobs/features/company/data/datasources/remote/company_remote_datasource.dart";
import "package:qatjobs/features/company/data/models/company_model.codegen.dart";

class CompanyRepositoryImpl implements CompanyRepository {
  final CompanyRemoteDataSource _companyRemoteDataSource;

  const CompanyRepositoryImpl({
    required CompanyRemoteDataSource companyRemoteDataSource,
  }) : _companyRemoteDataSource = companyRemoteDataSource;

  @override
  Future<Either<Failures, List<CompanyModel>>> getCompany(
      NoParams params) async {
    return await _companyRemoteDataSource.getCompany(params);
  }
}
