import 'dart:convert';

import 'package:weatherly/src/imports/core_imports.dart';
import 'package:weatherly/src/features/weather/data/models/weather_model.dart';

/// Local datasource for caching weather data
class WeatherLocalDataSource {
  static const String _cachedWeatherKey = 'cached_weather';

  /// Cache weather data locally
  Future<void> cacheWeather(WeatherModel weather) async {
    try {
      final jsonString = jsonEncode(weather.toJson());
      final result = await StorageService.instance.setString(_cachedWeatherKey, jsonString);
      result.fold(
        (failure) => throw Exception('Failed to cache weather data'),
        (_) => AppLogger.info('Weather data cached successfully'),
      );
    } catch (e) {
      AppLogger.error('Error caching weather: $e');
      throw Exception('Failed to cache weather data');
    }
  }

  /// Get cached weather data
  Future<WeatherModel?> getCachedWeather() async {
    try {
      final cachedString = StorageService.instance.getString(_cachedWeatherKey);
      if (cachedString == null) {
        return null;
      }

      final jsonData = jsonDecode(cachedString) as Map<String, dynamic>;
      return WeatherModel.fromJsonCache(jsonData);
    } catch (e) {
      AppLogger.error('Error getting cached weather: $e');
      return null;
    }
  }

  /// Clear cached weather data
  Future<void> clearCache() async {
    try {
      await StorageService.instance.remove(_cachedWeatherKey);
      AppLogger.info('Weather cache cleared');
    } catch (e) {
      AppLogger.error('Error clearing cache: $e');
    }
  }
}
