

import 'package:flutter/material.dart';
import 'package:movieapp/application/core/routes/route_path.dart';
import 'package:movieapp/application/core/routes/routes.dart';

import '../../../ui/views/home_screen.dart';


class RouteGenerator {
  static Route<dynamic> generateRoute(RouteSettings settings) {
    final args = settings.arguments;
    switch (settings.name) {
      case RoutePath.initialRoute:
        return PageRouter.fadeScale(() => const HomeScreen());


      default:
        return _errorRoute();
    }
  }

  static Route<dynamic> _errorRoute() {
    return MaterialPageRoute(builder: (_) {
      return Scaffold(
        appBar: AppBar(
          title: const Text('Error'),
        ),
        body: Center(
          child: Container(
            color: Colors.white,
            child: const Text('Page Not Found'),
          ),
        ),
      );
    });
  }
}
