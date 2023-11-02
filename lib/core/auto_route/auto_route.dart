import 'package:auto_route/annotations.dart';
import 'package:qatjobs/features/article/presentations/pages/article_detail_page.dart';
import 'package:qatjobs/features/auth/login/presentations/pages/login_page.dart';
import 'package:qatjobs/features/auth/register/presentations/pages/register_page.dart';
import 'package:qatjobs/features/job/presentations/pages/job_detail_page.dart';
import 'package:qatjobs/features/job/presentations/widgets/job_filter.dart';
import 'package:qatjobs/features/layouts/presentations/pages/layouts_page.dart';
import 'package:qatjobs/features/notification/presentations/pages/notification_page.dart';
import 'package:qatjobs/features/profile/candidate/presentations/pages/candidate_add_resume_page.dart';
import 'package:qatjobs/features/profile/candidate/presentations/pages/candidate_carrer_information_page.dart';
import 'package:qatjobs/features/profile/candidate/presentations/pages/candidate_general_profile_page.dart';
import 'package:qatjobs/features/profile/candidate/presentations/pages/candidate_profile_detail_page.dart';
import 'package:qatjobs/features/profile/candidate/presentations/pages/candidate_profile_page.dart';
import 'package:qatjobs/features/profile/candidate/presentations/pages/candidate_resume_page.dart';
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
  ],
)
// ignore: prefer-match-file-name
class $AppRouter {}
