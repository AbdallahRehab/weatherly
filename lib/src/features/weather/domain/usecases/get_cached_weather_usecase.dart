import 'package:weatherly/src/utils/utils.dart';
import 'package:weatherly/src/features/weather/domain/entities/weather.dart';
import 'package:weatherly/src/features/weather/domain/repositories/weather_repository.dart';

class GetCachedWeatherUseCase {
  final WeatherRepository _repository;

  GetCachedWeatherUseCase(this._repository);

  /// Get cached weather data
  FutureEither<Weather?> call() {
    return _repository.getCachedWeather();
  }
}
