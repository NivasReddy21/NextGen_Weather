// ignore_for_file: prefer_const_constructors

import 'package:flutter/material.dart';
import 'package:lottie/lottie.dart';
import 'package:provider/provider.dart';
import 'package:weather_app/screens/home_page.dart';
import 'package:weather_app/viewModels/city_entry_view_model.dart';
import 'package:weather_app/viewModels/forecast_view_model.dart';

class SplashScreen extends StatefulWidget {
  const SplashScreen({Key? key}) : super(key: key);

  @override
  State<SplashScreen> createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen>
    with TickerProviderStateMixin {
  late final AnimationController _controller;

  @override
  void initState() {
    super.initState();
    _controller = AnimationController(vsync: this);
  }

  @override
  Widget build(BuildContext context) {
    Provider.of<ForecastViewModel>(context, listen: false)
        .getLatestWeather("Delhi");
    Provider.of<CityEntryViewModel>(context, listen: false).updateCity("Delhi");

    return Scaffold(
      backgroundColor: Colors.black,
      body: Center(
        child: Lottie.asset(
          'assets/splash.json',
          controller: _controller,
          onLoaded: (composition) {
            _controller.addStatusListener((status) {
              if (status == AnimationStatus.completed) {
                Navigator.of(context).push(
                    MaterialPageRoute(builder: (context) => MyHomePage()));
              }
            });

            _controller
              ..duration = composition.duration
              ..forward();
          },
        ),
      ),
    );
  }
}
