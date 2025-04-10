import 'package:equatable/equatable.dart';

class Weather extends Equatable {
  final String city;
  final double speed;
  final String state;
  final double temp;

  const Weather({
    required this.city,
    required this.speed,
    required this.state,
    required this.temp,
  });

  @override
  List<Object?> get props => [city, speed, state, temp];
}
