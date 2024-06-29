import 'package:flutter/material.dart';
import 'package:tasks_app/screens/recycle_bin.dart';
import 'package:tasks_app/screens/tabs_screen.dart';

class AppRouter {
  Route? onGenerateRoute(RouteSettings routeSettings) {
    if (routeSettings.name == RecycleBin.id) {
      return MaterialPageRoute(builder: (_) => const RecycleBin());
    } else if (routeSettings.name == TabsScreen.id) {
      return MaterialPageRoute(builder: (_) => TabsScreen());
    } else {
      return null;
    }
  }
}
