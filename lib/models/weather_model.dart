class WeatherModel {
  final String locationName;
  final double temperature;
  final String mainCondition;
  final String description;
  final int timestamp;
  final int sunrise;
  final int sunset;
  final double humidity;
  final double pressure;
  final double windSpeed;
  final int visibility;
  final double feelsLike;

  WeatherModel({
    required this.locationName,
    required this.temperature,
    required this.mainCondition,
    required this.description,
    required this.timestamp,
    required this.sunrise,
    required this.sunset,
    required this.humidity,
    required this.pressure,
    required this.windSpeed,
    required this.visibility,
    required this.feelsLike,
  });

  factory WeatherModel.fromJson(Map<String, dynamic> json) {
    try {
      return WeatherModel(
        locationName: json['name'] ?? 'Unknown Location',
        temperature: (json['main']['temp'] ?? 0.0).toDouble(),
        mainCondition: json['weather'][0]['main'] ?? 'Unknown',
        description: json['weather'][0]['description'] ?? 'No description',
        timestamp: json['dt'] ?? 0,
        sunrise: json['sys']['sunrise'] ?? 0,
        sunset: json['sys']['sunset'] ?? 0,
        humidity: (json['main']['humidity'] ?? 0.0).toDouble(),
        pressure: (json['main']['pressure'] ?? 0.0).toDouble(),
        windSpeed: (json['wind']['speed'] ?? 0.0).toDouble(),
        visibility: json['visibility'] ?? 0,
        feelsLike: (json['main']['feels_like'] ?? 0.0).toDouble(),
      );
    } catch (e) {
      throw Exception('Error parsing weather data: ${e.toString()}');
    }
  }

  Map<String, dynamic> toJson() {
    return {
      'name': locationName,
      'main': {
        'temp': temperature,
        'humidity': humidity,
        'pressure': pressure,
        'feels_like': feelsLike,
      },
      'weather': [
        {'main': mainCondition, 'description': description},
      ],
      'dt': timestamp,
      'sys': {'sunrise': sunrise, 'sunset': sunset},
      'wind': {'speed': windSpeed},
      'visibility': visibility,
    };
  }

  WeatherModel copyWith({
    String? locationName,
    double? temperature,
    String? mainCondition,
    String? description,
    int? timestamp,
    int? sunrise,
    int? sunset,
    double? humidity,
    double? pressure,
    double? windSpeed,
    int? visibility,
    double? feelsLike,
  }) {
    return WeatherModel(
      locationName: locationName ?? this.locationName,
      temperature: temperature ?? this.temperature,
      mainCondition: mainCondition ?? this.mainCondition,
      description: description ?? this.description,
      timestamp: timestamp ?? this.timestamp,
      sunrise: sunrise ?? this.sunrise,
      sunset: sunset ?? this.sunset,
      humidity: humidity ?? this.humidity,
      pressure: pressure ?? this.pressure,
      windSpeed: windSpeed ?? this.windSpeed,
      visibility: visibility ?? this.visibility,
      feelsLike: feelsLike ?? this.feelsLike,
    );
  }

  String get temperatureString => '${temperature.round()}°C';

  String get feelsLikeString => '${feelsLike.round()}°C';

  String get humidityString => '${humidity.round()}%';

  String get pressureString => '${pressure.round()} hPa';

  String get windSpeedString => '${windSpeed.round()} m/s';

  String get visibilityString => '${(visibility / 1000).round()} km';

  bool get isDayTime {
    final now = DateTime.now().millisecondsSinceEpoch ~/ 1000;
    return now >= sunrise && now < sunset;
  }

  @override
  String toString() {
    return 'WeatherModel(locationName: $locationName, temperature: $temperature, mainCondition: $mainCondition)';
  }

  @override
  bool operator ==(Object other) {
    if (identical(this, other)) return true;
    return other is WeatherModel &&
        other.locationName == locationName &&
        other.temperature == temperature &&
        other.mainCondition == mainCondition &&
        other.timestamp == timestamp;
  }

  @override
  int get hashCode {
    return locationName.hashCode ^
        temperature.hashCode ^
        mainCondition.hashCode ^
        timestamp.hashCode;
  }
}
