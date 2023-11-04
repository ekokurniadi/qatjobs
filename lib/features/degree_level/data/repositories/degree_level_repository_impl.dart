import "package:dartz/dartz.dart";
import "package:injectable/injectable.dart";
import "package:qatjobs/core/error/failures.dart";
import "package:qatjobs/core/usecases/usecases.dart";
import "package:qatjobs/features/degree_level/domain/repositories/degree_level_repository.dart";
import "package:qatjobs/features/degree_level/data/datasources/remote/degree_level_remote_datasource.dart";
import "package:qatjobs/features/degree_level/data/models/degree_level_model.codegen.dart";

@LazySingleton(as: DegreeLevelRepository)
class DegreeLevelRepositoryImpl implements DegreeLevelRepository {
  final DegreeLevelRemoteDataSource _degreeLevelRemoteDataSource;

  const DegreeLevelRepositoryImpl({
    required DegreeLevelRemoteDataSource degreeLevelRemoteDataSource,
  }) : _degreeLevelRemoteDataSource = degreeLevelRemoteDataSource;

  @override
  Future<Either<Failures, List<DegreeLevelModel>>> getDegreeLevel(
      NoParams params) async {
    return await _degreeLevelRemoteDataSource.getDegreeLevel(params);
  }
}
