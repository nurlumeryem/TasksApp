import 'package:flutter/material.dart';

import 'package:tasks_app/screens/tabs_screen.dart';

class AppRouter {
  Route? onGenerateRoute(RouteSettings routeSettings) {
    return MaterialPageRoute(builder: (_) => TabsScreen());
  }
}
