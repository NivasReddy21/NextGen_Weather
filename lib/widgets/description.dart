import 'package:flutter/material.dart';

class WeatherDescriptionView extends StatelessWidget {
  final String weatherDescription;

  const WeatherDescriptionView({Key? key, required this.weatherDescription})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Text(weatherDescription.toUpperCase(),
          textAlign: TextAlign.center,
          style: const TextStyle(
            fontSize: 35,
            fontWeight: FontWeight.w300,
            color: Colors.white,
          )),
    );
  }
}
