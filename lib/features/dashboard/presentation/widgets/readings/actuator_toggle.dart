import 'package:flutter/material.dart';
import 'package:smart_home/core/l10n/app_localizations.dart';
import 'package:smart_home/core/theme/app_colors.dart';

import '../gradient_button.dart';

enum ToggleType {
  light([AppColors.off, AppColors.off], AppColors.yellowGradient),
  openable(AppColors.darkTealGradient, AppColors.redGradient),
  security(AppColors.redGradient, AppColors.greenGradient);

  final List<Color> offColors;
  final List<Color> onColors;
  const ToggleType(this.offColors, this.onColors);

  String getOffText(AppLocalizations l10n) {
    switch (this) {
      case ToggleType.light:
        return l10n.toggleTypeLightOff;
      case ToggleType.openable:
        return l10n.toggleTypeOpenableOff;
      case ToggleType.security:
        return l10n.toggleSecurityOff;
    }
  }

  String getOnText(AppLocalizations l10n) {
    switch (this) {
      case ToggleType.light:
        return l10n.toggleTypeLightOn;
      case ToggleType.openable:
        return l10n.toggleTypeOpenableOn;
      case ToggleType.security:
        return l10n.toggleSecurityOn;
    }
  }
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
    final l10n = AppLocalizations.of(context)!;

    return GradientButton(
      text: (isOn) ? type.getOnText(l10n) : type.getOffText(l10n),
      onPressed: onToggle,
      gradientColors: (isOn) ? type.onColors : type.offColors,
      padding: padding,
    );
  }
}
