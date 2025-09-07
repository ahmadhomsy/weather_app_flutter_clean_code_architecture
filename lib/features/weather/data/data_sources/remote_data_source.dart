import 'dart:convert';
import 'package:geolocator/geolocator.dart';
import 'package:location/location.dart' as loc;
import 'package:http/http.dart' as http;

import '../../../../core/error/exceptions.dart';
import '../models/weather_model.dart';

abstract class RemoteDataSource {
  Future<WeatherModel> getWeatherState();
}

const String baseURL = 'https://api.openweathermap.org/data/2.5/';
const String service = 'weather?';
const String apiKey = 'b6bc351135ed84d5919c71543ce35790';

class RemoteImplWithHttp extends RemoteDataSource {
  final http.Client client;
  final loc.Location location;

  RemoteImplWithHttp({required this.client, required this.location});

  @override
  Future<WeatherModel> getWeatherState() async {
    LocationPermission permission = await Geolocator.checkPermission();
    if (permission == LocationPermission.denied) {
      permission = await Geolocator.requestPermission();
      if (permission == LocationPermission.denied) {
        throw LocationDisabledException();
      }
    }
    if (permission == LocationPermission.deniedForever) {
      throw LocationDisabledException();
    }
    while (!await location.serviceEnabled()) {
      await location.requestService();
    }
    Position position;

    try {
      position = await Geolocator.getCurrentPosition(
        desiredAccuracy: LocationAccuracy.high,
      );
    } catch (e) {
      throw LocationServiceIsClosed();
    }

    double latitude = position.latitude;
    double longitude = position.longitude;

    final response = await client.get(
      Uri.parse(
        '$baseURL${service}lat=$latitude&lon=$longitude&appid=$apiKey&units=metric',
      ),
    );

    if (response.statusCode == 200) {
      final data = jsonDecode(response.body) as Map<String, dynamic>;
      return WeatherModel.fromJson(data);
    } else {
      throw ServerException();
    }
  }
}
