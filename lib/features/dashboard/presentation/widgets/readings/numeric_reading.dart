import 'package:flutter/material.dart';
import 'package:smart_home/core/utils/extensions.dart';
import 'package:smart_home/features/dashboard/models/reading.dart';

class NumericReading extends StatelessWidget {
  final double? fontSize;
  final double value;
  final DateTime timestamp;
  final String unit;
  NumericReading({
    required ComponentReading reading,
    required this.unit,
    this.fontSize,
    super.key,
  }) : value = double.parse(reading.value),
       timestamp = reading.timestamp;

  @override
  Widget build(BuildContext context) {
    return Text(
      '$value$unit',
      style: Theme.of(context).textTheme.displaySmall!.copyWith(
        fontSize: fontSize,
        color: context.colorScheme.primary,
        fontWeight: FontWeight.bold,
      ),
    );
  }
}
