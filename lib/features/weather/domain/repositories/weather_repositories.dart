import 'package:dartz/dartz.dart';
import 'package:weather_app_clean_code_architecture/core/error/failures.dart';

import '../entities/weather.dart';

abstract class WeatherRepositories {
  Future<Either<Failure, Weather>> getWeatherState();
}
