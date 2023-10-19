import "package:dartz/dartz.dart";
import "package:injectable/injectable.dart";
import "package:qatjobs/core/error/failures.dart";
import "package:qatjobs/core/usecases/usecases.dart";
import "package:qatjobs/features/plan/data/datasources/remote/plan_remote_datasource.dart";
import "package:qatjobs/features/plan/data/models/plan_model.codegen.dart";
import "package:qatjobs/features/plan/domain/repositories/plan_repository.dart";

@LazySingleton(as:PlanRepository)
class PlanRepositoryImpl implements PlanRepository {
  final PlanRemoteDataSource _planRemoteDataSource;

  const PlanRepositoryImpl({
    required PlanRemoteDataSource planRemoteDataSource,
  }) : _planRemoteDataSource = planRemoteDataSource;

  @override
  Future<Either<Failures, List<PlanModel>>> getPlan(NoParams params) async {
    return await _planRemoteDataSource.getPlan(params);
  }
}
