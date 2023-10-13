import "package:dartz/dartz.dart";
import "package:qatjobs/core/error/failures.dart";
import "package:qatjobs/core/usecases/usecases.dart";
import "city_remote_datasource.dart";
import "package:qatjobs/features/city/data/models/city_model.codegen.dart";

class CityRemoteDataSourceImpl implements CityRemoteDataSource {
	@override
	Future<Either<Failures,List<CityModel>>> getCity(NoParams params) async{
		// TODO: implement execute 
		throw UnimplementedError();
	}
}
