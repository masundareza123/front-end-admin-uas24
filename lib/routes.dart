import 'package:flutter/material.dart';
import 'package:front_end_admin_uas24/views/add_student_view.dart';
import 'package:front_end_admin_uas24/views/home_view.dart';
import 'package:front_end_admin_uas24/views/login_view.dart';
import 'package:front_end_admin_uas24/views/student_view.dart';

import 'const.dart';

Route<dynamic> generateRoute(RouteSettings settings) {
  switch (settings.name) {
    case addStudentViewRoute:
      return _pageRoute(routeName: settings.name, viewToShow: AddStudentView());
    case homeViewRoute:
      return _pageRoute(routeName: settings.name, viewToShow: HomeView());
    case loginViewRoute:
      return _pageRoute(routeName: settings.name, viewToShow: LoginView());
    case studentViewRoute:
      return _pageRoute(routeName: settings.name, viewToShow: StudentView());


    default:
      return MaterialPageRoute(
        builder: (_) => Scaffold(
          body: Center(
            child: Text(
              'No route defined for ${settings.name}',
            ),
          ),
        ),
      );
  }
}

PageRoute _pageRoute({required String? routeName, required Widget viewToShow}) {
  return MaterialPageRoute(
      builder: (_) => viewToShow, settings: RouteSettings(name: routeName));
}
