import 'package:flutter/material.dart';
import 'package:garage_app/route/appRoutes.dart';
import 'package:garage_app/route/routePath.dart';
import 'package:garage_app/theme/sizeConfig.dart';

import 'constant.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    SizeConfig().init(context);
    return MaterialApp(
      title: AppData.appName,
      theme: ThemeData(
        colorScheme: ColorScheme.fromSeed(seedColor: Colors.deepPurple),
        useMaterial3: true,
      ),
      debugShowCheckedModeBanner: false,
      initialRoute: RoutePath.splash,
      onGenerateRoute: AppRoute.generateRoute,
    );
  }
}
