import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:lottie/lottie.dart';
import 'package:weather_app/models/weather_model.dart';
import 'package:weather_app/services/weather_service.dart';

class WeatherScreen extends StatefulWidget {
  const WeatherScreen({super.key});

  @override
  State<WeatherScreen> createState() => _WeatherScreenState();
}

class _WeatherScreenState extends State<WeatherScreen> {
  final _weatherService = WeatherService(
    apiKey: '0688bc07ec45a6f87fee3740d8ed6f34',
  );
  WeatherModel? _weatherModel;

  _fetchWeather() async {
    try {
      final weather = await _weatherService.getWeatherForCurrentLocation();
      setState(() {
        _weatherModel = weather;
      });
    } catch (e) {
      print(e);
    }
  }

  String getWeatherAnimation(String? mainCondition, Color backgroundColor) {
    if (mainCondition == null) return 'assets/sunny-day.json';
    switch (mainCondition) {
      case 'Squall':
      case 'Tornado':
        return 'assets/windy.json';
      case 'Clouds':
      case 'Mist':
      case 'Fog':
      case 'Ash':
      case 'Smoke':
      case 'Haze':
        if (backgroundColor == Colors.white) {
          return 'assets/partlycloud-day.json';
        } else {
          return 'assets/partlycloud-night.json';
        }
      case 'Clear':
        if (backgroundColor == Colors.white) {
          return 'assets/sunny-day.json';
        } else {
          return 'assets/night-clear.json';
        }
      case 'Rain':
      case 'Thunderstorm':
        return 'assets/thunderstrom-rain.json';

      case 'Drizzle':
        if (backgroundColor == Colors.white) {
          return 'assets/day-rain.json';
        } else {
          return 'assets/night-rain.json';
        }
      default:
        if (backgroundColor == Colors.white) {
          return 'assets/sunny-day.json';
        } else {
          return 'assets/night-clear.json';
        }
    }
  }

  bool isDayTime(int currentTime, int sunrise, int sunset) {
    return currentTime >= sunrise && currentTime < sunset;
  }

  @override
  void initState() {
    super.initState();
    _fetchWeather();
  }

  @override
  Widget build(BuildContext context) {
    if (_weatherModel == null) {
      return Scaffold(
        backgroundColor: Colors.white,
        body: Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Lottie.asset('assets/loading.json', width: 200),
              const SizedBox(height: 20),
              const Text('Fetching weather...', style: TextStyle(fontSize: 18)),
            ],
          ),
        ),
      );
    }

    Color backgroundColor =
        isDayTime(
              _weatherModel!.timestamp,
              _weatherModel!.sunrise,
              _weatherModel!.sunset,
            )
            ? Colors.white
            : Colors.grey[800]!;
    Color textColor =
        isDayTime(
              _weatherModel!.timestamp,
              _weatherModel!.sunrise,
              _weatherModel!.sunset,
            )
            ? Colors.grey[700]!
            : Colors.white;
    return Scaffold(
      backgroundColor: backgroundColor,
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Text(
              _weatherModel?.locationName ?? 'Loading city info...',
              style: GoogleFonts.poppins(
                fontSize: 30,
                fontWeight: FontWeight.bold,
                color: textColor,
              ),
            ),
            Lottie.asset(
              getWeatherAnimation(
                _weatherModel?.mainCondition,
                backgroundColor,
              ),
            ),
            Text(
              '${_weatherModel?.temperature.round() ?? 'loading '}°C',
              style: GoogleFonts.poppins(
                fontSize: 30,
                fontWeight: FontWeight.w600,
                color: textColor,
                letterSpacing: 2,
              ),
            ),
            SizedBox(height: 40),
            Text(
              _weatherModel?.mainCondition ?? "",
              style: GoogleFonts.poppins(
                fontSize: 20,
                fontWeight: FontWeight.bold,
                fontStyle: FontStyle.italic,
                color: backgroundColor==Colors.white ? Colors.black: Colors.white,
              ),
            ),
          ],
        ),
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          setState(() {
            _weatherModel = null;
          });
          _fetchWeather();
        },
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(50)),
        backgroundColor: textColor,
        elevation: 10,
        child: Icon(Icons.refresh, color: backgroundColor),
      ),
      floatingActionButtonLocation: FloatingActionButtonLocation.centerFloat,
    );
  }
}
