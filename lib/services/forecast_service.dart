import 'package:weather_app/models/forecast.dart';

import 'open_weather_api.dart';

class ForecastService {
  final OpenWeatherApi weatherApi;
  ForecastService(this.weatherApi);

  Future<Forecast> getWeather(String city) async {
    final location = await weatherApi.getLocation(city);
    return await weatherApi.getWeather(location);
  }
}
