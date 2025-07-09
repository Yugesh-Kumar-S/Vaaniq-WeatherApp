import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:weather_app/providers/weather_provider.dart';
import 'package:weather_app/widgets/search_bar_widget.dart';
import 'package:weather_app/widgets/weather_card.dart';
import 'package:weather_app/widgets/forecast_widget.dart';
import 'package:weather_app/widgets/error_widget.dart' as custom;

import '../widgets/loading_widget.dart';

class SearchScreen extends StatefulWidget {
  const SearchScreen({super.key});

  @override
  State<SearchScreen> createState() => _SearchScreenState();
}

class _SearchScreenState extends State<SearchScreen> {
  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addPostFrameCallback((_) {
      context.read<WeatherProvider>().clearSearchedWeather();
    });
  }

  @override
  Widget build(BuildContext context) {
    return Consumer<WeatherProvider>(
      builder: (context, weatherProvider, child) {
        return SafeArea(
          child: Scaffold(
            resizeToAvoidBottomInset: true,
            body: SingleChildScrollView(
              child: Column(
                children: [
                  Padding(
                    padding: const EdgeInsets.all(16.0),
                    child: SearchBarWidget(
                      onSearch: (cityName) {
                        weatherProvider.clearSearchedWeather();
                        weatherProvider.fetchWeatherByCity(cityName);
                      },
                      enabled: !weatherProvider.isLoading,
                    ),
                  ),

                  SizedBox(
                    height: 200,
                    child: _buildWeatherInfo(weatherProvider),
                  ),

                  if (weatherProvider.searchedWeather != null) ...[
                    const SizedBox(height: 16),
                    ForecastWidget(
                      cityName: weatherProvider.searchedWeather!.locationName,
                    ),
                    const SizedBox(height: 16),
                  ],
                ],
              ),
            ),
          ),
        );
      },
    );
  }

  Widget _buildWeatherInfo(WeatherProvider weatherProvider) {
    if (weatherProvider.isLoading) {
      return const LoadingWidget(showAnimation: true);
    }

    if (weatherProvider.errorMessage != null &&
        weatherProvider.errorMessage!.contains('Failed to fetch weather for')) {
      return Padding(
        padding: const EdgeInsets.all(16.0),
        child: custom.ErrorWidget(message: weatherProvider.errorMessage!),
      );
    }

    if (weatherProvider.searchedWeather != null) {
      return Container(
        padding: const EdgeInsets.all(16.0),
        child: WeatherCard(
          weatherModel: weatherProvider.searchedWeather!,
          showAnimation: true,
          isCompact: true,
        ),
      );
    }

    return const Center(
      child: Padding(
        padding: EdgeInsets.all(16.0),
        child: Text(
          'Search for a city to get weather information',
          style: TextStyle(
            fontSize: 16,
            color: Colors.grey,
            fontWeight: FontWeight.bold,
          ),
          textAlign: TextAlign.center,
        ),
      ),
    );
  }
}
