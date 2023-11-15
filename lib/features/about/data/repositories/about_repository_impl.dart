import "package:dartz/dartz.dart";
import "package:injectable/injectable.dart";
import "package:qatjobs/core/error/failures.dart";
import "package:qatjobs/core/usecases/usecases.dart";
import "package:qatjobs/features/about/domain/repositories/about_repository.dart";
import "package:qatjobs/features/about/data/datasources/remote/about_remote_datasource.dart";
import "package:qatjobs/features/about/data/models/about_model.codegen.dart";

@LazySingleton(as:AboutRepository)
class AboutRepositoryImpl implements AboutRepository {
  final AboutRemoteDataSource _aboutRemoteDataSource;

  const AboutRepositoryImpl({
    required AboutRemoteDataSource aboutRemoteDataSource,
  }) : _aboutRemoteDataSource = aboutRemoteDataSource;

  @override
  Future<Either<Failures, List<AboutModel>>> getAbout(NoParams params) async {
    return await _aboutRemoteDataSource.getAbout(params);
  }
}
