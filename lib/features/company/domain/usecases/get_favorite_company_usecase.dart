import "package:dartz/dartz.dart";
import "package:injectable/injectable.dart";
import "package:qatjobs/core/error/failures.dart";
import "package:qatjobs/core/usecases/usecases.dart";
import "package:qatjobs/features/company/domain/repositories/company_repository.dart";
import "package:qatjobs/features/company/data/models/company_model.codegen.dart";

@injectable
class GetFavoriteCompanyUseCase implements UseCase<List<CompanyModel>, NoParams> {
  final CompanyRepository _companyRepository;

  GetFavoriteCompanyUseCase({
    required CompanyRepository companyRepository,
  }) : _companyRepository = companyRepository;

  @override
  Future<Either<Failures, List<CompanyModel>>> call(NoParams params) async {
    return await _companyRepository.getFavoriteCompany(params);
  }
}