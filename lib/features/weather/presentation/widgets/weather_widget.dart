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
        height: MediaQuery.of(context).size.height * 0.5,
        width: MediaQuery.of(context).size.width * 0.65,
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(20),
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
                  fontWeight: FontWeight.bold),
            ),
            SizedBox(
              height: MediaQuery.of(context).size.height * 0.025,
            ),
            displayWeather('${weather.temp} ℃'),
            displayWeather(weather.speed.toString()),
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
        fontSize: 36.sp,
      ),
    );
  }
}
