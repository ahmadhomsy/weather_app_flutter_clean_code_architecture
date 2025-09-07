import 'package:get_it/get_it.dart';
import 'package:http/http.dart' as http;
import 'package:internet_connection_checker/internet_connection_checker.dart';
import 'package:location/location.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:weather_app_clean_code_architecture/core/helpers/network_info.dart';
import 'package:weather_app_clean_code_architecture/features/weather/data/data_sources/local_data_source.dart';
import 'package:weather_app_clean_code_architecture/features/weather/data/data_sources/remote_data_source.dart';
import 'package:weather_app_clean_code_architecture/features/weather/data/repositories/weather_repositories_impl.dart';
import 'package:weather_app_clean_code_architecture/features/weather/domain/repositories/weather_repositories.dart';
import 'package:weather_app_clean_code_architecture/features/weather/domain/usecases/get_weather_state.dart';
import 'package:weather_app_clean_code_architecture/features/weather/presentation/bloc/weather_bloc.dart';

final sl = GetIt.instance;
Future<void> init() async {
  //! Features * Weather
  // Bloc
  sl.registerFactory(() => WeatherBloc(getWeatherStateUseCase: sl()));
  // UseCase
  sl.registerLazySingleton(() => GetWeatherStateUseCase(sl()));
  // Repository
  sl.registerLazySingleton<WeatherRepositories>(() => WeatherRepositoriesImpl(
      remoteDataSource: sl(), localDataSource: sl(), networkInfo: sl()));
  // DataSources
  sl.registerLazySingleton<RemoteDataSource>(
      () => RemoteImplWithHttp(client: sl(), location: sl()));
  sl.registerLazySingleton<LocalDataSource>(
      () => LocalImplWithSharedPreferences(sharedPreferences: sl()));
  //! Core
  sl.registerLazySingleton<NetworkInfo>(() => NetworkInfoImpl(sl()));
  //! External
  final sharedPreferences = await SharedPreferences.getInstance();
  sl.registerLazySingleton(() => sharedPreferences);
  sl.registerLazySingleton(() => http.Client());
  sl.registerLazySingleton(() => InternetConnectionChecker());
  sl.registerLazySingleton<Location>(() => Location());
}
