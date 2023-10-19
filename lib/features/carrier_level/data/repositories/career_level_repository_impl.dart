import "package:dartz/dartz.dart";
import "package:injectable/injectable.dart";
import "package:qatjobs/core/error/failures.dart";
import "package:qatjobs/core/usecases/usecases.dart";
import "package:qatjobs/features/carrier_level/data/datasources/remote/career_level_remote_datasource.dart";
import "package:qatjobs/features/carrier_level/data/models/career_level_model.codegen.dart";
import "package:qatjobs/features/carrier_level/domain/repositories/career_level_repository.dart";

@LazySingleton(as:CareerLevelRepository)
class CareerLevelRepositoryImpl implements CareerLevelRepository {
  final CareerLevelRemoteDataSource _careerLevelRemoteDataSource;

  const CareerLevelRepositoryImpl({
    required CareerLevelRemoteDataSource careerLevelRemoteDataSource,
  }) : _careerLevelRemoteDataSource = careerLevelRemoteDataSource;

  @override
  Future<Either<Failures, List<CareerLevelModel>>> getCareerLevel(
      NoParams params) async {
    return await _careerLevelRemoteDataSource.getCareerLevel(params);
  }
}
