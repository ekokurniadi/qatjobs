import "package:dartz/dartz.dart";
import "package:injectable/injectable.dart";
import "package:qatjobs/core/error/failures.dart";
import "package:qatjobs/core/usecases/usecases.dart";
import "package:qatjobs/features/industry/data/datasources/remote/industry_remote_datasource.dart";
import "package:qatjobs/features/industry/data/models/industry_model.codegen.dart";
import "package:qatjobs/features/industry/domain/repositories/industry_repository.dart";

@LazySingleton(as: IndustryRepository)
class IndustryRepositoryImpl implements IndustryRepository {
  final IndustryRemoteDataSource _industryRemoteDataSource;

  const IndustryRepositoryImpl({
    required IndustryRemoteDataSource industryRemoteDataSource,
  }) : _industryRemoteDataSource = industryRemoteDataSource;

  @override
  Future<Either<Failures, List<IndustryModel>>> getIndustry(
      NoParams params) async {
    return await _industryRemoteDataSource.getIndustry(params);
  }
}
