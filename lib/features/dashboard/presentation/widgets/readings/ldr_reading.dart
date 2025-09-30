import 'package:flutter/material.dart';

class LDRReading extends StatelessWidget {
  const LDRReading({required this.value, this.fontSize, super.key});

  final String value;
  final double? fontSize;

  @override
  Widget build(BuildContext context) {
    final Color color;
    final String text;

    final int reading = int.parse(value);

    // Define gradients for light and dark modes
    const List<Color> lightModeGradient = [
      Color(0xFFFD7951), // Very bright
      Color(0xFFFFC343), // Bright
      Color(0xFFB5BF51), // Moderate
      Color(0xFF6E9C6C), // Low light
      Color(0xFF257889), // Dark
    ];

    const List<Color> darkModeGradient = [
      Color(0xffffab7a), // Very bright
      Color(0xFFffdc42), // Bright
      Color(0xFFf1ff6c), // Moderate
      Color(0xFFa3e8a0), // Low light
      Color(0xFF39bbd5), // Dark
    ];

    // Determine if the app is in dark mode
    final bool isDarkMode = Theme.of(context).brightness == Brightness.dark;

    // Select the appropriate gradient based on the theme
    final List<Color> currentGradient =
        isDarkMode ? darkModeGradient : lightModeGradient;

    switch (reading) {
      case > 3995:
        text = 'Very Bright';
        color = currentGradient[0];
      case > 2996:
        text = 'Bright';
        color = currentGradient[1];
      case > 2296:
        text = 'Moderate';
        color = currentGradient[2];
      case > 296:
        text = 'Low light';
        color = currentGradient[3];
      default:
        text = 'Dark';
        color = currentGradient[4];
    }

    return FittedBox(
      fit: BoxFit.scaleDown,
      child: Text(
        text,
        style: Theme.of(context).textTheme.headlineSmall!.copyWith(
          fontSize: fontSize,
          color: color,
          fontWeight: FontWeight.bold,
        ),
      ),
    );
  }
}
