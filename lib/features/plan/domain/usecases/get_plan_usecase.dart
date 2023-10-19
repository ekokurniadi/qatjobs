import "package:dartz/dartz.dart";
import "package:injectable/injectable.dart";

import "package:qatjobs/core/error/failures.dart";
import "package:qatjobs/core/usecases/usecases.dart";
import "package:qatjobs/features/plan/data/models/plan_model.codegen.dart";
import "package:qatjobs/features/plan/domain/repositories/plan_repository.dart";

@injectable
class GetPlanUseCase implements UseCase<List<PlanModel>, NoParams> {
  final PlanRepository _planRepository;

  GetPlanUseCase({
    required PlanRepository planRepository,
  }) : _planRepository = planRepository;

  @override
  Future<Either<Failures, List<PlanModel>>> call(NoParams params) async {
    return await _planRepository.getPlan(params);
  }
}
