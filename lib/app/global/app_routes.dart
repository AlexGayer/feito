import 'package:feito/app/global/app_constants.dart';
import 'package:feito/app/pages/home_page.dart';
import 'package:feito/app/pages/login_page.dart';
import 'package:flutter/material.dart';

class Routes {
  static Route<dynamic> generateRoute(RouteSettings settings) {
    switch (settings.name) {
      case homeRouter:
        return SlideRightRoute(widget: const HomePage());

      case loginRouter:
        return SlideRightRoute(widget: const LoginPage());

      default:
        return SlideRightRoute(widget: const Scaffold());
    }
  }
}

class SlideRightRoute extends PageRouteBuilder {
  final Widget widget;
  SlideRightRoute({required this.widget})
      : super(
          pageBuilder: (BuildContext context, Animation<double> animation,
              Animation<double> secondaryAnimation) {
            return widget;
          },
          transitionsBuilder: (
            BuildContext context,
            Animation<double> animation,
            Animation<double> secondaryAnimation,
            Widget child,
          ) =>
              FadeTransition(
            opacity: animation,
            child: child,
          ),
          transitionDuration: const Duration(milliseconds: 500),
        );
}
