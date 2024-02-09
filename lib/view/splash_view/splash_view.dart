import 'package:flutter/material.dart';
import 'package:iconly/iconly.dart';

import '../../view_model/splash_view_model.dart';

class SplashView extends StatefulWidget {
  const SplashView({super.key});

  @override
  State<SplashView> createState() => _SplashViewState();
}

class _SplashViewState extends State<SplashView> {
  final SplashScreenViewModel _viewModel = SplashScreenViewModel();

  @override
  void initState() {
    super.initState();
    _viewModel.splashScreenCounter(context);
  }

  @override
  Widget build(BuildContext context) {
    return const Scaffold(
      body: Center(
        child: Align(
          alignment: Alignment.center,
          child: Icon(
            IconlyBroken.edit,
            size: 250,
          ),
        ),
      ),
    );
  }
}
