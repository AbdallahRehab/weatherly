import 'package:weatherly/src/features/weather/domain/entities/weather.dart';

/// Weather model for API response mapping
class WeatherModel {
  final String city;
  final double temperature;
  final String description;
  final String icon;
  final double feelsLike;
  final int humidity;
  final double windSpeed;

  WeatherModel({
    required this.city,
    required this.temperature,
    required this.description,
    required this.icon,
    required this.feelsLike,
    required this.humidity,
    required this.windSpeed,
  });

  /// Create WeatherModel from WeatherAPI JSON response
  factory WeatherModel.fromJson(Map<String, dynamic> json) {
    final location = json['location'] as Map<String, dynamic>?;
    final current = json['current'] as Map<String, dynamic>?;
    final condition = current?['condition'] as Map<String, dynamic>?;

    return WeatherModel(
      city: location?['name']?.toString() ?? 'Unknown',
      temperature: (current?['temp_c'] as num?)?.toDouble() ?? 0.0,
      description: condition?['text']?.toString() ?? 'Unknown',
      icon: condition?['icon']?.toString() ?? '',
      feelsLike: (current?['feelslike_c'] as num?)?.toDouble() ?? 0.0,
      humidity: current?['humidity'] as int? ?? 0,
      windSpeed: (current?['wind_kph'] as num?)?.toDouble() ?? 0.0,
    );
  }

  /// Convert to domain entity
  Weather toEntity() {
    return Weather(
      city: city,
      temperature: temperature,
      description: description,
      icon: icon,
      feelsLike: feelsLike,
      humidity: humidity,
      windSpeed: windSpeed,
    );
  }

  /// Convert to JSON for caching
  Map<String, dynamic> toJson() {
    return {
      'city': city,
      'temperature': temperature,
      'description': description,
      'icon': icon,
      'feelsLike': feelsLike,
      'humidity': humidity,
      'windSpeed': windSpeed,
    };
  }

  /// Create from JSON cache
  factory WeatherModel.fromJsonCache(Map<String, dynamic> json) {
    return WeatherModel(
      city: json['city']?.toString() ?? 'Unknown',
      temperature: (json['temperature'] as num?)?.toDouble() ?? 0.0,
      description: json['description']?.toString() ?? 'Unknown',
      icon: json['icon']?.toString() ?? '',
      feelsLike: (json['feelsLike'] as num?)?.toDouble() ?? 0.0,
      humidity: json['humidity'] as int? ?? 0,
      windSpeed: (json['windSpeed'] as num?)?.toDouble() ?? 0.0,
    );
  }
}
