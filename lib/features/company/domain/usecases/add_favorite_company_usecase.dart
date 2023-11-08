import "package:dartz/dartz.dart";
import "package:equatable/equatable.dart";
import "package:injectable/injectable.dart";
import "package:qatjobs/core/error/failures.dart";
import "package:qatjobs/core/usecases/usecases.dart";
import "package:qatjobs/features/company/domain/repositories/company_repository.dart";

@injectable
class AddFavoriteCompanyUseCase
    implements UseCase<bool, AddFavoriteCompanyRequestParams> {
  final CompanyRepository _companyRepository;

  AddFavoriteCompanyUseCase({
    required CompanyRepository companyRepository,
  }) : _companyRepository = companyRepository;

  @override
  Future<Either<Failures, bool>> call(
      AddFavoriteCompanyRequestParams params) async {
    return await _companyRepository.addFavoriteCompany(params);
  }
}

class AddFavoriteCompanyRequestParams extends Equatable {
  final int userId;
  final int companyId;

  const AddFavoriteCompanyRequestParams({
    required this.userId,
    required this.companyId,
  });

  Map<String, dynamic> toJson() {
    return {
      'userId': userId,
      'companyId': companyId,
    };
  }

  @override
  List<Object?> get props => [userId, companyId];
}
