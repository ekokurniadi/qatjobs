import 'dart:developer';

import 'package:auto_route/auto_route.dart';
import 'package:flutter/material.dart';

class AutoRouteObserver extends AutoRouterObserver {
  @override
  void didPush(Route route, Route? previousRoute) {
    log('New route pushed: ${route.settings.name}');
  }

  @override
  void didPop(Route route, Route? previousRoute) {
    log('Route pop: ${route.settings.name}');
  }

  @override
  void didRemove(Route route, Route? previousRoute) {
    log('Route Remove: ${route.settings.name}');
  }

  @override
  void didReplace({Route? newRoute, Route? oldRoute}) {
    log('Route replace: ${newRoute?.settings.name}');
  }
}
