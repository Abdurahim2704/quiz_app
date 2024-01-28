import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:ibrat_informatika/bloc/home/home_bloc.dart';
import 'package:ibrat_informatika/bloc/local_saving/test_result_bloc.dart';
import 'package:ibrat_informatika/core/routes/app_routes.dart';
import 'package:ibrat_informatika/core/theme.dart';
import 'package:ibrat_informatika/data/services/local_data.dart';

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    LocalDataService.getCourse();
    return ScreenUtilInit(
        designSize: const Size(375, 812),
        splitScreenMode: true,
        minTextAdapt: true,
        child: MultiBlocProvider(
          providers: [
            BlocProvider(
              create: (context) => TestResultBloc()..add(FetchResults()),
            ),
            BlocProvider(
              create: (context) => HomeBloc()..add(FetchData()),
            ),
          ],
          child: MaterialApp.router(
            routerConfig: AppRoutes.route,
            theme: lightTheme,
            debugShowCheckedModeBanner: false,
          ),
        ));
  }
}

class MyHttpOverrides extends HttpOverrides {
  @override
  HttpClient createHttpClient(SecurityContext? context) =>
      super.createHttpClient(context)
        ..badCertificateCallback = (cert, host, port) => true;
}
