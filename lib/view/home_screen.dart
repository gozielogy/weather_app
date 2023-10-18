import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:lottie/lottie.dart';
import '../model/weather_model.dart';
import '../services/weather_services.dart';

class WeatherPage extends StatefulWidget {
  const WeatherPage({super.key});

  @override
  State<WeatherPage> createState() => _WeatherPageState();
}

class _WeatherPageState extends State<WeatherPage> {
  //api key
  final _weatherService = WeatherService('57da4770d9a469363b7ea371e6603933');
  Weather? _weather;

  // fetch weather
  _fetchWeather() async {
    // get the current city
    String cityName = await _weatherService.getCurrentCity();

    // get weather for city
    try {
      final weather = await _weatherService.getWeather(cityName);
      setState(() {
        _weather = weather;
      });
    }
    // errors
    catch (e) {
      if (kDebugMode) {
        print(e);
      }
    }
  }

  final bool _dataLoaded = false; // Track whether the data has been loaded

  Text _buildTemperatureText() {
    String temperatureText = _weather?.temperature != null
        ? '${_weather?.temperature.round()} °C'
        : 'Loading temperature...';

    return Text(
      temperatureText,
      style: GoogleFonts.bebasNeue(
        fontSize: _dataLoaded ? 80 : 20, // Dynamic font size
        fontWeight: FontWeight.w500,
      ),
    );
  }

//weather animations
  String getWeatherAnimation(String? mainCondition) {
    if (mainCondition == null) {
      return 'assets/default.json'; // default to the default weather animation
    }
//The switch statements to help switch to supposed animations for us.
    switch (mainCondition.toLowerCase()) {
      case 'clouds':
      case 'mist':
      case 'smoke':
      case 'haze':
      case 'dust':
      case 'fog':
        return 'assets/rain.json';
      case 'rain':
      case 'drizzle':
      case 'shower rain':
        return 'assets/raining.json';
      case 'thunderstorm':
        return 'assets/thunderstorm.json';
      case 'clear':
        return 'assets/sunny.json';
      default:
        return 'assets/sunny.json';
    }
  }

// init state
  @override
  void initState() {
    super.initState();

    //fetch weather on startup
    _fetchWeather();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.black,
      body: SafeArea(
        child: RefreshIndicator(
          onRefresh: () async {
            await _fetchWeather();
          },
          child: Center(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                const Spacer(),
                //city name
                Text(
                  _weather?.cityName ?? 'Loading city...',
                  style: GoogleFonts.poppins(
                    fontSize: 20,
                    fontWeight: FontWeight.w500,
                    color: Colors.yellow,
                  ),
                ),
                //temperature
                //temperature
                _buildTemperatureText(), // Use the new method
                // weather condition
                Text(
                  _weather?.mainCondition ?? "",
                  style: GoogleFonts.poppins(
                    fontSize: 30,
                    fontWeight: FontWeight.w500,
                  ),
                ),

                //weather condition
                Text(
                  _weather?.mainCondition ?? "",
                  style: GoogleFonts.poppins(
                    fontSize: 30,
                    fontWeight: FontWeight.w500,
                  ),
                ),
                //weather animation
                Lottie.asset(
                  getWeatherAnimation(
                    _weather?.mainCondition,
                  ),
                ),
                const Spacer(),
                RichText(
                  text: const TextSpan(
                    children: [
                      TextSpan(
                        text: 'Made with ❤️ ',
                        style: TextStyle(),
                      ),
                      TextSpan(
                        text: 'by ',
                        style: TextStyle(),
                      ),
                      TextSpan(
                        text: 'Smith Osagie',
                        style: TextStyle(
                          color: Colors.orange,
                        ),
                      ),
                    ],
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
