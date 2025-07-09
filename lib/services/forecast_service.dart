import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:weather_app/models/forecast_model.dart';

class ForecastService {
  static const String _baseUrl = 'https://api.openweathermap.org/data/2.5';
  static const String _apiKey = '0688bc07ec45a6f87fee3740d8ed6f34';

  static Future<ForecastModel> getForecastByCity(String cityName) async {
    try {
      final url = Uri.parse(
        '$_baseUrl/forecast?q=$cityName&appid=$_apiKey&units=metric',
      );

      final response = await http.get(url);

      if (response.statusCode == 200) {
        final data = json.decode(response.body);
        return ForecastModel.fromJson(data);
      } else {
        final errorData = json.decode(response.body);
        throw Exception(errorData['message'] ?? 'Failed to load forecast');
      }
    } catch (e) {
      throw Exception('Error fetching forecast: $e');
    }
  }

  static Future<ForecastModel> getForecastByCoordinates(
    double lat,
    double lon,
  ) async {
    try {
      final url = Uri.parse(
        '$_baseUrl/forecast?lat=$lat&lon=$lon&appid=$_apiKey&units=metric',
      );

      final response = await http.get(url);

      if (response.statusCode == 200) {
        final data = json.decode(response.body);
        return ForecastModel.fromJson(data);
      } else {
        final errorData = json.decode(response.body);
        throw Exception(errorData['message'] ?? 'Failed to load forecast');
      }
    } catch (e) {
      throw Exception('Error fetching forecast: $e');
    }
  }
}
