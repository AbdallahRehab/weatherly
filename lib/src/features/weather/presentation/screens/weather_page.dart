import 'package:weatherly/src/imports/core_imports.dart';
import 'package:weatherly/src/imports/packages_imports.dart';
import 'package:weatherly/src/features/weather/presentation/bloc/weather_bloc.dart';
import 'package:weatherly/src/features/weather/presentation/bloc/weather_event.dart';
import 'package:weatherly/src/features/weather/presentation/bloc/weather_state.dart';
import 'package:weatherly/src/features/weather/presentation/widgets/weather_card.dart';
import 'package:weatherly/src/shared/helpers/weather_theme_helper.dart';

/// Weather search screen
class WeatherPage extends HookWidget {
  const WeatherPage({super.key});

  @override
  Widget build(BuildContext context) {
    final theme = context.theme;
    final colorScheme = theme.colorScheme;
    final textTheme = theme.textTheme;

    final cityController = useTextEditingController();
    final focusNode = useFocusNode();
    final isFocused = useState(false);

    // Get current weather description for gradient
    final currentWeather = context.select<WeatherBloc, WeatherState?>(
      (bloc) => bloc.state,
    );
    
    String weatherDescription = '';
    if (currentWeather is WeatherLoaded) {
      weatherDescription = currentWeather.weather.description;
    }

    return Scaffold(
      body: DecoratedBox(
        decoration: BoxDecoration(
          gradient: WeatherThemeHelper.getWeatherGradient(weatherDescription),
        ),
        child: SafeArea(
          child: CustomScrollView(
            slivers: [
              SliverToBoxAdapter(
                child: Padding(
                  padding: EdgeInsets.all(AppSpacing.xl.w),
                  child: Column(
                    children: [
                      // App bar
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Text(
                            'weather.app_title'.tr(),
                            style: textTheme.headlineMedium?.copyWith(
                              color: Colors.white,
                              fontWeight: FontWeight.bold,
                            ),
                          ).animate().fadeIn(duration: const Duration(milliseconds: 600)).slideX(begin: -0.3, end: 0, curve: Curves.easeOutCubic),
                          // Language switch button
                          IconButton(
                            onPressed: () {
                              final currentLocale = context.locale;
                              final newLocale = currentLocale.languageCode == 'en'
                                  ? const Locale('ar')
                                  : const Locale('en');
                              context.setLocale(newLocale);
                            },
                            icon: Container(
                              padding: EdgeInsets.symmetric(horizontal: 12.w, vertical: 6.h),
                              decoration: BoxDecoration(
                                color: Colors.white.withValues(alpha: 0.2),
                                borderRadius: BorderRadius.circular(20.r),
                                border: Border.all(
                                  color: Colors.white.withValues(alpha: 0.3),
                                ),
                              ),
                              child: Text(
                                context.locale.languageCode == 'en' ? 'ع' : 'EN',
                                style: textTheme.labelMedium?.copyWith(
                                  color: Colors.white,
                                  fontWeight: FontWeight.bold,
                                ),
                              ),
                            ),
                          ),
                        ],
                      ),
                      SizedBox(height: AppSpacing.xl.h),
                      
                      // Search field with focus animation
                      AnimatedContainer(
                        duration: const Duration(milliseconds: 200),
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(16.r),
                          boxShadow: isFocused.value
                              ? [
                                  BoxShadow(
                                    color: Colors.white.withValues(alpha: 0.3),
                                    blurRadius: 20,
                                    offset: const Offset(0, 4),
                                  ),
                                ]
                              : [],
                        ),
                        child: TextField(
                          controller: cityController,
                          focusNode: focusNode,
                          textInputAction: TextInputAction.search,
                          onTap: () => isFocused.value = true,
                          onTapOutside: (_) {
                            focusNode.unfocus();
                            isFocused.value = false;
                          },
                          decoration: InputDecoration(
                            hintText: 'weather.search_hint'.tr(),
                            hintStyle: TextStyle(color: Colors.white.withValues(alpha: 0.7)),
                            prefixIcon: Icon(
                              Icons.search_rounded,
                              color: Colors.white.withValues(alpha: 0.8),
                            ),
                            suffixIcon: IconButton(
                              icon: Icon(
                                Icons.clear_rounded,
                                color: Colors.white.withValues(alpha: 0.8),
                              ),
                              onPressed: () => cityController.clear(),
                            ),
                            border: OutlineInputBorder(
                              borderRadius: BorderRadius.circular(16.r),
                              borderSide: BorderSide.none,
                            ),
                            filled: true,
                            fillColor: Colors.white.withValues(alpha: 0.2),
                            contentPadding: EdgeInsets.symmetric(
                              horizontal: AppSpacing.lg.w,
                              vertical: AppSpacing.md.h,
                            ),
                          ),
                          onSubmitted: (value) {
                            focusNode.unfocus();
                            isFocused.value = false;
                            if (value.trim().isNotEmpty) {
                              context.read<WeatherBloc>().add(WeatherFetched(value.trim()));
                            }
                          },
                        ),
                      ).animate().fadeIn(duration: const Duration(milliseconds: 600), delay: const Duration(milliseconds: 100)).slideY(begin: -0.2, end: 0, curve: Curves.easeOutCubic),
                      SizedBox(height: AppSpacing.lg.h),

                      // Search button with scale animation
                      SizedBox(
                        width: double.infinity,
                        height: 50.h,
                        child: ElevatedButton.icon(
                          onPressed: () {
                            focusNode.unfocus();
                            isFocused.value = false;
                            final city = cityController.text.trim();
                            if (city.isNotEmpty) {
                              context.read<WeatherBloc>().add(WeatherFetched(city));
                            }
                          },
                          icon: Icon(Icons.search_rounded, size: 20.sp),
                          label: Text(
                            'weather.search_button'.tr(),
                            style: TextStyle(fontSize: 16.sp),
                          ),
                          style: ElevatedButton.styleFrom(
                            backgroundColor: Colors.white,
                            foregroundColor: const Color(0xFF2196F3),
                            shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(12.r),
                            ),
                            elevation: 8,
                          ),
                        ).animate().fadeIn(duration: const Duration(milliseconds: 600), delay: const Duration(milliseconds: 300)).slideY(begin: 0.3, end: 0, curve: Curves.easeOutCubic).then().scale(
                          duration: const Duration(milliseconds: 300),
                          curve: Curves.easeInOut,
                          begin: const Offset(1, 1),
                          end: const Offset(1.05, 1.05),
                        ).animate(onPlay: (controller) => controller.repeat(reverse: true)),
                      ),
                      SizedBox(height: AppSpacing.xl.h),
                    ],
                  ),
                ),
              ),
              
              // Weather content with pull-to-refresh
              BlocBuilder<WeatherBloc, WeatherState>(
                builder: (context, state) {
                  return SliverFillRemaining(
                    hasScrollBody: false,
                    child: RefreshIndicator(
                      onRefresh: () async {
                        if (state is WeatherLoaded) {
                          context.read<WeatherBloc>().add(WeatherFetched(state.weather.city));
                        }
                      },
                      color: Colors.white,
                      backgroundColor: Colors.transparent,
                      child: Padding(
                        padding: EdgeInsets.symmetric(horizontal: AppSpacing.xl.w),
                        child: _buildWeatherContent(context, state, colorScheme, textTheme),
                      ),
                    ),
                  );
                },
              ),
            ],
          ),
        ),
      ),
      resizeToAvoidBottomInset: true,
    );
  }

  Widget _buildWeatherContent(
    BuildContext context,
    WeatherState state,
    ColorScheme colorScheme,
    TextTheme textTheme,
  ) {
    if (state is WeatherLoading) {
      return SizedBox(
        height: MediaQuery.of(context).size.height * 0.4,
        child: Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Skeletonizer(
                enabled: true,
                child: Container(
                  width: 200.w,
                  height: 200.h,
                  decoration: BoxDecoration(
                    color: Colors.white.withValues(alpha: 0.3),
                    borderRadius: BorderRadius.circular(20.r),
                  ),
                ).animate().scale(duration: const Duration(milliseconds: 1000), curve: Curves.easeInOut, begin: const Offset(0.8, 0.8), end: const Offset(1, 1)).then().shake(duration: const Duration(milliseconds: 500), hz: 2),
              ),
              SizedBox(height: AppSpacing.md.h),
              Text(
                'weather.loading'.tr(),
                style: textTheme.bodyMedium?.copyWith(
                  color: Colors.white,
                ),
              ).animate().fadeIn(duration: const Duration(milliseconds: 800), delay: const Duration(milliseconds: 200)),
            ],
          ),
        ),
      );
    } else if (state is WeatherLoaded) {
      return Column(
        children: [
          WeatherCard(
            weather: state.weather,
            isFromCache: state.isFromCache,
          ).animate().fadeIn(duration: const Duration(milliseconds: 800)).slideY(begin: 0.4, end: 0, curve: Curves.easeOutExpo),
          if (state.isFromCache) ...[
            SizedBox(height: AppSpacing.lg.h),
            Container(
              padding: EdgeInsets.symmetric(horizontal: 16.w, vertical: 8.h),
              decoration: BoxDecoration(
                color: Colors.white.withValues(alpha: 0.2),
                borderRadius: BorderRadius.circular(12.r),
              ),
              child: Row(
                mainAxisSize: MainAxisSize.min,
                children: [
                  Icon(
                    Icons.cloud_off_rounded,
                    size: 16.sp,
                    color: Colors.white,
                  ),
                  SizedBox(width: 8.w),
                  Text(
                    'weather.cached_warning'.tr(),
                    textAlign: TextAlign.center,
                    style: textTheme.bodySmall?.copyWith(
                      color: Colors.white,
                    ),
                  ),
                ],
              ),
            ).animate().fadeIn(duration: const Duration(milliseconds: 600), delay: const Duration(milliseconds: 400)).slideY(begin: 0.2, end: 0),
          ],
        ],
      );
    } else if (state is WeatherError) {
      return SizedBox(
        height: MediaQuery.of(context).size.height * 0.4,
        child: Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Icon(
                Icons.error_outline_rounded,
                size: 64.sp,
                color: Colors.white,
              ).animate().scale(duration: const Duration(milliseconds: 600), curve: Curves.elasticOut, begin: Offset.zero, end: const Offset(1, 1)).then().shake(duration: const Duration(milliseconds: 800), hz: 3),
              SizedBox(height: AppSpacing.md.h),
              Text(
                state.message.tr(),
                textAlign: TextAlign.center,
                style: textTheme.bodyLarge?.copyWith(
                  color: Colors.white,
                ),
              ).animate().fadeIn(duration: const Duration(milliseconds: 600), delay: const Duration(milliseconds: 300)).slideY(begin: 0.3, end: 0),
            ],
          ),
        ),
      );
    } else {
      return SizedBox(
        height: MediaQuery.of(context).size.height * 0.4,
        child: Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Icon(
                Icons.cloud_queue_rounded,
                size: 64.sp,
                color: Colors.white.withValues(alpha: 0.8),
              ).animate().fadeIn(duration: const Duration(milliseconds: 800)).scale(duration: const Duration(milliseconds: 800), curve: Curves.easeOutBack, begin: const Offset(0.5, 0.5), end: const Offset(1, 1)),
              SizedBox(height: AppSpacing.md.h),
              Text(
                'weather.empty_state'.tr(),
                textAlign: TextAlign.center,
                style: textTheme.bodyLarge?.copyWith(
                  color: Colors.white,
                ),
              ).animate().fadeIn(duration: const Duration(milliseconds: 600), delay: const Duration(milliseconds: 200)),
            ],
          ),
        ),
      );
    }
  }
}
