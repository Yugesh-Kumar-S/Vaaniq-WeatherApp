import 'package:flutter/material.dart';

class WeatherUtils {
  static bool isDayTime(int currentTime, int sunrise, int sunset) {
    return currentTime >= sunrise && currentTime < sunset;
  }

  static String getWeatherAnimation(String? mainCondition, bool isDayTime) {
    if (mainCondition == null) {
      return isDayTime ? 'assets/sunny-day.json' : 'assets/night-clear.json';
    }

    switch (mainCondition.toLowerCase()) {
      case 'squall':
      case 'tornado':
        return 'assets/windy.json';

      case 'clouds':
      case 'mist':
      case 'fog':
      case 'ash':
      case 'smoke':
      case 'haze':
        return isDayTime
            ? 'assets/partlycloud-day.json'
            : 'assets/partlycloud-night.json';

      case 'clear':
        return isDayTime ? 'assets/sunny-day.json' : 'assets/night-clear.json';

      case 'rain':
      case 'thunderstorm':
        return 'assets/thunderstrom-rain.json';

      case 'drizzle':
        return isDayTime ? 'assets/day-rain.json' : 'assets/night-rain.json';

      default:
        return isDayTime ? 'assets/sunny-day.json' : 'assets/night-clear.json';
    }
  }

  static ThemeData getWeatherTheme(bool isDayTime) {
    return isDayTime ? _dayTheme : _nightTheme;
  }

  static final ThemeData _dayTheme = ThemeData(
    brightness: Brightness.light,
    primarySwatch: Colors.blue,
    scaffoldBackgroundColor: Colors.lightBlueAccent[100],
    textTheme: TextTheme(
      headlineLarge: TextStyle(color: Colors.grey[700]),
      headlineMedium: TextStyle(color: Colors.grey[700]),
      bodyLarge: TextStyle(color: Colors.grey[700]),
      bodyMedium: TextStyle(color: Colors.black),
    ),
    appBarTheme: AppBarTheme(
      backgroundColor: Colors.white,
      foregroundColor: Colors.grey[700],
      elevation: 0,
    ),
  );

  static final ThemeData _nightTheme = ThemeData(
    brightness: Brightness.dark,
    primarySwatch: Colors.blue,
    scaffoldBackgroundColor: Colors.blue[900],
    textTheme: const TextTheme(
      headlineLarge: TextStyle(color: Colors.white),
      headlineMedium: TextStyle(color: Colors.white),
      bodyLarge: TextStyle(color: Colors.white),
      bodyMedium: TextStyle(color: Colors.white),
    ),
    appBarTheme: AppBarTheme(
      backgroundColor: Colors.grey[800],
      foregroundColor: Colors.white,
      elevation: 0,
    ),
  );

  static IconData getWeatherIcon(String? mainCondition) {
    if (mainCondition == null) return Icons.wb_sunny;

    switch (mainCondition.toLowerCase()) {
      case 'clear':
        return Icons.wb_sunny;
      case 'clouds':
      case 'mist':
      case 'fog':
      case 'haze':
        return Icons.cloud;
      case 'rain':
      case 'drizzle':
        return Icons.water_drop;
      case 'thunderstorm':
        return Icons.flash_on;
      case 'snow':
        return Icons.ac_unit;
      case 'squall':
      case 'tornado':
        return Icons.air;
      default:
        return Icons.wb_sunny;
    }
  }

  static String formatTemperature(double? temperature) {
    if (temperature == null) return 'N/A';
    return '${temperature.round()}°C';
  }

  static Color getWeatherDescriptionColor(String? condition, bool isDayTime) {
    if (condition == null) return isDayTime ? Colors.grey[700]! : Colors.white;

    switch (condition.toLowerCase()) {
      case 'clear':
        return isDayTime ? Colors.orange : Colors.yellow;
      case 'rain':
      case 'drizzle':
        return Colors.blue;
      case 'thunderstorm':
        return Colors.purple;
      case 'snow':
        return Colors.lightBlue;
      case 'clouds':
        return Colors.grey;
      default:
        return isDayTime ? Colors.grey[700]! : Colors.white;
    }
  }
}
