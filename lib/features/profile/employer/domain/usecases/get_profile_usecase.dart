import 'package:dartz/dartz.dart';
import 'package:injectable/injectable.dart';
import 'package:qatjobs/core/error/failures.dart';
import 'package:qatjobs/core/usecases/usecases.dart';
import 'package:qatjobs/features/company/data/models/company_model.codegen.dart';
import 'package:qatjobs/features/profile/employer/domain/repositories/employer_repository.dart';

@injectable
class GetProfileEmployerUserCase implements UseCase<CompanyModel, NoParams> {
  final EmployerRepository _repository;

  const GetProfileEmployerUserCase(this._repository);

  @override
  Future<Either<Failures, CompanyModel>> call(NoParams params) async {
    return await _repository.getProfileEmployer(params);
  }
}
