import 'package:weatherly/src/imports/imports.dart';

class OnboardingPage extends HookWidget {
  const OnboardingPage({super.key});

  @override
  Widget build(BuildContext context) {
    final theme = context.theme;
    final colorScheme = theme.colorScheme;
    final textTheme = theme.textTheme;

    final pageController = usePageController();
    final currentIndex = useState(0);

    final List<Map<String, dynamic>> onboardingData = useMemoized(() => [
      {
        'title': 'Real-Time Weather',
        'subtitle':
            'Get instant weather information for any city worldwide. Stay prepared with accurate temperature, conditions, and forecasts.',
        'pageWidget': _buildWeatherIllustration(colorScheme, 0),
      },
      {
        'title': 'Simple Search',
        'subtitle':
            'Just enter a city name and get detailed weather data. No complicated setup - fast, easy, and reliable information at your fingertips.',
        'pageWidget': _buildWeatherIllustration(colorScheme, 1),
      },
      {
        'title': 'Offline Access',
        'subtitle':
            'Weather data is automatically cached for offline viewing. Check the weather even without an internet connection.',
        'pageWidget': _buildWeatherIllustration(colorScheme, 2),
      },
    ]);

    void onGetStarted() {
      // Navigate to weather page
      context.go(AppRoutes.weather);
    }

    return _OnboardingView(
      theme: theme,
      colorScheme: colorScheme,
      textTheme: textTheme,
      pageController: pageController,
      currentIndex: currentIndex.value,
      onboardingData: onboardingData,
      onPageChanged: (index) => currentIndex.value = index,
      onGetStarted: onGetStarted,
    );
  }
}

class _OnboardingView extends StatelessWidget {
  const _OnboardingView({
    required this.theme,
    required this.colorScheme,
    required this.textTheme,
    required this.pageController,
    required this.currentIndex,
    required this.onboardingData,
    required this.onPageChanged,
    required this.onGetStarted,
  });

  final ThemeData theme;
  final ColorScheme colorScheme;
  final TextTheme textTheme;
  final PageController pageController;
  final int currentIndex;
  final List<Map<String, dynamic>> onboardingData;
  final ValueChanged<int> onPageChanged;
  final VoidCallback onGetStarted;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: colorScheme.surface,
      body: SafeArea(
        child: Column(
          children: [
            // Top branding
            Padding(
              padding: EdgeInsets.only(
                top: AppSpacing.lg.h,
                bottom: AppSpacing.md.h,
              ),
              child: Text(
                'Weatherly',
                style: textTheme.titleLarge?.copyWith(
                  fontWeight: FontWeight.w900,
                  color: colorScheme.onSurface,
                  fontSize: 22.sp,
                ),
              ),
            ),

            // PageView
            Expanded(
              child: PageView.builder(
                controller: pageController,
                itemCount: onboardingData.length,
                onPageChanged: onPageChanged,
                itemBuilder: (context, index) {
                  return Column(
                    children: [
                      // Dynamic Illustration Section
                      Expanded(
                        child: Center(
                          child: Padding(
                            padding: EdgeInsets.symmetric(
                              horizontal: AppSpacing.lg.w,
                            ),
                            child: onboardingData[index]['pageWidget'] as Widget,
                          ),
                        ),
                      ),
                      
                      // Text Section
                      Padding(
                        padding: EdgeInsets.symmetric(
                          horizontal: AppSpacing.xl.w,
                        ),
                        child: Column(
                          children: [
                            Text(
                              onboardingData[index]['title'] as String,
                              textAlign: TextAlign.center,
                              style: textTheme.headlineMedium?.copyWith(
                                fontWeight: FontWeight.w700,
                                color: colorScheme.onSurface,
                                height: 1.2,
                                fontSize: 24.sp,
                              ),
                            ),
                            SizedBox(height: AppSpacing.md.h),
                            Text(
                              onboardingData[index]['subtitle'] as String,
                              textAlign: TextAlign.center,
                              style: textTheme.bodyMedium?.copyWith(
                                color: colorScheme.onSurfaceVariant,
                                height: 1.5,
                                fontSize: 14.sp,
                              ),
                            ),
                          ],
                        ),
                      ),
                      SizedBox(height: 40.h),
                    ],
                  );
                },
              ),
            ),

            // Bottom Section: Dots and Button
            Padding(
              padding: EdgeInsets.all(AppSpacing.xl.w),
              child: Column(
                children: [
                   SizedBox(height: AppSpacing.xl),
                  // Get Started Button
                  AppButton(
                    label: 'shared.get_started'.tr(),
                    onPressed: onGetStarted,
                    variant: ButtonVariant.primary,
                    width: ButtonSize.medium,
                  ),
                  SizedBox(height: AppSpacing.md),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}

Widget _buildWeatherIllustration(ColorScheme colorScheme, int index) {
  switch (index) {
    case 0:
      return Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Icon(
            Icons.wb_sunny_rounded,
            size: 120.sp,
            color: colorScheme.primary,
          ),
          SizedBox(height: 20.h),
          Icon(
            Icons.cloud_rounded,
            size: 80.sp,
            color: colorScheme.onSurfaceVariant,
          ),
        ],
      );
    case 1:
      return Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Icon(
            Icons.search_rounded,
            size: 100.sp,
            color: colorScheme.primary,
          ),
          SizedBox(height: 30.h),
          Container(
            padding: EdgeInsets.symmetric(horizontal: 24.w, vertical: 16.h),
            decoration: BoxDecoration(
              color: colorScheme.surfaceContainerHighest,
              borderRadius: BorderRadius.circular(16.r),
            ),
            child: Row(
              mainAxisSize: MainAxisSize.min,
              children: [
                Icon(
                  Icons.location_city_rounded,
                  color: colorScheme.onSurfaceVariant,
                  size: 24.sp,
                ),
                SizedBox(width: 12.w),
                Text(
                  'New York',
                  style: TextStyle(
                    color: colorScheme.onSurface,
                    fontSize: 18.sp,
                  ),
                ),
              ],
            ),
          ),
        ],
      );
    case 2:
      return Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Icon(
            Icons.cloud_off_rounded,
            size: 100.sp,
            color: colorScheme.primary,
          ),
          SizedBox(height: 20.h),
          Icon(
            Icons.storage_rounded,
            size: 80.sp,
            color: colorScheme.onSurfaceVariant,
          ),
        ],
      );
    default:
      return const SizedBox();
  }
}
