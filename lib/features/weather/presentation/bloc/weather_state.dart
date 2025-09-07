part of 'weather_bloc.dart';

enum WeatherStatus {
  initial,
  loading,
  success,
  failureLocation,
  failureError,
  failureServiceLocation
}

class WeatherState {
  final WeatherStatus status;
  final Weather? weather;
  final String? errorMessage;
  WeatherState({
    this.status = WeatherStatus.initial,
    this.weather,
    this.errorMessage,
  });

  WeatherState copyWith({
    Weather? weather,
    WeatherStatus? status,
    String? errorMessage,
  }) {
    return WeatherState(
      weather: weather ?? this.weather,
      status: status ?? this.status,
      errorMessage: errorMessage ?? this.errorMessage,
    );
  }
}
