import 'package:flutter/material.dart';
import 'package:smart_home/core/theme/app_colors.dart';

import '../gradient_button.dart';

enum ToggleType {
  light('Off', [AppColors.off, AppColors.off], 'On', AppColors.yellowGradient),
  openable('Open', AppColors.darkTealGradient, 'Close', AppColors.redGradient),
  security('Off', AppColors.redGradient, 'On', AppColors.greenGradient);

  final String offText;
  final String onText;
  final List<Color> offColors;
  final List<Color> onColors;
  const ToggleType(this.offText, this.offColors, this.onText, this.onColors);
}

class ActuatorToggle extends StatelessWidget {
  final bool isOn;
  final ToggleType type;
  final VoidCallback? onToggle;
  final EdgeInsets? padding;

  ActuatorToggle({
    required String? value,
    required this.type,
    required this.onToggle,
    this.padding,
    super.key,
  }) : isOn = !(value == '0' || value == null || value.startsWith('-'));

  @override
  Widget build(BuildContext context) {
    return GradientButton(
      text: (isOn) ? type.onText : type.offText,
      onPressed: onToggle,
      gradientColors: (isOn) ? type.onColors : type.offColors,
      padding: padding,
    );
  }
}
