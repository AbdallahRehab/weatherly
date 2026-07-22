import '../../imports/imports.dart';
import '../../features/weather/data/datasources/weather_local_datasource.dart';
import '../../features/weather/data/datasources/weather_remote_datasource.dart';
import '../../features/weather/data/repositories/weather_repository_impl.dart';
import '../../features/weather/domain/usecases/get_cached_weather_usecase.dart';
import '../../features/weather/domain/usecases/get_weather_usecase.dart';
import '../../features/weather/presentation/bloc/weather_bloc.dart';

/// A wrapper to initialize the chosen State Management library.
class StateWrapper extends StatelessWidget {
  final Widget child;

  const StateWrapper({
    super.key,
    required this.child,
  });

  @override
  Widget build(BuildContext context) {
    final weatherLocalDataSource = WeatherLocalDataSource();
    final weatherRemoteDataSource = WeatherRemoteDataSource(AppConfig.dio);
    final weatherRepository = WeatherRepositoryImpl(
      remoteDataSource: weatherRemoteDataSource,
      localDataSource: weatherLocalDataSource,
    );

    return MultiBlocProvider(
      providers: [
        BlocProvider<WeatherBloc>(
          create: (_) => WeatherBloc(
            getWeatherUseCase: GetWeatherUseCase(weatherRepository),
            getCachedWeatherUseCase: GetCachedWeatherUseCase(weatherRepository),
          ),
        ),
      ],
      child: child,
    );
  }
}
