import 'package:flutter/material.dart';
import 'core/constants/route_app.dart';
import 'features/weather/presentation/pages/home_page.dart';

Map<String, Widget Function(BuildContext)> routes = {
  AppRoutes.homePage: (context) => const HomePage(),
};
