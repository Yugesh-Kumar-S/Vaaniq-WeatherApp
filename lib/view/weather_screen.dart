import 'package:flutter/material.dart';
import 'package:geolocator/geolocator.dart';
import 'package:provider/provider.dart';
import 'package:weather_app/providers/weather_provider.dart';
import 'package:weather_app/utils/weather_utils.dart';
import 'package:weather_app/widgets/weather_card.dart';
import 'package:weather_app/widgets/loading_widget.dart';
import 'package:weather_app/widgets/error_widget.dart' as custom;

class WeatherScreen extends StatefulWidget {
  const WeatherScreen({super.key});

  @override
  State<WeatherScreen> createState() => _WeatherScreenState();
}

class _WeatherScreenState extends State<WeatherScreen> {
  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addPostFrameCallback((_) {
      context.read<WeatherProvider>().fetchCurrentLocationWeather();
    });
  }

  @override
  Widget build(BuildContext context) {
    return Consumer<WeatherProvider>(
      builder: (context, weatherProvider, child) {
        return Scaffold(
          backgroundColor: _getBackgroundColor(weatherProvider),
          body: _buildBody(weatherProvider),
          floatingActionButton: _buildFloatingActionButton(weatherProvider),
          floatingActionButtonLocation:
              FloatingActionButtonLocation.centerFloat,
        );
      },
    );
  }

  Widget _buildBody(WeatherProvider weatherProvider) {
    if (weatherProvider.isLoading) {
      return const LoadingWidget(
        message: 'Fetching weather...',
        showAnimation: true,
      );
    }

    if (weatherProvider.errorMessage != null) {
      return custom.ErrorWidget(message: weatherProvider.errorMessage!);
    }

    if (weatherProvider.currentWeather != null) {
      return Center(
        child: SingleChildScrollView(
          child: Padding(
            padding: const EdgeInsets.all(16.0),
            child: WeatherCard(
              weatherModel: weatherProvider.currentWeather!,
              showAnimation: true,
              isCompact: false,
            ),
          ),
        ),
      );
    }

    return const LoadingWidget(
      message: 'Loading weather data...',
      showAnimation: true,
    );
  }

  Widget _buildFloatingActionButton(WeatherProvider weatherProvider) {
    return FloatingActionButton(
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(50)),
      onPressed:
          weatherProvider.isLoading
              ? null
              : () async {
                bool serviceEnabled =
                    await Geolocator.isLocationServiceEnabled();
                LocationPermission permission =
                    await Geolocator.checkPermission();

                if (!serviceEnabled ||
                    permission == LocationPermission.denied ||
                    permission == LocationPermission.deniedForever) {
                  // Optionally, open location settings
                  await Geolocator.openLocationSettings();
                  return;
                }

                // If location is enabled and permissions are granted
                weatherProvider.refreshCurrentWeather();
              },
      backgroundColor: Theme.of(context).colorScheme.surface,
      child: const Icon(Icons.refresh, color: Colors.deepOrange),
    );
  }

  Color _getBackgroundColor(WeatherProvider weatherProvider) {
    if (weatherProvider.currentWeather == null) {
      return Colors.white;
    }

    final isDayTime = WeatherUtils.isDayTime(
      weatherProvider.currentWeather!.timestamp,
      weatherProvider.currentWeather!.sunrise,
      weatherProvider.currentWeather!.sunset,
    );

    return WeatherUtils.getWeatherTheme(isDayTime).scaffoldBackgroundColor;
  }
}
