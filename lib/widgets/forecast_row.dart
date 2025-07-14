import 'package:flutter/material.dart';
import 'package:weather_app/models/forecast_model.dart';

class ForecastRow extends StatelessWidget {
  final ForecastItem forecastItem;
  final bool isLast;

  const ForecastRow({
    super.key,
    required this.forecastItem,
    this.isLast = false,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.symmetric(vertical: 12, horizontal: 16),
      decoration: BoxDecoration(
        border:
            isLast
                ? null
                : Border(
                  bottom: BorderSide(color: Colors.grey[200]!, width: 1),
                ),
      ),
      child: Row(
        children: [
          Expanded(
            flex: 3,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  forecastItem.formattedDate,
                  style: const TextStyle(
                    fontWeight: FontWeight.w600,
                    fontSize: 14,
                    color: Colors.black87,
                  ),
                ),
                const SizedBox(height: 2),
                Text(
                  forecastItem.formattedTime,
                  style: TextStyle(fontSize: 12, color: Colors.grey[600]),
                ),
              ],
            ),
          ),

          Expanded(
            flex: 2,
            child: Column(
              children: [
                Image.network(
                  'https://openweathermap.org/img/wn/${forecastItem.weatherIcon}@2x.png',
                  width: 40,
                  height: 40,
                  errorBuilder: (context, error, stackTrace) {
                    return Icon(Icons.cloud, size: 30, color: Colors.grey[400]);
                  },
                ),
                const SizedBox(height: 4),
                Text(
                  forecastItem.weatherMain,
                  style: TextStyle(
                    fontSize: 11,
                    color: Colors.grey[600],
                    fontWeight: FontWeight.w500,
                  ),
                  textAlign: TextAlign.center,
                  maxLines: 1,
                  overflow: TextOverflow.ellipsis,
                ),
              ],
            ),
          ),

          Expanded(
            flex: 2,
            child: Column(
              children: [
                Text(
                  '${forecastItem.temperature.round()}°C',
                  style: const TextStyle(
                    fontSize: 16,
                    fontWeight: FontWeight.bold,
                    color: Colors.black87,
                  ),
                  textAlign: TextAlign.center,
                ),
                const SizedBox(height: 2),
                Text(
                  'Feels ${forecastItem.feelsLike.round()}°',
                  style: TextStyle(fontSize: 11, color: Colors.grey[600]),
                  textAlign: TextAlign.center,
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
