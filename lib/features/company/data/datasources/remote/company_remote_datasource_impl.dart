import "package:dartz/dartz.dart";
import "package:qatjobs/core/error/failures.dart";
import "package:qatjobs/core/usecases/usecases.dart";
import "company_remote_datasource.dart";
import "package:qatjobs/features/company/data/models/company_model.codegen.dart";

class CompanyRemoteDataSourceImpl implements CompanyRemoteDataSource {
  @override
  Future<Either<Failures, List<CompanyModel>>> getCompany(
      NoParams params) async {
    // TODO: implement execute
    throw UnimplementedError();
  }
}
