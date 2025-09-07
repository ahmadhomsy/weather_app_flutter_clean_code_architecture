import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import '../../domain/entities/weather.dart';

class WeatherWidget extends StatelessWidget {
  final Weather weather;
  const WeatherWidget({super.key, required this.weather});

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Container(
        height: 0.5.sh,
        width: 0.65.sw,
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(20.r),
          color: Colors.black.withOpacity(0.5),
        ),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Text(
              weather.state,
              style: TextStyle(
                color: Colors.white,
                fontSize: 36.sp,
                fontWeight: FontWeight.bold,
              ),
              textAlign: TextAlign.center,
            ),
            SizedBox(height: 20.h),
            displayWeather('${weather.temp} ℃'),
            SizedBox(height: 12.h),
            displayWeather('${weather.speed} m/s'),
            SizedBox(height: 12.h),
            displayWeather(weather.city),
          ],
        ),
      ),
    );
  }

  Widget displayWeather(String text) {
    return Text(
      text,
      style: TextStyle(
        color: Colors.white,
        fontSize: 28.sp,
      ),
      textAlign: TextAlign.center,
    );
  }
}
