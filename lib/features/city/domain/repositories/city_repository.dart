import "package:dartz/dartz.dart";
import "package:qatjobs/core/error/failures.dart";
import "package:qatjobs/core/usecases/usecases.dart";
import "package:qatjobs/features/city/data/models/city_model.codegen.dart";

abstract class CityRepository {
	Future<Either<Failures,List<CityModel>>> getCity(NoParams params);
}
