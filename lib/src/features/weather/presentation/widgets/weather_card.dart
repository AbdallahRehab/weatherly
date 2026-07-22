import 'package:weatherly/src/imports/core_imports.dart';
import 'package:weatherly/src/imports/packages_imports.dart';
import 'package:weatherly/src/features/weather/domain/entities/weather.dart';
import 'package:weatherly/src/shared/helpers/weather_theme_helper.dart';
import 'package:lottie/lottie.dart';

/// Card widget to display weather information
class WeatherCard extends StatefulWidget {
  final Weather weather;
  final bool isFromCache;

  const WeatherCard({
    super.key,
    required this.weather,
    this.isFromCache = false,
  });

  @override
  State<WeatherCard> createState() => _WeatherCardState();
}

class _WeatherCardState extends State<WeatherCard> with SingleTickerProviderStateMixin {
  late AnimationController _controller;
  late Animation<double> _temperatureAnimation;

  @override
  void initState() {
    super.initState();
    _controller = AnimationController(
      duration: const Duration(milliseconds: 2000),
      vsync: this,
    );
    
    _temperatureAnimation = Tween<double>(
      begin: 0,
      end: widget.weather.temperature,
    ).animate(CurvedAnimation(
      parent: _controller,
      curve: const Interval(0, 1, curve: Curves.easeOutExpo),
    ));
    
    _controller.forward();
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final theme = context.theme;
    final textTheme = theme.textTheme;

    return Container(
      width: double.infinity,
      padding: EdgeInsets.all(AppSpacing.xl.w),
      decoration: BoxDecoration(
        color: Colors.white.withValues(alpha: 0.15),
        borderRadius: BorderRadius.circular(24.r),
        border: Border.all(
          color: Colors.white.withValues(alpha: 0.3),
          width: 1.5,
        ),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withValues(alpha: 0.1),
            blurRadius: 30,
            offset: const Offset(0, 15),
          ),
        ],
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          // City name and cache indicator
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Expanded(
                child: Text(
                  widget.weather.city,
                  style: textTheme.headlineMedium?.copyWith(
                    color: Colors.white,
                    fontWeight: FontWeight.w600,
                    fontSize: 28.sp,
                  ),
                ).animate().fadeIn(duration: const Duration(milliseconds: 600), delay: const Duration(milliseconds: 100)).slideX(begin: -0.3, end: 0, curve: Curves.easeOutCubic),
              ),
              if (widget.isFromCache)
                Container(
                  padding: EdgeInsets.symmetric(
                    horizontal: 12.w,
                    vertical: 6.h,
                  ),
                  decoration: BoxDecoration(
                    color: Colors.white.withValues(alpha: 0.25),
                    borderRadius: BorderRadius.circular(20.r),
                    border: Border.all(
                      color: Colors.white.withValues(alpha: 0.3),
                    ),
                  ),
                  child: Row(
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      Icon(
                        Icons.cloud_off_rounded,
                        size: 14.sp,
                        color: Colors.white,
                      ),
                      SizedBox(width: 6.w),
                      Text(
                        'weather.offline'.tr(),
                        style: textTheme.labelSmall?.copyWith(
                          color: Colors.white,
                          fontWeight: FontWeight.w500,
                        ),
                      ),
                    ],
                  ),
                ).animate().fadeIn(duration: const Duration(milliseconds: 600), delay: const Duration(milliseconds: 200)).scale(begin: const Offset(0.8, 0.8), end: const Offset(1, 1), curve: Curves.elasticOut),
            ],
          ),
          SizedBox(height: AppSpacing.xl.h),
          
          // Weather icon (Lottie animation) and temperature
          Row(
            children: [
              // Weather Lottie animation with animated icon fallback
              SizedBox(
                width: 60.w,
                height: 60.h,
                child: Lottie.asset(
                  WeatherThemeHelper.getLottieAnimation(widget.weather.description),
                  fit: BoxFit.contain,
                  errorBuilder: (context, error, stackTrace) {
                    return Icon(
                      _getWeatherIcon(widget.weather.description),
                      size: 60.sp,
                      color: Colors.white,
                    ).animate().scale(duration: const Duration(milliseconds: 800), delay: const Duration(milliseconds: 300), curve: Curves.elasticOut).fadeIn(duration: const Duration(milliseconds: 600));
                  },
                ),
              ),
              SizedBox(width: AppSpacing.xl.w),

              // Temperature with count-up animation
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    AnimatedBuilder(
                      animation: _temperatureAnimation,
                      builder: (context, child) {
                        return Text(
                          '${_temperatureAnimation.value.toStringAsFixed(1)}°C',
                          style: textTheme.displayLarge?.copyWith(
                            color: Colors.white,
                            fontWeight: FontWeight.bold,
                            fontSize: 38.sp,
                            height: 1,
                          ),
                          maxLines: 1,
                          overflow: TextOverflow.fade,
                        ).animate().fadeIn(duration: const Duration(milliseconds: 800), delay: const Duration(milliseconds: 400)).scale(begin: const Offset(0.5, 0.5), end: const Offset(1, 1), curve: Curves.elasticOut);
                      },
                    ),
                    SizedBox(height: 8.h),
                    Text(
                      widget.weather.description,
                      style: textTheme.titleMedium?.copyWith(
                        color: Colors.white.withValues(alpha: 0.9),
                        fontSize: 18.sp,
                        fontWeight: FontWeight.w400,
                      ),
                      overflow: TextOverflow.ellipsis,
                      maxLines: 2,
                    ).animate().fadeIn(duration: const Duration(milliseconds: 600), delay: const Duration(milliseconds: 500)).slideY(begin: 0.2, end: 0),
                  ],
                ),
              ),
            ],
          ),
          SizedBox(height: AppSpacing.xxl.h),
          
          // Additional details with glassmorphism - staggered animations
          Wrap(
            alignment: WrapAlignment.spaceAround,
            spacing: 8.w,
            runSpacing: 8.h,
            children: [
              Flexible(
                child: _buildDetailItem(
                  context,
                  Icons.thermostat_rounded,
                  'weather.feels_like'.tr(),
                  '${widget.weather.feelsLike.toStringAsFixed(1)}°C',
                ).animate().fadeIn(duration: const Duration(milliseconds: 600), delay: const Duration(milliseconds: 600)).slideY(begin: 0.3, end: 0, curve: Curves.easeOutCubic),
              ),
              Flexible(
                child: _buildDetailItem(
                  context,
                  Icons.water_drop_rounded,
                  'weather.humidity'.tr(),
                  '${widget.weather.humidity}%',
                ).animate().fadeIn(duration: const Duration(milliseconds: 600), delay: const Duration(milliseconds: 700)).slideY(begin: 0.3, end: 0, curve: Curves.easeOutCubic),
              ),
              Flexible(
                child: _buildDetailItem(
                  context,
                  Icons.air_rounded,
                  'weather.wind'.tr(),
                  '${widget.weather.windSpeed.toStringAsFixed(1)} km/h',
                ).animate().fadeIn(duration: const Duration(milliseconds: 600), delay: const Duration(milliseconds: 800)).slideY(begin: 0.3, end: 0, curve: Curves.easeOutCubic),
              ),
            ],
          ),
        ],
      ),
    ).animate().fadeIn(duration: const Duration(milliseconds: 400)).scale(begin: const Offset(0.9, 0.9), end: const Offset(1, 1), curve: Curves.easeOutCubic);
  }

  Widget _buildDetailItem(
    BuildContext context,
    IconData icon,
    String label,
    String value,
  ) {
    final theme = context.theme;
    final textTheme = theme.textTheme;

    return Container(
      padding: EdgeInsets.symmetric(horizontal: 16.w, vertical: 12.h),
      decoration: BoxDecoration(
        color: Colors.white.withValues(alpha: 0.1),
        borderRadius: BorderRadius.circular(16.r),
        border: Border.all(
          color: Colors.white.withValues(alpha: 0.2),
        ),
      ),
      child: Column(
        children: [
          Icon(
            icon,
            size: 28.sp,
            color: Colors.white,
          ),
          SizedBox(height: 8.h),
          Text(
            label,
            style: textTheme.labelSmall?.copyWith(
              color: Colors.white.withValues(alpha: 0.8),
              fontSize: 12.sp,
            ),
          ),
          SizedBox(height: 4.h),
          Text(
            value,
            style: textTheme.titleSmall?.copyWith(
              color: Colors.white,
              fontWeight: FontWeight.bold,
              fontSize: 16.sp,
            ),
          ),
        ],
      ),
    );
  }

  IconData _getWeatherIcon(String description) {
    final lowerDesc = description.toLowerCase();
    if (lowerDesc.contains('sun') || lowerDesc.contains('clear')) {
      return Icons.wb_sunny_rounded;
    } else if (lowerDesc.contains('cloud')) {
      return Icons.cloud_rounded;
    } else if (lowerDesc.contains('rain')) {
      return Icons.water_drop_rounded;
    } else if (lowerDesc.contains('snow')) {
      return Icons.ac_unit_rounded;
    } else if (lowerDesc.contains('storm') || lowerDesc.contains('thunder')) {
      return Icons.thunderstorm_rounded;
    } else if (lowerDesc.contains('fog') || lowerDesc.contains('mist')) {
      return Icons.cloud_rounded;
    }
    return Icons.cloud_rounded;
  }
}
