import "package:dartz/dartz.dart";
import "package:injectable/injectable.dart";
import "package:qatjobs/core/error/failures.dart";
import "package:qatjobs/core/usecases/usecases.dart";
import "package:qatjobs/features/employer_type/data/models/employer_type_model.codegen.dart";
import "package:qatjobs/features/employer_type/domain/repositories/employer_type_repository.dart";


@injectable
class GetEmployerTypeUseCase implements UseCase<List<EmployerTypeModel>, NoParams> {
  final EmployerTypeRepository _employerTypeRepository;

  const GetEmployerTypeUseCase(
   this._employerTypeRepository,
  );

  @override
  Future<Either<Failures, List<EmployerTypeModel>>> call(NoParams params) async {
    return await _employerTypeRepository.getEmployerType(params);
  }
}
