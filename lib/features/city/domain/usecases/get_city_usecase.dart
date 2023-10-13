import "package:dartz/dartz.dart";
import "package:qatjobs/core/error/failures.dart";
import "package:qatjobs/core/usecases/usecases.dart";
import "package:qatjobs/features/city/domain/repositories/city_repository.dart";
import "package:qatjobs/features/city/data/models/city_model.codegen.dart";

class GetCityUseCase implements UseCase<List<CityModel>,NoParams>{
	final CityRepository _cityRepository;

	GetCityUseCase({
		required CityRepository cityRepository,
}):_cityRepository =cityRepository;

	@override
	Future<Either<Failures,List<CityModel>>> call(NoParams params) async{
		return await _cityRepository.getCity(params);
	}
}
