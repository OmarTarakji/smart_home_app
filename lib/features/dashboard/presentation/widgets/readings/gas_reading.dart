import 'package:flutter/material.dart';
import 'package:smart_home/core/theme/app_colors.dart';

class GasReading extends StatelessWidget {
  const GasReading({super.key, required this.value, this.fontSize});

  final String value;
  final double? fontSize;

  (String, Color) get properties {
    int reading = int.parse(value);
    return (reading < 2100)
        ? ('Safe', AppColors.safe)
        : (reading < 2600)
        ? ('Warning', AppColors.warning)
        : ('Critical', AppColors.danger);
  }

  @override
  Widget build(BuildContext context) {
    final (String text, Color color) = properties;

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
