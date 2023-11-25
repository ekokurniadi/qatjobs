import 'package:qatjobs/features/profile/employer/domain/usecases/update_job_status_usecase.dart';

abstract class URLConstant {
  /// PUBLIC URL
  static const String baseURL = 'https://job.witek-inspire.net/api';
  static const String login = '/sanctum/token';
  static const String register = '/register';
  static const String jobSearch = '/jobs/search';
  static const String jobSearchAutoComplete = '/jobs/search-autocomplete';
  static const String homeFrontData = '/front-data';
  static const String categories = '/jobs/categories';
  static const String skill = '/jobs/skills';
  static const String careerLevel = '/jobs/career-levels';
  static const String functionalArea = '/jobs/functional-areas';
  static const String jobTypes = '/jobs/types';
  static const String ownerShipTypes = '/ownership-types';
  static const String article = '/articles';
  static const String articleDetail = '/articles/detail/';
  static const String articleCategory = '/articles/categories';
  static const String articleByCategoryId = '/articles/by-category/';
  static const String currencies = '/jobs/salaries/currencies';
  static const String degreeLevel = '/jobs/degrees';
  static const String companies = '/companies/search';
  static const String aboutUs = '/about-us';
  static const String industry = '/industries';
  static const String jobShift = '/jobs/job-shifts';
  static const String jobSalaryPeriod = '/jobs/salaries/periods';
  static const String jobTags = '/jobs/tags';

  /// CANDIDATE URL
  static const String candidateProfile = '/candidate/profiles';
  static const String candidateChangePassword =
      '/candidate/profiles/change-password';
  static const String candidateUpdateProfile = '/candidate/profiles/update';
  static const String candidateUpdateGeneralProfile =
      '/candidate/profiles/update-general-profile';
  static const String candidateGetResume = '/candidate/profiles/resumes';
  static const String candidateGetExperiences = '/candidate/experiences';
  static const String candidateEducation = '/candidate/educations';
  static const String candidateFavoriteJob = '/candidate/jobs/favourite-jobs';
  static const String candidateAppliedJob = '/candidate/jobs/applied';
  static const String candidateJobAlert = '/candidate/jobs/job-alerts';
  static String candidateJobApply(int id) => '/candidate/jobs/$id/apply-job';
  static String candidateReportCompany(int id) =>
      '/candidate/companies/$id/report-to-company';
  static String candidateJobEmailToFriend(int id) =>
      '/candidate/jobs/$id/email-job';
  static const String candidateFavoriteCompany =
      '/candidate/favourite-companies';
  static const String candidateCVBuilder = '/candidate/profiles/cv-data';

  // EMPLOYER
  static const String employerFollowers = '/employer/followers';
  static const String employerNotification = '/notifications';
  static const String employerProfile = '/employer/profiles';
  static const String employerProfileCompany = '/employer/company';
  static const String employerProfileUpdate = '/employer/profiles/update';
  static const String employerProfileChangePassword =
      '/employer/profiles/change-password';
  static const String employerJobs = '/employer/jobs';
  static String updateJobsStatus(UpdateJobStatusParams params) =>
      '/employer/jobs/${params.jobId}/status/${params.status}';
  static const String employerJobStages = '/employer/jobs/stages';
  static String employerJobApplicant(int id) =>
      '/employer/jobs/$id/applications';
  static String employerJobDetailCandidate(int id) =>
      '/employer/candidates/detail/$id';
}
