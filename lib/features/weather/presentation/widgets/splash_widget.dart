import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:lottie/lottie.dart';

class SplashWidget extends StatelessWidget {
  const SplashWidget({super.key});

  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        Lottie.asset(
          "assets/lottie/Animation - 1742946509556.json",
          height: MediaQuery.of(context).size.height / 4,
        ),
        SizedBox(height: MediaQuery.of(context).size.height / 30),
        Text(
          "8".tr(),
          style: TextStyle(
            color: Colors.white,
            fontSize: 28,
            fontWeight: FontWeight.bold,
            letterSpacing: 1.2,
          ),
        ),
        SizedBox(height: MediaQuery.of(context).size.height / 60),
        Text(
          "7".tr(),
          style: TextStyle(
            color: Colors.white70,
            fontSize: 16.sp,
          ),
        ),
      ],
    );
  }
}
