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
  static const String article = '/articles';
  static const String articleDetail = '/articles/detail/';
  static const String articleCategory = '/articles/categories';
  static const String articleByCategoryId = '/articles/by-category/';
  static const String currencies = '/jobs/salaries/currencies';


  /// CANDIDATE URL
  static const String candidateProfile = '/candidate/profiles';
  static const String candidateChangePassword = '/candidate/profiles/change-password';
  static const String candidateUpdateProfile = '/candidate/profiles/update';
  static const String candidateUpdateGeneralProfile = '/candidate/profiles/update-general-profile';
  static const String candidateGetResume = '/candidate/profiles/resumes';

}
