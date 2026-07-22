import 'package:weatherly/src/utils/utils.dart';
import 'package:weatherly/src/features/weather/domain/entities/weather.dart';

abstract class WeatherRepository {
  /// Fetch current weather data for a given city
  FutureEither<Weather> getWeather(String city);

  /// Save weather data to local cache
  FutureEither<void> cacheWeather(Weather weather);

  /// Get cached weather data
  FutureEither<Weather?> getCachedWeather();
}
