import "package:dartz/dartz.dart";
import "package:qatjobs/core/error/failures.dart";
import "package:qatjobs/core/usecases/usecases.dart";
import "package:qatjobs/features/industry/data/models/industry_model.codegen.dart";

abstract class IndustryRemoteDataSource {
  Future<Either<Failures, List<IndustryModel>>> getIndustry(NoParams params);
}
