import 'package:flutter/material.dart';
import 'package:future_lab_task/data/insurance_data.dart';
import 'package:future_lab_task/screens/detail_screen.dart';
import 'package:future_lab_task/screens/home_screen.dart';
import 'package:go_router/go_router.dart';
import '../logger/logger_navigation.dart';
import 'app_route.dart';

final navigatorKey = GlobalKey<NavigatorState>();

final goRouter = GoRouter(
  observers: [LoggerNavigatorObserver()],
  initialLocation: '/',
  debugLogDiagnostics: false,
  navigatorKey: navigatorKey,
  routes: [
    GoRoute(
      path: '/',
      name: AppRoute.homeScreen.name,
      builder: (context, state) => HomeScreen(
        insurancePlans: insurancePlans,
      ),
    ),
    GoRoute(
      path: '/detailScreen',
      name: AppRoute.detailScreen.name,
      pageBuilder: (context, state) => CustomTransitionPage(
        child: const DetailScreen(),
        transitionsBuilder: (context, animation, secondaryAnimation, child) {
          const begin = Offset(0.0, 1.0);
          const end = Offset.zero;
          const curve = Curves.ease;

          var tween = Tween(begin: begin, end: end).chain(CurveTween(curve: curve));
          return SlideTransition(position: animation.drive(tween), child: child);
        },
      ),
    ),
  ],
);
