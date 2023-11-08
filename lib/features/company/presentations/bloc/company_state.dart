part of 'company_bloc.dart';

enum CompanyStatus{initial,loading,success,failure,getFavoriteCompany,addFavoriteCompany,reportCompany}

@freezed
class CompanyState with _$CompanyState {

  const factory CompanyState({
    required CompanyStatus status,
    required String message,
    required List<CompanyModel> companies,
    required List<CompanyModel> favoriteCompanies,
    required bool hasMaxReached,
    required int currentPage,
  })= _CompanyState;


  factory CompanyState.initial() => const CompanyState(
    status: CompanyStatus.initial,
    message: '',
    companies: [],
    currentPage: 1,
    hasMaxReached: false,
    favoriteCompanies: [],
  );
}
