import 'package:flutter/material.dart';
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
      return custom.ErrorWidget(
        message: weatherProvider.errorMessage!,
        onRetry: () {
          weatherProvider.clearError();
          weatherProvider.fetchCurrentLocationWeather();
        },
      );
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
    final isDayTime =
        weatherProvider.currentWeather != null
            ? WeatherUtils.isDayTime(
              weatherProvider.currentWeather!.timestamp,
              weatherProvider.currentWeather!.sunrise,
              weatherProvider.currentWeather!.sunset,
            )
            : true;

    final theme = WeatherUtils.getWeatherTheme(isDayTime);
    final textColor = theme.textTheme.headlineLarge!.color!;

    return FloatingActionButton(
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(50)),
      onPressed:
          weatherProvider.isLoading
              ? null
              : () {
                weatherProvider.refreshCurrentWeather();
              },
      backgroundColor: textColor,
      child: Icon(Icons.refresh, color: Colors.deepOrange),
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
