import "package:dartz/dartz.dart";
import "package:qatjobs/core/error/failures.dart";
import "package:qatjobs/core/usecases/usecases.dart";
import "package:qatjobs/features/carrier_level/data/models/career_level_model.codegen.dart";

abstract class CareerLevelRepository {
  Future<Either<Failures, List<CareerLevelModel>>> getCareerLevel(
      NoParams params);
}
