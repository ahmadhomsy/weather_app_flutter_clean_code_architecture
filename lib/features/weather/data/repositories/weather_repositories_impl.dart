import 'package:dartz/dartz.dart';
import 'package:weather_app_clean_code_architecture/core/error/exceptions.dart';
import 'package:weather_app_clean_code_architecture/core/error/failures.dart';
import 'package:weather_app_clean_code_architecture/core/network/network_info.dart';
import 'package:weather_app_clean_code_architecture/features/weather/domain/entities/weather.dart';
import 'package:weather_app_clean_code_architecture/features/weather/domain/repositories/weather_repositories.dart';
import '../data_sources/local_data_source.dart';
import '../data_sources/remote_data_source.dart';

class WeatherRepositoriesImpl implements WeatherRepositories {
  final RemoteDataSource remoteDataSource;
  final LocalDataSource localDataSource;
  final NetworkInfo networkInfo;

  WeatherRepositoriesImpl(
      {required this.remoteDataSource,
      required this.localDataSource,
      required this.networkInfo});

  @override
  Future<Either<Failure, Weather>> getWeatherState() async {
    if (await networkInfo.isConnected) {
      try {
        final remoteWeather = await remoteDataSource.getWeatherState();
        localDataSource.cashedWeather(remoteWeather);
        return Right(remoteWeather);
      } on ServerException {
        return Left(ServerFailure());
      } on LocationDisabledException {
        return Left(LocationDisabledFailure());
      }
    } else {
      try {
        final localWeather = await localDataSource.getCashedWeather();
        return Right(localWeather);
      } on EmptyCashException {
        return left(EmptyCashFailure());
      }
    }
  }
}
