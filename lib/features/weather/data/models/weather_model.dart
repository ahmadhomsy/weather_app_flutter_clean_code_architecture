import 'package:weather_app_clean_code_architecture/features/weather/domain/entities/weather.dart';

class WeatherModel extends Weather {
  const WeatherModel(
      {required String city,
      required double speed,
      required String state,
      required double temp})
      : super(city: city, speed: speed, state: state, temp: temp);
  factory WeatherModel.fromJson(Map<String, dynamic> json) {
    return WeatherModel(
      city: json["name"],
      speed: json["wind"]["speed"],
      state: json["weather"][0]["main"],
      temp: json['main']['temp'],
    );
  }
  Map<String, dynamic> toJson() {
    return {
      "name": city,
      "wind": {
        "speed": speed,
      },
      "weather": [
        {"main": state}
      ],
      "main": {"temp": temp},
    };
  }
}
