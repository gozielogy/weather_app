import 'package:flutter/material.dart';
import 'package:flutter_weather_app/view/home_screen.dart';

void main() {
  runApp(const EasyWeather());
}

class EasyWeather extends StatelessWidget {
  const EasyWeather({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      theme: ThemeData.light(),
      darkTheme: ThemeData.dark(),
      themeMode: ThemeMode.dark,
      // Default to light theme
      home: const WeatherPage(),
    );
  }
}
