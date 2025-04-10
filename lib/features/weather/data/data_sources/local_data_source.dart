import 'dart:convert';
import 'package:dartz/dartz.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:weather_app_clean_code_architecture/core/error/exceptions.dart';
import 'package:weather_app_clean_code_architecture/features/weather/data/models/weather_model.dart';

abstract class LocalDataSource {
  Future<WeatherModel> getCashedWeather();
  Future<Unit> cashedWeather(WeatherModel weatherModel);
}

class LocalImplWithSharedPreferences extends LocalDataSource {
  final SharedPreferences sharedPreferences;

  LocalImplWithSharedPreferences({required this.sharedPreferences});
  @override
  Future<WeatherModel> getCashedWeather() async {
    String? weatherJson = sharedPreferences.getString("CACHED_WEATHER");

    if (weatherJson != null) {
      return WeatherModel.fromJson(jsonDecode(weatherJson));
    } else {
      throw EmptyCashException();
    }
  }

  @override
  Future<Unit> cashedWeather(WeatherModel weatherModel) async {
    String weatherJson = jsonEncode(weatherModel.toJson());
    await sharedPreferences.setString("CACHED_WEATHER", weatherJson);
    return Future.value(unit);
  }
}
