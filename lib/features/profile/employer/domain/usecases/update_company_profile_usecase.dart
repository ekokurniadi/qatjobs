

import 'package:dartz/dartz.dart';
import 'package:injectable/injectable.dart';
import 'package:qatjobs/core/error/failures.dart';
import 'package:qatjobs/core/usecases/usecases.dart';
import 'package:qatjobs/features/company/data/models/company_model.codegen.dart';
import 'package:qatjobs/features/profile/employer/domain/repositories/employer_repository.dart';

@injectable
class EmployerUpdateProfileCompany
    implements UseCase<bool, CompanyModel> {
  final EmployerRepository _repository;

  const EmployerUpdateProfileCompany(this._repository);

  @override
  Future<Either<Failures, bool>> call(
    CompanyModel params,
  ) async {
    return await _repository.updateCompanyProfile(params);
  }
}