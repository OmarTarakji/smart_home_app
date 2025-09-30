import 'package:flutter/material.dart';
import 'package:smart_home/core/utils/extensions.dart';

class PIRReading extends StatefulWidget {
  const PIRReading({required this.timestamp, this.fontSize, super.key});

  final DateTime timestamp;
  final double? fontSize;

  @override
  State<PIRReading> createState() => _PIRReadingState();
}

class _PIRReadingState extends State<PIRReading> {
  Future? future;

  @override
  Widget build(BuildContext context) {
    final old = isOld;
    return FittedBox(
      fit: BoxFit.scaleDown,
      child: Text(
        text,
        style: Theme.of(context).textTheme.headlineSmall!.copyWith(
          fontSize:
              old
                  ? widget.fontSize != null
                      ? widget.fontSize! - 10
                      : 18
                  : widget.fontSize,
          color:
              old ? context.colorScheme.outline : context.colorScheme.primary,
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

  String get text {
    if (_itsBeen(hours: 24)) {
      //Do not schedule for refresh
      final days = DateTime.now().difference(widget.timestamp).inDays;
      if (days == 1) return '1 day ago';
      return '$days days ago';
    }
    if (_itsBeen(hours: 1)) {
      _scheduleRefresh(minutes: 60);
      final hours = DateTime.now().difference(widget.timestamp).inHours;
      if (hours == 1) return '1 hour ago';
      return '$hours hours ago';
    }
    _scheduleRefresh(minutes: 1);
    final minutes = DateTime.now().difference(widget.timestamp).inMinutes;
    if (minutes == 0) return 'Just now';
    if (minutes == 1) return 'Recently';
    return '$minutes minutes ago';
  }

  bool get isOld => _itsBeen(minutes: 11) ? true : false;

  bool _itsBeen({int minutes = 0, int hours = 0}) => widget.timestamp.isBefore(
    DateTime.now().subtract(Duration(minutes: minutes, hours: hours)),
  );

  ///Schedule a widget rebuild after the given minutes from the reading's timestamp
  void _scheduleRefresh({required int minutes}) {
    future = Future.delayed(
      widget.timestamp
          .add(Duration(minutes: minutes))
          .difference(DateTime.now()),
    ).then((_) => setState(() {}));
  }
}
