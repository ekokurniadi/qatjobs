import "package:dartz/dartz.dart";
import "package:injectable/injectable.dart";
import "package:qatjobs/core/error/failures.dart";
import "package:qatjobs/core/usecases/usecases.dart";
import "package:qatjobs/features/industry/data/models/industry_model.codegen.dart";
import "package:qatjobs/features/industry/domain/repositories/industry_repository.dart";


@injectable
class GetIndustryUseCase implements UseCase<List<IndustryModel>, NoParams> {
  final IndustryRepository _industryRepository;

  const GetIndustryUseCase(
   this._industryRepository,
  );

  @override
  Future<Either<Failures, List<IndustryModel>>> call(NoParams params) async {
    return await _industryRepository.getIndustry(params);
  }
}
