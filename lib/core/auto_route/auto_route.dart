import 'package:auto_route/annotations.dart';
import 'package:qatjobs/initial_page.dart';

@MaterialAutoRouter(
  replaceInRouteName: 'Page,Route',
  routes: <AutoRoute>[
    AutoRoute(
      page: InitialPage,
      initial: true,
    ),
  ],
)
// ignore: prefer-match-file-name
class $AppRouter {}
