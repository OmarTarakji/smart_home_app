import 'package:flutter/material.dart';
import 'package:smart_home/core/l10n/app_localizations.dart';
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
    final l10n = AppLocalizations.of(context)!;
    final old = isOld;
    return FittedBox(
      fit: BoxFit.scaleDown,
      child: Text(
        getText(l10n),
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

  String getText(AppLocalizations l10n) {
    if (_itsBeen(hours: 24)) {
      //Do not schedule for refresh
      final days = DateTime.now().difference(widget.timestamp).inDays;
      if (days == 1) return l10n.readingOneDayAgo; // '1 day ago'
      if (days == 2) return l10n.readingTwoDaysAgo;
      return l10n.readingDaysAgo(days); // '$days days ago'
    }
    if (_itsBeen(hours: 1)) {
      _scheduleRefresh(minutes: 60);
      final hours = DateTime.now().difference(widget.timestamp).inHours;
      if (hours == 1) return l10n.readingOneHourAgo; // '1 hour ago'
      return l10n.readingHoursAgo(hours); // '$hours hours ago'
    }
    _scheduleRefresh(minutes: 1);
    final minutes = DateTime.now().difference(widget.timestamp).inMinutes;
    if (minutes == 0) return l10n.readingNow; // 'Now'
    if (minutes == 1) return l10n.readingOneMinuteAgo; // 'Recently'
    if (minutes < 11) return l10n.readingMinutesAgoPlural(minutes);
    return l10n.readingMinutesAgo(minutes); // '$minutes minutes ago'
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
