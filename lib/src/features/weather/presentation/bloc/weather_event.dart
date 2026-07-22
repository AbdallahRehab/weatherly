import 'package:equatable/equatable.dart';

/// Base event for WeatherBloc
abstract class WeatherEvent extends Equatable {
  const WeatherEvent();

  @override
  List<Object?> get props => [];
}

/// Event to fetch weather for a city
class WeatherFetched extends WeatherEvent {
  final String city;

  const WeatherFetched(this.city);

  @override
  List<Object?> get props => [city];
}

/// Event to load cached weather data
class WeatherCacheLoaded extends WeatherEvent {
  const WeatherCacheLoaded();
}

/// Event to refresh current weather
class WeatherRefreshed extends WeatherEvent {
  const WeatherRefreshed();
}
