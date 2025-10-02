import 'package:flutter/material.dart';
import 'package:smart_home/core/l10n/app_localizations.dart';
import 'package:smart_home/core/theme/app_colors.dart';

class GasReading extends StatelessWidget {
  const GasReading({super.key, required this.value, this.fontSize});

  final String value;
  final double? fontSize;

  (String, Color) getProperties(AppLocalizations l10n) {
    int reading = int.parse(value);
    return (reading < 2100)
        ? (l10n.readingSafe, AppColors.safe)
        : (reading < 2600)
        ? (l10n.readingWarning, AppColors.warning)
        : (l10n.readingDanger, AppColors.danger);
  }

  @override
  Widget build(BuildContext context) {
    final l10n = AppLocalizations.of(context)!;
    final (String text, Color color) = getProperties(l10n);

    return Text(
      text,
      style: Theme.of(context).textTheme.headlineMedium!.copyWith(
        fontSize: fontSize,
        color: color,
        fontWeight: FontWeight.bold,
      ),
    );
  }
}
