import 'package:go_router/go_router.dart';
import 'package:weatherly/src/routing/global_navigator.dart';
import 'package:weatherly/src/routing/app_routes.dart';

import 'package:weatherly/src/features/onboarding/presentation/screens/onboarding_page.dart';
import 'package:weatherly/src/features/weather/presentation/screens/weather_page.dart';


final GoRouter appRouter = GoRouter(
  navigatorKey: rootNavigatorKey,
  initialLocation: AppRoutes.onboarding,
  routes: <RouteBase>[
    GoRoute(
      path: AppRoutes.onboarding,
      name: 'onboarding',
      builder: (context, state) => const OnboardingPage(),
    ),
    GoRoute(
      path: AppRoutes.weather,
      name: 'weather',
      builder: (context, state) => const WeatherPage(),
    ),
  ],
);
