import 'package:flutter/material.dart';
import 'package:garage_app/route/routePath.dart';
import 'package:garage_app/view/ticket/ticketScreen.dart';
import 'package:page_transition/page_transition.dart';

import '../splashScreen/splashscreen.dart';
import '../view/home/homeScreen.dart';

class AppRoute {
  static Route<dynamic> generateRoute(RouteSettings settings) {
    switch (settings.name) {
      case RoutePath.splash:
        return MaterialPageRoute(builder: (_) => const SplashScreen());

      case RoutePath.homeScreen:
        return MaterialPageRoute(builder: (_) => HomeScreen());

      case RoutePath.ticketScreen:
        // Retrieve the passed Notice
        return PageTransition(
          child: const TicketsScreen(), // Pass it to the screen
          type: PageTransitionType.rightToLeft,
          duration: const Duration(milliseconds: 100),
        );

      default:
        return MaterialPageRoute(
          builder:
              (_) => Scaffold(
                body: Center(
                  child: Text('No route defined for ${settings.name}'),
                ),
              ),
        );
    }
  }
}
