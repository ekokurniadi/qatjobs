import "package:dartz/dartz.dart";
import "package:equatable/equatable.dart";
import "package:injectable/injectable.dart";
import "package:qatjobs/core/error/failures.dart";
import "package:qatjobs/core/usecases/usecases.dart";
import "package:qatjobs/features/company/domain/repositories/company_repository.dart";

@injectable
class ReportCompanyUseCase
    implements UseCase<bool, ReportCompanyRequestParams> {
  final CompanyRepository _companyRepository;

  ReportCompanyUseCase({
    required CompanyRepository companyRepository,
  }) : _companyRepository = companyRepository;

  @override
  Future<Either<Failures, bool>> call(ReportCompanyRequestParams params) async {
    return await _companyRepository.report(params);
  }
}

class ReportCompanyRequestParams extends Equatable {
  final int id;
  final String notes;

  const ReportCompanyRequestParams({
    required this.id,
    required this.notes,
  });

  Map<String, dynamic> toJson() {
    return {
      'notes': notes,
    };
  }

  @override
  List<Object?> get props => [id, notes];
}
