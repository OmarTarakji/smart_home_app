import 'package:flutter/material.dart';
import 'package:smart_home/core/theme/app_colors.dart';

class FlameSensorReading extends StatefulWidget {
  const FlameSensorReading({required this.timestamp, this.fontSize, super.key});

  final DateTime? timestamp;
  final double? fontSize;

  @override
  State<FlameSensorReading> createState() => _FlameSensorReadingState();
}

class _FlameSensorReadingState extends State<FlameSensorReading> {
  Future? future;

  @override
  Widget build(BuildContext context) {
    final (Color color, String text) = properties;

    return FittedBox(
      fit: BoxFit.scaleDown,
      alignment: AlignmentDirectional.centerEnd,
      child: Text(
        text,
        style: Theme.of(context).textTheme.headlineMedium!.copyWith(
          fontSize: widget.fontSize,
          color: color,
          fontWeight: FontWeight.bold,
        ),
      ),
    );
  }

  @override
  void dispose() {
    future?.ignore();
    super.dispose();
  }

  (Color, String) get properties {
    if (widget.timestamp == null || _isBefore(minutes: 10)) {
      return (AppColors.safe, 'Safe');
    } else if (_isBefore(minutes: 1)) {
      _scheduleRefresh(minutes: 10);
      return (AppColors.warning, 'Recent activity');
    } else {
      _scheduleRefresh(minutes: 1);
      return (AppColors.danger, 'Danger!');
    }
  }

  bool _isBefore({required int minutes}) => widget.timestamp!.isBefore(
    DateTime.now().subtract(Duration(minutes: minutes)),
  );

  ///Schedule a widget rebuild after the given minutes from the reading's timestamp
  void _scheduleRefresh({required int minutes}) {
    future = Future.delayed(
      widget.timestamp!
          .add(Duration(minutes: minutes))
          .difference(DateTime.now()),
    ).then((_) => setState(() {}));
  }
}
