import 'dart:convert';
import 'package:geolocator/geolocator.dart';
import 'package:http/http.dart' as http;
import 'package:weather_app/models/weather_model.dart';

class WeatherService {
  static const String _baseUrl =
      'https://api.openweathermap.org/data/2.5/weather';
  final String _apiKey;

  WeatherService({required String apiKey}) : _apiKey = apiKey;

  Future<WeatherModel> getWeatherByLocation(double lat, double lon) async {
    try {
      final uri = Uri.parse(
        '$_baseUrl?lat=$lat&lon=$lon&appid=$_apiKey&units=metric',
      );
      final response = await http.get(uri);

      if (response.statusCode == 200) {
        final data = jsonDecode(response.body);
        return WeatherModel.fromJson(data);
      } else {
        throw WeatherException(
          'Failed to load weather data: ${response.statusCode}',
        );
      }
    } catch (e) {
      if (e is WeatherException) rethrow;
      throw WeatherException('Network error: ${e.toString()}');
    }
  }

  Future<WeatherModel> getWeatherForCurrentLocation() async {
    try {
      final position = await _getCurrentPosition();
      return await getWeatherByLocation(position.latitude, position.longitude);
    } catch (e) {
      if (e is WeatherException) rethrow;
      throw WeatherException('Location error: ${e.toString()}');
    }
  }

  Future<WeatherModel> getWeatherForCity(String cityName) async {
    try {
      final uri = Uri.parse(
        '$_baseUrl?q=$cityName&appid=$_apiKey&units=metric',
      );
      final response = await http.get(uri);

      if (response.statusCode == 200) {
        final data = jsonDecode(response.body);
        return WeatherModel.fromJson(data);
      } else if (response.statusCode == 404) {
        throw WeatherException('City not found: $cityName');
      } else {
        throw WeatherException(
          'Failed to fetch weather data: ${response.statusCode}',
        );
      }
    } catch (e) {
      if (e is WeatherException) rethrow;
      throw WeatherException('Network error: ${e.toString()}');
    }
  }

  Future<Position> _getCurrentPosition() async {
    bool serviceEnabled = await Geolocator.isLocationServiceEnabled();
    if (!serviceEnabled) {
      throw WeatherException('Location services are disabled');
    }

    LocationPermission permission = await Geolocator.checkPermission();
    if (permission == LocationPermission.denied) {
      permission = await Geolocator.requestPermission();
      if (permission == LocationPermission.denied) {
        throw WeatherException('Location permissions are denied');
      }
    }

    if (permission == LocationPermission.deniedForever) {
      throw WeatherException('Location permissions are permanently denied');
    }

    try {
      LocationSettings locationSettings = const LocationSettings(
        accuracy: LocationAccuracy.high,
      );

      return await Geolocator.getCurrentPosition(
        locationSettings: locationSettings,
      ).timeout(
        const Duration(seconds: 10),
        onTimeout:
            () =>
                throw WeatherException(
                  'Failed to get current location: Timeout',
                ),
      );
    } catch (e) {
      throw WeatherException('Failed to get current location: ${e.toString()}');
    }
  }
}

class WeatherException implements Exception {
  final String message;

  WeatherException(this.message);

  @override
  String toString() => message;
}
