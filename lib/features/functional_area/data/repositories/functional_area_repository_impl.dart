import "package:dartz/dartz.dart";
import "package:injectable/injectable.dart";
import "package:qatjobs/core/error/failures.dart";
import "package:qatjobs/core/usecases/usecases.dart";
import "package:qatjobs/features/functional_area/domain/repositories/functional_area_repository.dart";
import "package:qatjobs/features/functional_area/data/datasources/remote/functional_area_remote_datasource.dart";
import "package:qatjobs/features/functional_area/data/models/functional_area_model.codegen.dart";

@LazySingleton(as:FunctionalAreaRepository)
class FunctionalAreaRepositoryImpl implements FunctionalAreaRepository {
  final FunctionalAreaRemoteDataSource _functionalAreaRemoteDataSource;

  const FunctionalAreaRepositoryImpl({
    required FunctionalAreaRemoteDataSource functionalAreaRemoteDataSource,
  }) : _functionalAreaRemoteDataSource = functionalAreaRemoteDataSource;

  @override
  Future<Either<Failures, List<FunctionalAreaModel>>> getFunctionalArea(
      NoParams params) async {
    return await _functionalAreaRemoteDataSource.getFunctionalArea(params);
  }
}
