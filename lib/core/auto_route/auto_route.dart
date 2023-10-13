import 'package:auto_route/annotations.dart';
import 'package:qatjobs/features/auth/login/presentations/pages/login_page.dart';
import 'package:qatjobs/features/layouts/presentations/pages/layouts_page.dart';
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
  ],
)
// ignore: prefer-match-file-name
class $AppRouter {}
