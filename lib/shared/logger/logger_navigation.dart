import 'dart:developer';

import 'package:flutter/material.dart';

class LoggerNavigatorObserver extends NavigatorObserver {
  @override
  void didPush(Route route, Route? previousRoute) {
    _logNavigation(route.settings.name, 'push');
  }

  @override
  void didPop(Route route, Route? previousRoute) {
    _logNavigation(route.settings.name, 'pop');
  }

  @override
  void didReplace({Route? newRoute, Route? oldRoute}) {
    _logNavigation(newRoute?.settings.name, 'replace');
  }

  void _logNavigation(String? routeName, String action) {
    if (routeName != null) {
      log("Screen $action $routeName ", name: 'Navigation');
    }
  }
}
