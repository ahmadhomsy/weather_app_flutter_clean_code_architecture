part of 'weather_bloc.dart';

@immutable
sealed class WeatherState extends Equatable {
  @override
  List<Object?> get props => [];
}

final class WeatherInitial extends WeatherState {}

class LoadingState extends WeatherState {}

class LoadedState extends WeatherState {
  final Weather weather;

  LoadedState({required this.weather});

  @override
  List<Object?> get props => [weather];
}

class ErrorState extends WeatherState {
  final String message;

  ErrorState({required this.message});
  @override
  List<Object?> get props => [message];
}

class PermissionErrorState extends WeatherState {
  final String message;

  PermissionErrorState({required this.message});
  @override
  List<Object?> get props => [message];
}
