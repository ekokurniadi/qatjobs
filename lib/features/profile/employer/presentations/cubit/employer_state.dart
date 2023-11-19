part of 'employer_cubit.dart';

enum EmployerStatus {
  initial,
  loading,
  getProfileSuccess,
  updateProfileSuccess,
  updateProfileCompanySuccess,
  changePasswordSuccess,
  updateJobStatus,
  getJobApplicant,
  failure,
  jobLoaded,
}

@freezed
class EmployerState with _$EmployerState {
  const factory EmployerState({
    required EmployerStatus status,
    required CompanyModel companyModel,
    required String message,
    required List<JobModel> jobs,
    required List<JobModel> filteredJob,
    required bool hasReachMax,
    required int currentPage,
    required String query,
    required List<JobApplicationModel> jobApplicants,
  }) = _EmployerState;

  factory EmployerState.initial() => EmployerState(
        status: EmployerStatus.initial,
        companyModel: CompanyModel(),
        message: '',
        jobs: [],
        filteredJob: [],
        hasReachMax: false,
        currentPage: 1,
        query: '',
        jobApplicants: [],
      );
}
