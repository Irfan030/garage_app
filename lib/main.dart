import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:garage_app/route/appRoutes.dart';
import 'package:garage_app/route/routePath.dart';
import 'package:garage_app/theme/sizeConfig.dart';
import 'package:garage_app/view/auth/authBloc/authBloc.dart';

import 'constant.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MultiBlocProvider(
      providers: [BlocProvider<Authbloc>(create: (_) => Authbloc())],

      child: Builder(
        builder: (context) {
          SizeConfig().init(context);

          return MaterialApp(
            title: AppData.appName,
            theme: ThemeData(
              colorScheme: ColorScheme.fromSeed(seedColor: Colors.deepPurple),
              useMaterial3: true,
            ),
            debugShowCheckedModeBanner: false,
            initialRoute: RoutePath.login,
            onGenerateRoute: AppRoute.generateRoute,
          );
        },
      ),
    );
  }
}
