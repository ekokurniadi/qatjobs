import "package:dartz/dartz.dart";
import "package:equatable/equatable.dart";
import "package:injectable/injectable.dart";
import "package:qatjobs/core/error/failures.dart";
import "package:qatjobs/core/usecases/usecases.dart";
import "package:qatjobs/features/company/domain/repositories/company_repository.dart";
import "package:qatjobs/features/company/data/models/company_model.codegen.dart";

@injectable
class GetCompanyUseCase implements UseCase<List<CompanyModel>, CompanyRequestParams> {
  final CompanyRepository _companyRepository;

  GetCompanyUseCase({
    required CompanyRepository companyRepository,
  }) : _companyRepository = companyRepository;

  @override
  Future<Either<Failures, List<CompanyModel>>> call(CompanyRequestParams params) async {
    return await _companyRepository.getCompany(params);
  }
}

class CompanyRequestParams extends Equatable {
  final String? name;
  final int? page;
  final int? limit;

  const CompanyRequestParams({
    this.name,
    this.page,
    this.limit,
  });

  Map<String, dynamic> toJson() {
    final data = <String, dynamic>{};
    if (name != null) {
      data['name'] = name;
      data['page'] = page;
    } else {
      data['perPage'] = limit;
      data['page'] = page;
    }
    return data;
  }

  @override
  List<Object?> get props => [
        name,
        page,
        limit,
      ];
}
