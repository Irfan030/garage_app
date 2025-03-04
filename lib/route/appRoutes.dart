import 'package:flutter/material.dart';
import 'package:garage_app/route/routePath.dart';
import 'package:garage_app/splashScreen/splashscreen.dart';
import 'package:garage_app/view/home/homeScreen.dart';
import 'package:garage_app/view/notices/noticesDetailedScreen.dart';
import 'package:garage_app/view/notices/noticesScreen.dart';
import 'package:garage_app/view/ticket/editTicket.dart';
import 'package:garage_app/view/ticket/escalate.dart';
import 'package:garage_app/view/ticket/ticketDetailsScreen.dart';
import 'package:garage_app/view/ticket/ticketScreen.dart';
import 'package:garage_app/view/ticket/viewEscalate.dart';
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
      case RoutePath.editTicket:
        final args = settings.arguments as Map<String, dynamic>?;
        final isEditMode = args?['isEditMode'] ?? false;
        return PageTransition(
          child: EditTicketScreen(isEditMode: isEditMode),
          type: PageTransitionType.rightToLeft,
          duration: const Duration(milliseconds: 100),
        );
      case RoutePath.escalateTicket:
        final String ticketId = settings.arguments as String;
        return PageTransition(
          child: EscalateTicketScreen(ticketId: ticketId),
          type: PageTransitionType.rightToLeft,
          duration: const Duration(milliseconds: 100),
        );
      case RoutePath.viewEscalation:
        final args = settings.arguments as Map<String, dynamic>;

        return PageTransition(
          child: ViewEscalationScreen(
            ticketId: args['ticketId'],
            status: args['status'],
            description: args['description'],
            date: args['date'],
          ),
          type: PageTransitionType.rightToLeft,
          duration: const Duration(milliseconds: 100),
        );

      case RoutePath.noticesScreen:
        return PageTransition(
          child: NoticesScreen(),
          type: PageTransitionType.rightToLeft,
          duration: const Duration(milliseconds: 100),
        );

      case RoutePath.noticesDetailedScreen:
        final notice =
            settings.arguments as Notice; // Retrieve the passed Notice
        return PageTransition(
          child: NoticeDetailScreen(notice: notice), // Pass it to the screen
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
