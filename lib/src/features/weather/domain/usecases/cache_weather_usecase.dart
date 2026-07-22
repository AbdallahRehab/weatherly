import 'package:weatherly/src/utils/utils.dart';
import 'package:weatherly/src/features/weather/domain/entities/weather.dart';
import 'package:weatherly/src/features/weather/domain/repositories/weather_repository.dart';

class CacheWeatherUseCase {
  final WeatherRepository _repository;

  CacheWeatherUseCase(this._repository);

  /// Cache weather data locally
  FutureEither<void> call(Weather weather) {
    return _repository.cacheWeather(weather);
  }
}
