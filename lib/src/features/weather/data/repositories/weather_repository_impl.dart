import 'package:weatherly/src/imports/core_imports.dart';

import 'package:weatherly/src/features/weather/domain/entities/weather.dart';
import 'package:weatherly/src/features/weather/domain/repositories/weather_repository.dart';
import 'package:weatherly/src/features/weather/data/datasources/weather_remote_datasource.dart';
import 'package:weatherly/src/features/weather/data/datasources/weather_local_datasource.dart';
import 'package:weatherly/src/features/weather/data/models/weather_model.dart';

/// Implementation of WeatherRepository
class WeatherRepositoryImpl implements WeatherRepository {
  final WeatherRemoteDataSource _remoteDataSource;
  final WeatherLocalDataSource _localDataSource;

  WeatherRepositoryImpl({
    required WeatherRemoteDataSource remoteDataSource,
    required WeatherLocalDataSource localDataSource,
  })  : _remoteDataSource = remoteDataSource,
        _localDataSource = localDataSource;

  @override
  FutureEither<Weather> getWeather(String city) async {
    return runTask(() async {
      final weatherModel = await _remoteDataSource.getWeather(city);
      // Cache the successful result
      await _localDataSource.cacheWeather(weatherModel);
      return weatherModel.toEntity();
    });
  }

  @override
  FutureEither<void> cacheWeather(Weather weather) {
    return runTask(() async {
      final weatherModel = WeatherModel(
        city: weather.city,
        temperature: weather.temperature,
        description: weather.description,
        icon: weather.icon,
        feelsLike: weather.feelsLike,
        humidity: weather.humidity,
        windSpeed: weather.windSpeed,
      );
      await _localDataSource.cacheWeather(weatherModel);
    });
  }

  @override
  FutureEither<Weather?> getCachedWeather() {
    return runTask(() async {
      final weatherModel = await _localDataSource.getCachedWeather();
      return weatherModel?.toEntity();
    });
  }
}
