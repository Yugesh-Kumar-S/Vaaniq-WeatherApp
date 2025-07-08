import 'package:flutter/material.dart';
import 'package:weather_app/models/weather_model.dart';
import 'package:weather_app/services/weather_service.dart';

class WeatherProvider extends ChangeNotifier {
  final WeatherService _weatherService;

  WeatherModel? _currentWeather;
  WeatherModel? _searchedWeather;
  bool _isLoading = false;
  String? _errorMessage;

  WeatherProvider({required WeatherService weatherService})
    : _weatherService = weatherService;

  WeatherModel? get currentWeather => _currentWeather;
  WeatherModel? get searchedWeather => _searchedWeather;
  bool get isLoading => _isLoading;
  String? get errorMessage => _errorMessage;

  void _setLoading(bool loading) {
    _isLoading = loading;
    notifyListeners();
  }

  void _setError(String? error) {
    _errorMessage = error;
    notifyListeners();
  }

  void clearError() {
    _errorMessage = null;
    notifyListeners();
  }

  Future<void> fetchCurrentLocationWeather() async {
    _setLoading(true);
    _setError(null);

    try {
      _currentWeather = await _weatherService.getWeatherForCurrentLocation();
      notifyListeners();
    } catch (e) {
      _setError('Failed to fetch current location weather: ${e.toString()}');
    } finally {
      _setLoading(false);
    }
  }

  Future<void> fetchWeatherByCity(String cityName) async {
    _setLoading(true);
    _setError(null);

    try {
      _searchedWeather = await _weatherService.getWeatherForCity(cityName);
      notifyListeners();
    } catch (e) {
      _setError('Failed to fetch weather for $cityName: ${e.toString()}');
    } finally {
      _setLoading(false);
    }
  }

  Future<void> fetchWeatherByCoordinates(double lat, double lon) async {
    _setLoading(true);
    _setError(null);

    try {
      _searchedWeather = await _weatherService.getWeatherByLocation(lat, lon);
      notifyListeners();
    } catch (e) {
      _setError('Failed to fetch weather for coordinates: ${e.toString()}');
    } finally {
      _setLoading(false);
    }
  }

  Future<void> refreshCurrentWeather() async {
    await fetchCurrentLocationWeather();
  }

  void clearSearchedWeather() {
    _searchedWeather = null;
    notifyListeners();
  }
}
