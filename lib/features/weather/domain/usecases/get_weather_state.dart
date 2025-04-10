import 'package:dartz/dartz.dart';
import 'package:weather_app_clean_code_architecture/core/error/failures.dart';
import 'package:weather_app_clean_code_architecture/features/weather/domain/entities/weather.dart';
import 'package:weather_app_clean_code_architecture/features/weather/domain/repositories/weather_repositories.dart';

class GetWeatherStateUseCase {
  final WeatherRepositories repositories;

  GetWeatherStateUseCase(this.repositories);
  Future<Either<Failure, Weather>> call() async {
    return await repositories.getWeatherState();
  }
}
