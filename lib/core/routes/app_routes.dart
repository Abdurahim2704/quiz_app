import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:ibrat_informatika/core/routes/route_names.dart';
import 'package:ibrat_informatika/presentation/pages/home_page/home_page.dart';
import 'package:ibrat_informatika/presentation/pages/profile_page/profile_page.dart';
import 'package:ibrat_informatika/presentation/pages/result_page/result_page.dart';

sealed class AppRoutes {
  static GoRouter route = GoRouter(initialLocation: "/", routes: [
    GoRoute(
      path: "/",
      name: RouteNames.home,
      pageBuilder: (context, state) {
        return const MaterialPage(child: HomePage());
      },
    ),
    GoRoute(
      path: "/profile",
      name: RouteNames.profile,
      pageBuilder: (context, state) {
        return const MaterialPage(child: ProfilePage());
      },
    ),
    GoRoute(
      path: "/resultPage",
      name: RouteNames.resultPage,
      builder: (context, state) {
        return const ResultPage();
      },
    ),
  ]);
}
