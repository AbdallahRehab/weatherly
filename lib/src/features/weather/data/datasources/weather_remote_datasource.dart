import 'package:weatherly/src/imports/core_imports.dart';
import 'package:weatherly/src/imports/packages_imports.dart';
import 'package:weatherly/src/features/weather/data/models/weather_model.dart';

/// Remote datasource for fetching weather data from API
class WeatherRemoteDataSource {
  final Dio _dio;

  WeatherRemoteDataSource(this._dio);

  /// Fetch weather data from WeatherAPI
  Future<WeatherModel> getWeather(String city) async {
    try {
      final response = await _dio.get<Map<String, dynamic>>(
        '/v1/current.json',
        queryParameters: <String, dynamic>{
          'key': '6f27a7b9512c4882a45162444252101',
          'q': city,
        },
      );

      if (response.statusCode == 200 && response.data != null) {
        return WeatherModel.fromJson(response.data!);
      } else {
        throw Exception(
          'Failed to fetch weather: ${response.statusCode}',
        );
      }
    } on DioException catch (e) {
      AppLogger.error('DioException in getWeather: ${e.message}');
      throw Exception(
        _getErrorMessage(e),
      );
    } catch (e) {
      AppLogger.error('Unexpected error in getWeather: $e');
      throw Exception('errors.unexpected');
    }
  }

  String _getErrorMessage(DioException e) {
    switch (e.type) {
      case DioExceptionType.connectionTimeout:
      case DioExceptionType.receiveTimeout:
      case DioExceptionType.sendTimeout:
        return 'errors.connection_timeout';
      case DioExceptionType.connectionError:
        return 'errors.no_internet';
      case DioExceptionType.badResponse:
        if (e.response?.statusCode == 400) {
          return 'errors.invalid_city';
        } else if (e.response?.statusCode == 401) {
          return 'errors.api_key_error';
        } else if (e.response?.statusCode == 404) {
          return 'errors.city_not_found';
        }
        return 'errors.server_error';
      default:
        return 'errors.fetch_failed';
    }
  }
}
