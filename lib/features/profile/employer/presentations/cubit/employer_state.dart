part of 'employer_cubit.dart';

enum EmployerStatus {
  initial,
  loading,
  getProfileSuccess,
  updateProfileSuccess,
  changePasswordSuccess,
  failure,
}

@freezed
class EmployerState with _$EmployerState {
  const factory EmployerState({
    required EmployerStatus status,
    required CompanyModel companyModel,
    required String message,
  }) = _EmployerState;

  factory EmployerState.initial() => EmployerState(
        status: EmployerStatus.initial,
        companyModel: CompanyModel(),
        message: '',
      );
}
