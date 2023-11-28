import "package:dartz/dartz.dart";
import "package:injectable/injectable.dart";
import "package:qatjobs/core/error/failures.dart";
import "package:qatjobs/core/usecases/usecases.dart";
import "package:qatjobs/features/plan/data/models/plan_model.codegen.dart";
import "plan_remote_datasource.dart";

@LazySingleton(as: PlanRemoteDataSource)
class PlanRemoteDataSourceImpl implements PlanRemoteDataSource {
  @override
  Future<Either<Failures, List<PlanModel>>> getPlan(NoParams params) async {
    throw UnimplementedError();
  }
}
