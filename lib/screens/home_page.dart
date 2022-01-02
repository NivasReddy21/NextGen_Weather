// ignore_for_file: prefer_const_literals_to_create_immutables, prefer_const_constructors, unnecessary_null_comparison

import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:weather_app/models/weather.dart';
import 'package:weather_app/viewModels/city_entry_view_model.dart';
import 'package:weather_app/viewModels/forecast_view_model.dart';
import 'package:weather_app/widgets/description.dart';
import 'package:weather_app/widgets/forecast_widget.dart';
import 'package:weather_app/widgets/location_view.dart';
import 'package:weather_app/widgets/search_widget.dart';
import 'package:weather_app/widgets/today_weather.dart';

class MyHomePage extends StatefulWidget {
  const MyHomePage({Key? key}) : super(key: key);

  @override
  State<MyHomePage> createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Consumer<ForecastViewModel>(builder: (context, model, child) {
      String bgImage = model.isDaytime ? "assets/bgm.jpg" : "assets/bgn.jpg";

      return Scaffold(
        body: Stack(
          children: [
            Container(
              height: MediaQuery.of(context).size.height,
              width: MediaQuery.of(context).size.width,
              decoration: BoxDecoration(
                image: DecorationImage(
                  image: AssetImage(bgImage),
                  fit: BoxFit.cover,
                ),
              ),
            ),
            Container(
              height: MediaQuery.of(context).size.height,
              width: MediaQuery.of(context).size.width,
              decoration: BoxDecoration(
                color: Colors.black.withOpacity(
                  0.7,
                ),
              ),
            ),
            buildHomeView(context),
          ],
        ),
      );
    });
  }

  Widget buildHomeView(BuildContext context) {
    return Consumer<ForecastViewModel>(
      builder: (context, weatherModel, child) => SizedBox(
        height: MediaQuery.of(context).size.height,
        child: RefreshIndicator(
          color: Colors.transparent,
          backgroundColor: Colors.transparent,
          onRefresh: () => refreshWeather(weatherModel, context),
          child: ListView(
            children: [
              CityEntryView(),
              weatherModel.isLoading
                  ? buildBusy()
                  : weatherModel.isError
                      ? Center(
                          child: Text(
                            "Something Went Wrong",
                            style: TextStyle(
                              fontSize: 21,
                            ),
                          ),
                        )
                      : Column(
                          children: [
                            LocationView(
                                longitude: weatherModel.longitude,
                                latitude: weatherModel.latitide,
                                city: weatherModel.city),
                            SizedBox(
                              height: 90,
                            ),
                            WeatherSummary(
                              condition: weatherModel.condition,
                              temp: weatherModel.temp,
                              feelsLike: weatherModel.feelsLike,
                              isdayTime: weatherModel.isDaytime,
                            ),
                            SizedBox(
                              height: 110,
                            ),
                            WeatherDescriptionView(
                              weatherDescription: weatherModel.description,
                            ),
                            SizedBox(
                              height: 140,
                            ),
                            buildDailySummary(weatherModel.daily),
                          ],
                        )
            ],
          ),
        ),
      ),
    );
  }

  Widget buildBusy() {
    return Column(mainAxisAlignment: MainAxisAlignment.center, children: [
      CircularProgressIndicator(
          valueColor: AlwaysStoppedAnimation<Color>(Colors.white)),
      SizedBox(
        height: 20,
      ),
      Text('Please Wait...',
          style: TextStyle(
            fontSize: 18,
            color: Colors.white,
            fontWeight: FontWeight.w300,
          ))
    ]);
  }

  Widget buildDailySummary(List<Weather> dailyForecast) {
    return Row(
        mainAxisAlignment: MainAxisAlignment.center,
        children: dailyForecast
            .map((item) => DailySummaryView(
                  weather: item,
                ))
            .toList());
  }

  Future<void> refreshWeather(
      ForecastViewModel weatherVM, BuildContext context) {
    // get the current city
    String city = Provider.of<CityEntryViewModel>(context, listen: false).city;
    return weatherVM.getLatestWeather(city);
  }
}

// onPressed: () async {
//             OpenWeatherApi api = OpenWeatherApi();
//             ForecastService(api).getWeather("Delhi");
//           },