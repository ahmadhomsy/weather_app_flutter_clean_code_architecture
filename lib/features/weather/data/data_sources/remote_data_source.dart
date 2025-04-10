import 'dart:convert';
import 'package:location/location.dart';
import 'package:weather_app_clean_code_architecture/core/error/exceptions.dart';
import 'package:weather_app_clean_code_architecture/features/weather/data/models/weather_model.dart';
import 'package:http/http.dart' as http;

abstract class RemoteDataSource {
  Future<WeatherModel> getWeatherState();
}

const String baseURL = 'https://api.openweathermap.org/data/2.5/';
const String service = 'weather?';
const String apiKey = 'b6bc351135ed84d5919c71543ce35790';

class RemoteImplWithHttp extends RemoteDataSource {
  final http.Client client;
  final Location location;

  double? longitude;
  double? latitude;
  RemoteImplWithHttp({required this.client, required this.location});

  @override
  Future<WeatherModel> getWeatherState() async {
    while (!await location.serviceEnabled()) {
      await location.requestService();
    }
    PermissionStatus _permissionGranted = await location.hasPermission();
    if (_permissionGranted == PermissionStatus.denied) {
      _permissionGranted = await location.requestPermission();
      if (_permissionGranted != PermissionStatus.granted) {
        throw LocationDisabledException();
      }
    }

    LocationData locationData = await location.getLocation();

    longitude = locationData.longitude;
    latitude = locationData.latitude;

    var response = await http.get(
      Uri.parse(
          '$baseURL${service}lat=$latitude&lon=$longitude&appid=$apiKey&units=metric'),
    );
    if (response.statusCode == 200) {
      Map<String, dynamic> data = jsonDecode(response.body);
      return WeatherModel.fromJson(data);
    } else {
      throw ServerException();
    }
  }
}
