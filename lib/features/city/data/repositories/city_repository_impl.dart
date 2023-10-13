import "package:dartz/dartz.dart";
import "package:qatjobs/core/error/failures.dart";
import "package:qatjobs/core/usecases/usecases.dart";
import "package:qatjobs/features/city/domain/repositories/city_repository.dart";
import "package:qatjobs/features/city/data/datasources/remote/city_remote_datasource.dart";
import "package:qatjobs/features/city/data/models/city_model.codegen.dart";

class CityRepositoryImpl implements CityRepository {
	final CityRemoteDataSource _cityRemoteDataSource;

	const CityRepositoryImpl({
	
		required CityRemoteDataSource cityRemoteDataSource,
}):
_cityRemoteDataSource =cityRemoteDataSource;

	@override
	Future<Either<Failures,List<CityModel>>> getCity(NoParams params) async{
		return await _cityRemoteDataSource.getCity(params);
	}
}
