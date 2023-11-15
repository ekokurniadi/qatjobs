import 'package:auto_route/annotations.dart';
import 'package:qatjobs/features/about/presentations/pages/about_us_page.dart';
import 'package:qatjobs/features/article/presentations/pages/article_detail_page.dart';
import 'package:qatjobs/features/auth/login/presentations/pages/login_page.dart';
import 'package:qatjobs/features/auth/register/presentations/pages/register_page.dart';
import 'package:qatjobs/features/company/presentations/pages/company_page.dart';
import 'package:qatjobs/features/job/presentations/pages/applied_jobs_page.dart';
import 'package:qatjobs/features/job/presentations/pages/apply_job_page.dart';
import 'package:qatjobs/features/job/presentations/pages/favorite_job_page.dart';
import 'package:qatjobs/features/job/presentations/pages/job_alert_page.dart';
import 'package:qatjobs/features/job/presentations/pages/job_detail_page.dart';
import 'package:qatjobs/features/job/presentations/widgets/job_filter.dart';
import 'package:qatjobs/features/job_category/presentations/pages/job_category_page.dart';
import 'package:qatjobs/features/layouts/presentations/pages/layouts_page.dart';
import 'package:qatjobs/features/notification/presentations/pages/notification_page.dart';
import 'package:qatjobs/features/profile/candidate/presentations/pages/candidate_add_resume_page.dart';
import 'package:qatjobs/features/profile/candidate/presentations/pages/candidate_carrer_information_page.dart';
import 'package:qatjobs/features/profile/candidate/presentations/pages/candidate_change_password_page.dart';
import 'package:qatjobs/features/profile/candidate/presentations/pages/candidate_general_profile_page.dart';
import 'package:qatjobs/features/profile/candidate/presentations/pages/candidate_profile_detail_page.dart';
import 'package:qatjobs/features/profile/candidate/presentations/pages/candidate_profile_page.dart';
import 'package:qatjobs/features/profile/candidate/presentations/pages/candidate_resume_page.dart';
import 'package:qatjobs/features/profile/candidate/presentations/pages/cv_builder_page.dart';
import 'package:qatjobs/features/profile/employer/presentations/pages/change_password_page.dart';
import 'package:qatjobs/features/profile/employer/presentations/pages/profile_page.dart';
import 'package:qatjobs/features/splash_screen/presentations/pages/splash_screen_page.dart';
import 'package:qatjobs/features/welcome_screen/presentations/pages/welcome_screen_page.dart';

@MaterialAutoRouter(
  replaceInRouteName: 'Page,Route',
  routes: <AutoRoute>[
    AutoRoute(
      page: SplashScreenPage,
      initial: true,
    ),
    AutoRoute(
      page: WelcomeScreenPage,
    ),
    AutoRoute(
      page: LoginPage,
    ),
    AutoRoute(
      page: LayoutsPage,
    ),
    AutoRoute(
      page: JobFilterPage,
    ),
    AutoRoute(
      page: NotificationPage,
    ),
    AutoRoute(
      page: ArticleDetailPage,
    ),
    AutoRoute(
      page: JobDetailPage,
    ),
    AutoRoute(
      page: RegisterPage,
    ),
    AutoRoute(
      page: CandidateProfilePage,
    ),
    AutoRoute(
      page: CandidateProfileDetailPage,
    ),
    AutoRoute(
      page: CandidateGeneralProfilePage,
    ),
    AutoRoute(
      page: CandidateResumePage,
    ),
    AutoRoute(
      page: CandidateAddResumePage,
    ),
    AutoRoute(
      page: CandidateCareerInformationPage,
    ),
    AutoRoute(
      page: FavoriteJobPage,
    ),
    AutoRoute(
      page: ApplyJobPage,
    ),
    AutoRoute(
      page: AppliedJobsPage,
    ),
    AutoRoute(
      page: CompanyPage,
    ),
    AutoRoute(
      page: JobCategoryPage,
    ),
    AutoRoute(
      page: JobAlertPage,
    ),
    AutoRoute(
      page: CandidateChangePasswordPage,
    ),
    AutoRoute(
      page: AboutUsPage,
    ),
    AutoRoute(
      page: CvBuilderPage,
    ),
    AutoRoute(
      page: EmployerChangePasswordPage,
    ),
    AutoRoute(
      page: ProfilePage,
    ),
  ],
)
// ignore: prefer-match-file-name
class $AppRouter {}
