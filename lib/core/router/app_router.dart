import 'package:flutter/material.dart';
import 'package:trackly/presentation/pages/add_visit.dart';
import 'package:trackly/presentation/pages/visits_list_page.dart';

class AppRouter {
  static const String visitsList = '/';
  static const String addVisit = '/add-visit';
  static const String visitDetails = '/visit-details';

  static Map<String, Widget Function(BuildContext)> routes = {
    visitsList: (context) => VisitsListPage(),
    addVisit: (context) => AddVisitPage(),
  };

  static Route<dynamic> generateRoute(RouteSettings settings) {
    switch (settings.name) {
      case visitsList:
        return MaterialPageRoute(builder: routes[visitsList]!);
      case addVisit:
        return MaterialPageRoute(builder: routes[addVisit]!);
      // Add more cases for other routes
      default:
        throw Exception('Route not found');
    }
  }
}