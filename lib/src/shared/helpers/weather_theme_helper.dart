import 'package:flutter/material.dart';

/// Helper class to generate dynamic color schemes based on weather conditions
class WeatherThemeHelper {
  /// Returns a gradient based on weather condition and time of day
  static LinearGradient getWeatherGradient(String description, {bool isNight = false}) {
    final lowerDesc = description.toLowerCase();
    
    if (isNight) {
      // Night time gradients
      if (lowerDesc.contains('clear') || lowerDesc.contains('sun')) {
        return const LinearGradient(
          begin: Alignment.topCenter,
          end: Alignment.bottomCenter,
          colors: [Color(0xFF1A1A2E), Color(0xFF16213E), Color(0xFF0F3460)],
        );
      } else if (lowerDesc.contains('cloud')) {
        return const LinearGradient(
          begin: Alignment.topCenter,
          end: Alignment.bottomCenter,
          colors: [Color(0xFF2C3E50), Color(0xFF34495E), Color(0xFF2C3E50)],
        );
      } else if (lowerDesc.contains('rain')) {
        return const LinearGradient(
          begin: Alignment.topCenter,
          end: Alignment.bottomCenter,
          colors: [Color(0xFF0D1B2A), Color(0xFF1B263B), Color(0xFF415A77)],
        );
      } else {
        return const LinearGradient(
          begin: Alignment.topCenter,
          end: Alignment.bottomCenter,
          colors: [Color(0xFF1A1A2E), Color(0xFF16213E), Color(0xFF0F3460)],
        );
      }
    } else {
      // Day time gradients
      if (lowerDesc.contains('sun') || lowerDesc.contains('clear')) {
        return const LinearGradient(
          begin: Alignment.topCenter,
          end: Alignment.bottomCenter,
          colors: [Color(0xFFFFB347), Color(0xFFFFCC33), Color(0xFFFFE5B4)],
        );
      } else if (lowerDesc.contains('cloud')) {
        return const LinearGradient(
          begin: Alignment.topCenter,
          end: Alignment.bottomCenter,
          colors: [Color(0xFFB0C4DE), Color(0xFF87CEEB), Color(0xFFE0F6FF)],
        );
      } else if (lowerDesc.contains('rain')) {
        return const LinearGradient(
          begin: Alignment.topCenter,
          end: Alignment.bottomCenter,
          colors: [Color(0xFF4A90A4), Color(0xFF5BA3C5), Color(0xFF7EC8E3)],
        );
      } else if (lowerDesc.contains('snow')) {
        return const LinearGradient(
          begin: Alignment.topCenter,
          end: Alignment.bottomCenter,
          colors: [Color(0xFFE8F4F8), Color(0xFFB8D4E3), Color(0xFF8FB8D0)],
        );
      } else if (lowerDesc.contains('storm') || lowerDesc.contains('thunder')) {
        return const LinearGradient(
          begin: Alignment.topCenter,
          end: Alignment.bottomCenter,
          colors: [Color(0xFF37474F), Color(0xFF455A64), Color(0xFF546E7A)],
        );
      } else {
        return const LinearGradient(
          begin: Alignment.topCenter,
          end: Alignment.bottomCenter,
          colors: [Color(0xFF87CEEB), Color(0xFFB0E0E6), Color(0xFFE0F7FA)],
        );
      }
    }
  }

  /// Returns a dynamic color scheme based on weather condition
  static ColorScheme getWeatherColorScheme(String description, {bool isNight = false}) {
    final lowerDesc = description.toLowerCase();
    
    if (isNight) {
      return const ColorScheme.dark(
        primary: Color(0xFFBB86FC),
        secondary: Color(0xFF03DAC6),
        surface: Color(0xFF1A1A2E),
        onSurface: Color(0xFFE0E0E0),
      );
    } else {
      if (lowerDesc.contains('sun') || lowerDesc.contains('clear')) {
        return const ColorScheme.light(
          primary: Color(0xFFFF9800),
          secondary: Color(0xFFFFC107),
          surface: Color(0xFFFFF8E1),
          onSurface: Color(0xFF212121),
        );
      } else if (lowerDesc.contains('cloud')) {
        return const ColorScheme.light(
          primary: Color(0xFF607D8B),
          secondary: Color(0xFF90A4AE),
          surface: Color(0xFFECEFF1),
          onSurface: Color(0xFF37474F),
        );
      } else if (lowerDesc.contains('rain')) {
        return const ColorScheme.light(
          primary: Color(0xFF2196F3),
          secondary: Color(0xFF03A9F4),
          surface: Color(0xFFE3F2FD),
          onSurface: Color(0xFF0D47A1),
        );
      } else if (lowerDesc.contains('snow')) {
        return const ColorScheme.light(
          primary: Color(0xFF90CAF9),
          secondary: Color(0xFFBBDEFB),
          surface: Color(0xFFFFFFFF),
          onSurface: Color(0xFF1565C0),
        );
      } else if (lowerDesc.contains('storm') || lowerDesc.contains('thunder')) {
        return const ColorScheme.light(
          primary: Color(0xFF455A64),
          secondary: Color(0xFF546E7A),
          surface: Color(0xFFCFD8DC),
          onSurface: Color(0xFF263238),
        );
      } else {
        return const ColorScheme.light(
          primary: Color(0xFF2196F3),
          secondary: Color(0xFF03A9F4),
          surface: Color(0xFFE3F2FD),
          onSurface: Color(0xFF0D47A1),
        );
      }
    }
  }

  /// Returns the appropriate Lottie animation file name based on weather condition
  static String getLottieAnimation(String description, {bool isNight = false}) {
    final lowerDesc = description.toLowerCase();
    
    if (isNight) {
      if (lowerDesc.contains('clear') || lowerDesc.contains('sun')) {
        return 'assets/animations/clear_night.json';
      } else if (lowerDesc.contains('cloud')) {
        return 'assets/animations/cloudy_night.json';
      } else if (lowerDesc.contains('rain')) {
        return 'assets/animations/rainy_night.json';
      } else {
        return 'assets/animations/clear_night.json';
      }
    } else {
      if (lowerDesc.contains('sun') || lowerDesc.contains('clear')) {
        return 'assets/animations/sunny.json';
      } else if (lowerDesc.contains('cloud')) {
        return 'assets/animations/cloudy.json';
      } else if (lowerDesc.contains('rain')) {
        return 'assets/animations/rainy.json';
      } else if (lowerDesc.contains('snow')) {
        return 'assets/animations/snowy.json';
      } else if (lowerDesc.contains('storm') || lowerDesc.contains('thunder')) {
        return 'assets/animations/storm.json';
      } else if (lowerDesc.contains('fog') || lowerDesc.contains('mist')) {
        return 'assets/animations/fog.json';
      } else {
        return 'assets/animations/sunny.json';
      }
    }
  }
}
