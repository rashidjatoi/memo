import 'dart:async';

import 'package:flutter/material.dart';
import 'package:notesapp/view/auth/login/signin_view.dart';
import 'package:notesapp/view/home/home_view.dart';

import '../resources/constants/database_constants.dart';

class SplashScreenViewModel extends ChangeNotifier {
  Timer? timer;

  void splashScreenCounter(BuildContext context) {
    if (user != null) {
      timer = Timer(const Duration(seconds: 2), () {
        Navigator.pushReplacement(
          context,
          MaterialPageRoute(
            builder: (context) => const HomeView(),
          ),
        );
      });
    } else {
      timer = Timer(const Duration(seconds: 2), () {
        Navigator.pushReplacement(
          context,
          MaterialPageRoute(
            builder: (context) => const SignInView(),
          ),
        );
      });
    }
  }

  @override
  void dispose() {
    timer?.cancel();
    super.dispose();
  }
}
