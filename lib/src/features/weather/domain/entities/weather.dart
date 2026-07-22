import 'package:equatable/equatable.dart';

/// Weather entity representing current weather conditions for a city
class Weather extends Equatable {
  final String city;
  final double temperature;
  final String description;
  final String icon;
  final double feelsLike;
  final int humidity;
  final double windSpeed;

  const Weather({
    required this.city,
    required this.temperature,
    required this.description,
    required this.icon,
    required this.feelsLike,
    required this.humidity,
    required this.windSpeed,
  });

  @override
  List<Object?> get props => [
        city,
        temperature,
        description,
        icon,
        feelsLike,
        humidity,
        windSpeed,
      ];
}
