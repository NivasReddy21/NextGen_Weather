// ignore_for_file: prefer_const_constructors

import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:weather_app/models/weather.dart';

class DailySummaryView extends StatelessWidget {
  final Weather weather;

  const DailySummaryView({Key? key, required this.weather}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final dayOfWeek =
        toBeginningOfSentenceCase(DateFormat('EEE').format(weather.date));

    return Padding(
        padding: EdgeInsets.all(15),
        child: Row(
          children: [
            Column(mainAxisAlignment: MainAxisAlignment.spaceAround, children: [
              Text(dayOfWeek ?? '',
                  textAlign: TextAlign.center,
                  style: TextStyle(
                      fontSize: 18,
                      color: Colors.white,
                      fontWeight: FontWeight.w300)),
              Text(
                  "${TemperatureConvert.kelvinToCelsius(weather.temp).round().toString()}°",
                  textAlign: TextAlign.center,
                  style: TextStyle(
                      fontSize: 20,
                      color: Colors.white,
                      fontWeight: FontWeight.w500)),
            ]),
            // Padding(
            //     padding: EdgeInsets.only(left: 5),
            //     child: Container(
            //         alignment: Alignment.center,
            //         child: _mapWeatherConditionToImage(this.weather.condition)))
          ],
        ));
  }
}

class TemperatureConvert {
  static double kelvinToCelsius(kelvinTemp) {
    return kelvinTemp - 273.15;
  }
}
