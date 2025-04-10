import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:lottie/lottie.dart';
import 'package:weather_app_clean_code_architecture/features/weather/presentation/pages/home_page.dart';

import '../widgets/splash_widget.dart';

class Splash extends StatefulWidget {
  const Splash({super.key});

  @override
  State<StatefulWidget> createState() => _SplashScreenState();
}

class _SplashScreenState extends State<Splash> {
  @override
  void initState() {
    super.initState();
    Future.delayed(
      const Duration(seconds: 3),
      () => Get.off(
        () => const HomePage(),
        transition: Transition.rightToLeftWithFade,
        duration: const Duration(milliseconds: 1500),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.blueGrey[900],
      body: _buildBody(),
    );
  }

  Widget _buildBody() {
    return Center(
      child: SplashWidget(),
    );
  }
}
