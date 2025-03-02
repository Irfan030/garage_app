import 'package:flutter/material.dart';
import 'package:garage_app/route/routePath.dart';
import 'package:garage_app/splashScreen/splashscreen.dart';
import 'package:garage_app/view/home/homeScreen.dart';
import 'package:garage_app/view/ticket/ticketDetailsScreen.dart';
import 'package:garage_app/view/ticket/ticketScreen.dart';
import 'package:page_transition/page_transition.dart';

class AppRoute {
  static Route<dynamic> generateRoute(RouteSettings settings) {
    switch (settings.name) {
      case RoutePath.splash:
        return MaterialPageRoute(builder: (_) => const SplashScreen());

      case RoutePath.homeScreen:
        return MaterialPageRoute(builder: (_) => HomeScreen());

      case RoutePath.ticketScreen:
        return PageTransition(
          child: const TicketsScreen(),
          type: PageTransitionType.rightToLeft,
          duration: const Duration(milliseconds: 300),
        );
      case RoutePath.ticketDetail:
        final Map<String, String> ticket =
            settings.arguments as Map<String, String>;
        return PageTransition(
          child: TicketDetailsScreen(ticket: ticket),
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
