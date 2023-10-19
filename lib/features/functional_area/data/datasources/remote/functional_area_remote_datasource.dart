import "package:dartz/dartz.dart";
import "package:qatjobs/core/error/failures.dart";
import "package:qatjobs/core/usecases/usecases.dart";
import "package:qatjobs/features/functional_area/data/models/functional_area_model.codegen.dart";

abstract class FunctionalAreaRemoteDataSource {
  Future<Either<Failures, List<FunctionalAreaModel>>> getFunctionalArea(
      NoParams params);
}
