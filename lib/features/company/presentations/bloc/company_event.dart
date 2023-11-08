part of 'company_bloc.dart';

@freezed
class CompanyEvent with _$CompanyEvent {
  const factory CompanyEvent.started(
    CompanyRequestParams params, {
    bool? isReset,
  }) = _Started;
  const factory CompanyEvent.getFavoriteCompany() = _GetFavoriteCompany;
  const factory CompanyEvent.addFavoriteCompany(
      AddFavoriteCompanyRequestParams params) = _AddFavoriteCompany;
  const factory CompanyEvent.reportCompany(ReportCompanyRequestParams params) =
      _ReportCompany;
}
