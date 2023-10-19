import "package:dartz/dartz.dart";
import "package:qatjobs/core/error/failures.dart";
import "package:qatjobs/core/usecases/usecases.dart";
import "package:qatjobs/features/plan/data/models/plan_model.codegen.dart";

abstract class PlanRepository {
	Future<Either<Failures,List<PlanModel>>> getPlan(NoParams params);
}
