import 'package:fl_chart/fl_chart.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:smart_home/core/l10n/app_localizations.dart';
import 'package:smart_home/core/utils/extensions.dart';
import 'package:smart_home/core/widgets/error_screen.dart';
import 'package:smart_home/features/dashboard/models/reading_unit.dart';

import '../../../application/chart_providers.dart';
import '../../../models/component.dart';
import '../../../models/reading.dart';

class NumericChart extends ConsumerWidget {
  const NumericChart({
    super.key,
    required this.component,
    required this.properties,
  });

  final Component component;
  final ReadingProperties properties;

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final readingsListAsync = ref.watch(dayReadingsAvgProvider(component.id));

    return Container(
      height: 280,
      decoration: BoxDecoration(
        color: context.colorScheme.secondaryContainer,
        borderRadius: BorderRadius.circular(28),
      ),
      child: Column(
        children: [
          Expanded(
            child: readingsListAsync.when(
              data: (data) {
                return _NumericChart(data, properties: properties);
              },
              error: (e, st) {
                return StyledError(
                  error: e,
                  stackTrace: st,
                  showLoadingIndicator: false,
                );
              },
              loading: () => const Center(child: CircularProgressIndicator()),
            ),
          ),
          _buildChartControls(context, ref),
        ],
      ),
    );
  }

  Widget _buildChartControls(BuildContext context, WidgetRef ref) {
    final notifier = ref.read(chartDateProvider.notifier);
    final date = ref.watch(chartDateProvider);

    final now = DateTime.now();
    final isToday = date == DateTime(now.year, now.month, now.day);

    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceAround,
      children: [
        IconButton(
          onPressed: notifier.previousDay,
          icon: const Icon(Icons.arrow_back_ios),
        ),
        Text(
          '${date.day}/${date.month}/${date.year}',
          style: TextStyle(
            fontWeight: FontWeight.bold,
            color: context.colorScheme.onSecondaryContainer,
          ),
        ),
        IconButton(
          onPressed: isToday ? null : notifier.nextDay,
          icon: const Icon(Icons.arrow_forward_ios),
        ),
      ],
    );
  }
}

class _NumericChart extends StatelessWidget {
  const _NumericChart(this.readings, {required this.properties});

  final List<AvgComponentReading> readings;
  final ReadingProperties properties;

  @override
  Widget build(BuildContext context) {
    debugPrint('LOG: $readings');
    final showUnit = properties.unit != null;
    // Wrap LineChart with Expanded to avoid unbounded height in Column
    return Padding(
      padding: EdgeInsets.only(
        right: 24,
        left: showUnit ? 8 : 24,
        top: showUnit ? 12 : 16,
        bottom: 12,
      ),
      child: LineChart(
        LineChartData(
          lineTouchData: LineTouchData(
            touchTooltipData: LineTouchTooltipData(
              getTooltipColor: (touchedSpot) => context.colorScheme.surface,
              tooltipBorderRadius: BorderRadius.circular(10),
            ),
          ),
          gridData: _getGridData(context),
          titlesData: _getTitlesData(context),
          borderData: FlBorderData(
            show: true,
            border: Border.all(color: context.colorScheme.outline),
          ),
          minX: 0,
          maxX: 24 * 60, // minutes per day
          minY: properties.min,
          maxY: properties.max,
          lineBarsData: [_getLineChartBarData(context)],
        ),
      ),
    );
  }

  Widget bottomTitleWidgets(
    double value,
    TitleMeta meta,
    AppLocalizations l10n,
  ) {
    final title = switch (value) {
      0.0 => l10n.morningHour('12'),
      360 => l10n.morningHour('6'),
      720 => l10n.eveningHour('12'),
      1080 => l10n.eveningHour('6'),
      1440 => l10n.eveningHour('12'),
      _ => null,
    };
    return title == null
        ? const SizedBox.shrink()
        : SideTitleWidget(meta: meta, child: Text(title));
  }

  LineChartBarData _getLineChartBarData(BuildContext context) {
    final List<FlSpot> spots = [];
    for (int i = 0; i < readings.length; i++) {
      // If the reading is too far from the previous one, add a null spot to break the line
      if (spots.isNotEmpty &&
          (readings[i].minute - spots.last.x > 60.0 /* 1 hour */ )) {
        spots.add(FlSpot.nullSpot);
      }

      if (readings[i].readingCount != 0) {
        spots.add(FlSpot(readings[i].minute + 15, readings[i].value));
      } else if (spots.isNotEmpty && spots.last != FlSpot.nullSpot) {
        // Add a null spot if there's a gap in readings
        spots.add(FlSpot.nullSpot);
      }
    }

    return LineChartBarData(
      preventCurveOverShooting: true,
      spots: spots,
      isCurved: true,
      color: context.colorScheme.tertiary,
      barWidth: 5,
      isStrokeCapRound: true,
      dotData: const FlDotData(show: false),
      belowBarData: BarAreaData(
        show: true,
        gradient: LinearGradient(
          colors: [
            context.colorScheme.tertiary.withAlpha(100),
            context.colorScheme.secondaryContainer.withAlpha(100),
          ],
          begin: Alignment.topCenter,
          end: Alignment.bottomCenter,
        ),
      ),
    );
  }

  FlTitlesData _getTitlesData(BuildContext context) {
    final l10n = AppLocalizations.of(context)!;
    return FlTitlesData(
      show: true,
      rightTitles: const AxisTitles(sideTitles: SideTitles(showTitles: false)),
      topTitles: AxisTitles(
        sideTitles: SideTitles(
          showTitles: properties.unit != null,
          reservedSize: 20,
          interval: 5000,
          maxIncluded: false,
          getTitlesWidget: (value, meta) => Text(
            properties.unit!,
            style: TextStyle(
              fontWeight: FontWeight.bold,
              color: context.colorScheme.primary,
            ),
          ),
        ),
      ),
      bottomTitles: AxisTitles(
        sideTitles: SideTitles(
          showTitles: true,
          reservedSize: 30,
          interval: 6 * 60,
          getTitlesWidget: (v, m) => bottomTitleWidgets(v, m, l10n),
        ),
      ),
      leftTitles: AxisTitles(
        sideTitles: SideTitles(
          showTitles: properties.unit != null,
          interval: properties.chartInterval,
          getTitlesWidget: (double value, TitleMeta meta) =>
              SideTitleWidget(meta: meta, child: Text('${value.toInt()}')),
          reservedSize: 34,
        ),
      ),
    );
  }

  FlGridData _getGridData(BuildContext context) {
    return FlGridData(
      show: true,
      drawVerticalLine: true,
      horizontalInterval: properties.chartInterval,
      verticalInterval: 60,
      getDrawingHorizontalLine: (value) {
        return FlLine(
          color: context.colorScheme.outlineVariant,
          strokeWidth: 1,
        );
      },
      getDrawingVerticalLine: (value) {
        return FlLine(
          color: context.colorScheme.outlineVariant,
          strokeWidth: 1,
        );
      },
    );
  }
}
