import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:weatherly/src/features/weather/domain/usecases/get_weather_usecase.dart';
import 'package:weatherly/src/features/weather/domain/usecases/get_cached_weather_usecase.dart';
import 'package:weatherly/src/features/weather/presentation/bloc/weather_event.dart';
import 'package:weatherly/src/features/weather/presentation/bloc/weather_state.dart';

/// Bloc for managing weather state
class WeatherBloc extends Bloc<WeatherEvent, WeatherState> {
  final GetWeatherUseCase _getWeatherUseCase;
  final GetCachedWeatherUseCase _getCachedWeatherUseCase;

  WeatherBloc({
    required GetWeatherUseCase getWeatherUseCase,
    required GetCachedWeatherUseCase getCachedWeatherUseCase,
  })  : _getWeatherUseCase = getWeatherUseCase,
        _getCachedWeatherUseCase = getCachedWeatherUseCase,
        super(const WeatherInitial()) {
    on<WeatherFetched>(_onWeatherFetched);
    on<WeatherCacheLoaded>(_onWeatherCacheLoaded);
    on<WeatherRefreshed>(_onWeatherRefreshed);
  }

  Future<void> _onWeatherFetched(
    WeatherFetched event,
    Emitter<WeatherState> emit,
  ) async {
    emit(const WeatherLoading());
    
    final result = await _getWeatherUseCase(event.city);
    
    result.fold(
      (failure) => emit(WeatherError(failure.message)),
      (weather) => emit(WeatherLoaded(weather: weather)),
    );
  }

  Future<void> _onWeatherCacheLoaded(
    WeatherCacheLoaded event,
    Emitter<WeatherState> emit,
  ) async {
    emit(const WeatherLoading());
    
    final result = await _getCachedWeatherUseCase();
    
    result.fold(
      (failure) => emit(const WeatherInitial()),
      (weather) {
        if (weather != null) {
          emit(WeatherLoaded(weather: weather, isFromCache: true));
        } else {
          emit(const WeatherInitial());
        }
      },
    );
  }

  Future<void> _onWeatherRefreshed(
    WeatherRefreshed event,
    Emitter<WeatherState> emit,
  ) async {
    final currentState = state;
    if (currentState is WeatherLoaded) {
      emit(const WeatherLoading());
      
      final result = await _getWeatherUseCase(currentState.weather.city);
      
      result.fold(
        (failure) => emit(WeatherError(failure.message)),
        (weather) => emit(WeatherLoaded(weather: weather)),
      );
    }
  }
}
