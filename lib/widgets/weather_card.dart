import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:lottie/lottie.dart';
import 'package:weather_app/models/weather_model.dart';
import 'package:weather_app/utils/weather_utils.dart';

class WeatherCard extends StatelessWidget {
  final WeatherModel weatherModel;
  final bool showAnimation;
  final bool isCompact;

  const WeatherCard({
    super.key,
    required this.weatherModel,
    this.showAnimation = true,
    this.isCompact = false,
  });

  @override
  Widget build(BuildContext context) {
    final isDayTime = WeatherUtils.isDayTime(
      weatherModel.timestamp,
      weatherModel.sunrise,
      weatherModel.sunset,
    );

    final theme = WeatherUtils.getWeatherTheme(isDayTime);
    final textColor = theme.textTheme.headlineLarge!.color!;
    final backgroundColor = theme.scaffoldBackgroundColor;

    if (isCompact) {
      return _buildCompactCard(textColor, isDayTime);
    }

    return _buildFullCard(textColor, backgroundColor, isDayTime);
  }

  Widget _buildCompactCard(Color textColor, bool isDayTime) {
    return Container(
      padding: const EdgeInsets.all(16.0),
      decoration: BoxDecoration(
        color: WeatherUtils.getWeatherTheme(isDayTime).scaffoldBackgroundColor,
        borderRadius: BorderRadius.circular(12),
        boxShadow: [
          BoxShadow(
            color: Colors.black26,
            blurRadius: 8,
            offset: const Offset(0, 4),
          ),
        ],
      ),
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          Text(
            weatherModel.locationName,
            style: GoogleFonts.poppins(
              fontSize: 18,
              fontWeight: FontWeight.bold,
              color: textColor,
            ),
          ),
          const SizedBox(height: 8),
          Expanded(
            child: Lottie.asset(
              WeatherUtils.getWeatherAnimation(
                weatherModel.mainCondition,
                isDayTime,
              ),
            ),
          ),
          const SizedBox(height: 8),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            children: [
              Text(
                weatherModel.mainCondition,
                style: GoogleFonts.poppins(
                  fontSize: 16,
                  fontWeight: FontWeight.w600,
                  color: textColor,
                ),
              ),
              Text(
                WeatherUtils.formatTemperature(weatherModel.temperature),
                style: GoogleFonts.poppins(
                  fontSize: 16,
                  fontWeight: FontWeight.w600,
                  color: textColor,
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }

  Widget _buildFullCard(
    Color textColor,
    Color? backgroundColor,
    bool isDayTime,
  ) {
    return Column(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        Text(
          weatherModel.locationName,
          style: GoogleFonts.poppins(
            fontSize: 30,
            fontWeight: FontWeight.bold,
            color: textColor,
          ),
        ),
        if (showAnimation) ...[
          const SizedBox(height: 20),
          Lottie.asset(
            WeatherUtils.getWeatherAnimation(
              weatherModel.mainCondition,
              isDayTime,
            ),
            height: 200,
            width: 200,
          ),
        ] else ...[
          const SizedBox(height: 20),
          Icon(
            WeatherUtils.getWeatherIcon(weatherModel.mainCondition),
            size: 80,
            color: textColor,
          ),
        ],
        const SizedBox(height: 20),
        Text(
          WeatherUtils.formatTemperature(weatherModel.temperature),
          style: GoogleFonts.poppins(
            fontSize: 30,
            fontWeight: FontWeight.w600,
            color: textColor,
            letterSpacing: 2,
          ),
        ),
        const SizedBox(height: 20),
        Text(
          weatherModel.mainCondition,
          style: GoogleFonts.poppins(
            fontSize: 20,
            fontWeight: FontWeight.bold,
            fontStyle: FontStyle.italic,
            color: WeatherUtils.getWeatherDescriptionColor(
              weatherModel.mainCondition,
              isDayTime,
            ),
          ),
        ),
      ],
    );
  }
}
