class ForecastModel {
  final String cityName;
  final List<ForecastItem> forecastList;

  ForecastModel({required this.cityName, required this.forecastList});

  factory ForecastModel.fromJson(Map<String, dynamic> json) {
    return ForecastModel(
      cityName: json['city']['name'] ?? '',
      forecastList:
          (json['list'] as List)
              .map((item) => ForecastItem.fromJson(item))
              .toList(),
    );
  }
}

class ForecastItem {
  final DateTime dateTime;
  final double temperature;
  final double feelsLike;
  final int humidity;
  final String weatherMain;
  final String weatherDescription;
  final String weatherIcon;
  final double windSpeed;

  ForecastItem({
    required this.dateTime,
    required this.temperature,
    required this.feelsLike,
    required this.humidity,
    required this.weatherMain,
    required this.weatherDescription,
    required this.weatherIcon,
    required this.windSpeed,
  });

  factory ForecastItem.fromJson(Map<String, dynamic> json) {
    return ForecastItem(
      dateTime: DateTime.fromMillisecondsSinceEpoch(json['dt'] * 1000),
      temperature: (json['main']['temp'] ?? 0.0).toDouble(),
      feelsLike: (json['main']['feels_like'] ?? 0.0).toDouble(),
      humidity: json['main']['humidity'] ?? 0,
      weatherMain: json['weather'][0]['main'] ?? '',
      weatherDescription: json['weather'][0]['description'] ?? '',
      weatherIcon: json['weather'][0]['icon'] ?? '',
      windSpeed: (json['wind']['speed'] ?? 0.0).toDouble(),
    );
  }

  String get formattedDate {
    return '${dateTime.day.toString().padLeft(2, '0')}/${dateTime.month.toString().padLeft(2, '0')}';
  }

  String get formattedTime {
    return '${dateTime.hour.toString().padLeft(2, '0')}:${dateTime.minute.toString().padLeft(2, '0')}';
  }

  String get formattedDateTime {
    return '$formattedDate ${formattedTime}';
  }
}
