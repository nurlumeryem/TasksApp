import 'package:flutter/material.dart';
import 'package:tasks_app/core/constants/shared_strings.dart';
import 'package:tasks_app/core/helper/shared_service.dart';
import 'package:tasks_app/core/routes/routes.dart';
import 'package:tasks_app/core/routes/routes.manager.dart';

class SplashViewModel extends ChangeNotifier {
  SplashViewModel() {
    _checkUserSession();
  }

  Future<void> _checkUserSession() async {
    await Future.delayed(const Duration(seconds: 1));

    String? userId = PreferenceUtils.getString(SharedStrings.userId);

    if (userId != null && userId.isNotEmpty) {
      // Kullanıcı oturum açmış durumda, ana ekrana yönlendir
      router.goNamed(Routes.home);
    } else {
      // Kullanıcı oturum açmamış, giriş yapma ekranına yönlendir
      router.goNamed(Routes.welcome);
    }
  }
}
