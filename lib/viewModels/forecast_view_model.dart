// ignore_for_file: prefer_final_fields

import 'package:flutter/cupertino.dart';
import 'package:weather_app/models/forecast.dart';
import 'package:weather_app/models/weather.dart';
import 'package:weather_app/services/forecast_service.dart';
import 'package:weather_app/services/open_weather_api.dart';

class ForecastViewModel with ChangeNotifier {
  bool isLoading = false;
  bool isWeatherLoaded = false;
  bool isError = false;

  late WeatherCondition _condition = WeatherCondition.atmosphere;
  late String _description;
  late double _minTemp;
  late double _maxTemp;
  late double _temp;
  late double _feelsLike;
  late final int _locationId;
  late DateTime _lastUpdated;
  late String _city;
  late double _latitude;
  late double _longitude;
  late List<Weather> _daily;
  late bool _isDayTime;

  WeatherCondition get condition => _condition;
  String get description => _description;
  double get minTemp => _minTemp;
  double get maxTemp => _maxTemp;
  double get temp => _temp;
  double get feelsLike => _feelsLike;
  int get locationId => _locationId;
  DateTime get lastUpdated => _lastUpdated;
  String get city => _city;
  double get longitude => _longitude;
  double get latitide => _latitude;
  bool get isDaytime => _isDayTime;
  List<Weather> get daily => _daily;

  late ForecastService forecastService;

  ForecastViewModel() {
    forecastService = ForecastService(OpenWeatherApi());
  }

  Future<Forecast> getLatestWeather(String city) async {
    setRequestPendingState(true);
    isError = false;

    late Forecast latest;
    try {
      await Future.delayed(const Duration(seconds: 1), () => {});

      latest = await forecastService
          .getWeather(city)
          // ignore: invalid_return_type_for_catch_error
          .catchError((onError) => isError = true);
    } catch (e) {
      isError = true;
    }

    isWeatherLoaded = true;
    updateModel(latest, city);
    setRequestPendingState(false);
    notifyListeners();
    return latest;
  }

  void setRequestPendingState(bool isPending) {
    isLoading = isPending;
    notifyListeners();
  }

  void updateModel(Forecast forecast, String city) {
    if (isError) return;

    _condition = forecast.current.condition;
    _city = city;
    _description = forecast.current.description;
    _lastUpdated = forecast.lastUpdated;
    _temp = TemperatureConvert.kelvinToCelsius(forecast.current.temp);
    _feelsLike =
        TemperatureConvert.kelvinToCelsius(forecast.current.feelLikeTemp);
    _longitude = forecast.longitude;
    _latitude = forecast.latitude;
    _daily = forecast.daily;
    _isDayTime = forecast.isDayTime;
  }
}

class TemperatureConvert {
  static double kelvinToCelsius(kelvinTemp) {
    return kelvinTemp - 273.15;
  }
}
