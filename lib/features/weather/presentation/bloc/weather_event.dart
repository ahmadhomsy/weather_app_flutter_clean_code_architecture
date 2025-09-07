part of 'weather_bloc.dart';

@immutable
sealed class WeatherEvent extends Equatable {
  @override
  List<Object?> get props => [];
}

class GetWeatherEvent extends WeatherEvent {}
