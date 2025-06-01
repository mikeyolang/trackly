import 'package:flutter/material.dart';
import 'package:trackly/presentation/pages/add_visit.dart';
import 'package:trackly/presentation/pages/home_page.dart';
import 'package:trackly/presentation/pages/statistics_page.dart';
import 'package:trackly/presentation/pages/visits_list_page.dart';

class AppRouter {
  static const String visitsList = '/';
  static const String addVisit = '/add-visit';
  static const String visitDetails = '/visit-details';
  static const String statistics = '/statistics';
  static const String homeRoute = "/home";

  static Map<String, Widget Function(BuildContext)> routes = {
    visitsList: (context) => VisitsListPage(),
    addVisit: (context) => AddVisitPage(),
    statistics: (context) => StatisticsPage(),
    homeRoute: (context) => HomePage(),
  };

  static Route<dynamic> generateRoute(RouteSettings settings) {
    switch (settings.name) {
      case visitsList:
        return MaterialPageRoute(builder: routes[visitsList]!);
      case addVisit:
        return MaterialPageRoute(builder: routes[addVisit]!);
      case statistics:
        return MaterialPageRoute(builder: routes[statistics]!);
      case homeRoute:
        return MaterialPageRoute(builder: routes[homeRoute]!);
      default:
        throw Exception('Route not found');
    }
  }
}
