import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:weather_app/screens/splash_screen.dart';
import 'package:weather_app/viewModels/city_entry_view_model.dart';
import 'package:weather_app/viewModels/forecast_view_model.dart';

void main() {
  runApp(
    MultiProvider(
      providers: [
        ChangeNotifierProvider<CityEntryViewModel>(
          create: (_) => CityEntryViewModel(),
        ),
        ChangeNotifierProvider<ForecastViewModel>(
          create: (_) => ForecastViewModel(),
        ),
      ],
      child: const MyApp(),
    ),
  );
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Weather Forecast',
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      home: const SplashScreen(),
    );
  }
}
