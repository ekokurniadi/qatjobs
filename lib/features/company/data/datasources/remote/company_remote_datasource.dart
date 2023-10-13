import "package:dartz/dartz.dart";
import "package:qatjobs/core/error/failures.dart";
import "package:qatjobs/core/usecases/usecases.dart";
import "package:qatjobs/features/company/data/models/company_model.codegen.dart";

abstract class CompanyRemoteDataSource {
	Future<Either<Failures,List<CompanyModel>>> getCompany(NoParams params);
}
