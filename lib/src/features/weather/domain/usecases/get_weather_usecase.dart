import 'package:weatherly/src/utils/utils.dart';
import 'package:weatherly/src/features/weather/domain/entities/weather.dart';
import 'package:weatherly/src/features/weather/domain/repositories/weather_repository.dart';
import 'package:fpdart/fpdart.dart' hide State;

class GetWeatherUseCase {
  final WeatherRepository _repository;

  GetWeatherUseCase(this._repository);

  /// Execute weather fetch for a city
  FutureEither<Weather> call(String city) async {
    if (city.trim().isEmpty) {
      return left(const ValidationFailure('City name cannot be empty'));
    }
    return _repository.getWeather(city);
  }
}
