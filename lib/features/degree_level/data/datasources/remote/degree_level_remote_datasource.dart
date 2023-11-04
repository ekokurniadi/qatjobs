import "package:dartz/dartz.dart";
import "package:qatjobs/core/error/failures.dart";
import "package:qatjobs/core/usecases/usecases.dart";
import "package:qatjobs/features/degree_level/data/models/degree_level_model.codegen.dart";

abstract class DegreeLevelRemoteDataSource {
	Future<Either<Failures,List<DegreeLevelModel>>> getDegreeLevel(NoParams params);
}
