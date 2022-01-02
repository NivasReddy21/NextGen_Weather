// ignore_for_file: non_constant_identifier_names

import 'package:http/http.dart' as http;
import 'package:weather_app/models/forecast.dart';
import 'dart:convert';
import 'package:weather_app/models/location.dart';

class OpenWeatherApi {
  static const String url = 'https://api.openweathermap.org/data/2.5';

  static const String appId = '7602f0be12e19a03279a808d64aa7251';

  late http.Client httpClient;

  OpenWeatherApi() {
    httpClient = http.Client();
  }

  Future<Location> getLocation(String city) async {
    final finalUrl = Uri.parse('$url/weather?q=$city&APPID=$appId');

    final response = await httpClient.get(finalUrl);

    if (response.statusCode != 200) {
      throw Exception(
          'error retrieving location for city $city: ${response.statusCode}');
    }
    return Location.fromJson(jsonDecode(response.body));
  }

  Future<Forecast> getWeather(Location location) async {
    final requestUrl = Uri.parse(
        '$url/onecall?lat=${location.latitude}&lon=${location.longitude}&exclude=hourly,minutely&APPID=$appId');
    final response = await httpClient.get(requestUrl);

    if (response.statusCode != 200) {
      throw Exception('error retrieving weather: ${response.statusCode}');
    }
    return Forecast.fromJson(jsonDecode(response.body));
  }
}
