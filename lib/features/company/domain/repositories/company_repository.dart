import "package:dartz/dartz.dart";
import "package:qatjobs/core/error/failures.dart";
import "package:qatjobs/core/usecases/usecases.dart";
import "package:qatjobs/features/company/data/models/company_model.codegen.dart";
import "package:qatjobs/features/company/domain/usecases/add_favorite_company_usecase.dart";
import "package:qatjobs/features/company/domain/usecases/get_company_usecase.dart";
import "package:qatjobs/features/company/domain/usecases/report_company_usecase.dart";

abstract class CompanyRepository {
  Future<Either<Failures, List<CompanyModel>>> getCompany(
      CompanyRequestParams params);
  Future<Either<Failures, bool>> addFavoriteCompany(
    AddFavoriteCompanyRequestParams params,
  );
  Future<Either<Failures, bool>> report(ReportCompanyRequestParams params);
  Future<Either<Failures, List<CompanyModel>>> getFavoriteCompany(
      NoParams params);
}
