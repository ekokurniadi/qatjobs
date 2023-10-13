import "package:dartz/dartz.dart";
import "package:qatjobs/core/error/failures.dart";
import "package:qatjobs/core/usecases/usecases.dart";
import "package:qatjobs/features/active_featured/domain/repositories/active_featured_repository.dart";
import "package:qatjobs/features/active_featured/data/datasources/remote/active_featured_remote_datasource.dart";
import "package:qatjobs/features/active_featured/data/models/active_featured_model.codegen.dart";

class ActiveFeaturedRepositoryImpl implements ActiveFeaturedRepository {
  final ActiveFeaturedRemoteDataSource _activeFeaturedRemoteDataSource;

  const ActiveFeaturedRepositoryImpl({
    required ActiveFeaturedRemoteDataSource activeFeaturedRemoteDataSource,
  }) : _activeFeaturedRemoteDataSource = activeFeaturedRemoteDataSource;

  @override
  Future<Either<Failures, List<ActiveFeaturedModel>>> getActiveFeatured(
      NoParams params) async {
    return await _activeFeaturedRemoteDataSource.getActiveFeatured(params);
  }
}
