import 'package:fl_chart/fl_chart.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:smart_home/core/utils/extensions.dart';
import 'package:smart_home/core/widgets/error_screen.dart';

import '../../../application/chart_providers.dart';
import '../../../models/reading.dart';

class CountChart extends ConsumerWidget {
  const CountChart({super.key, required this.componentId});

  final int componentId;

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final readingsListAsync = ref.watch(
      hourlyReadingsCountProvider(componentId),
    );

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
                return _CountChart(data);
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
          const _ChartControls(),
        ],
      ),
    );
  }
}

class _ChartControls extends ConsumerWidget {
  const _ChartControls();

  @override
  Widget build(BuildContext context, WidgetRef ref) {
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

class _CountChart extends StatelessWidget {
  const _CountChart(this.readings);

  final List<ComponentReadingCount> readings;

  double get getMaxY {
    int max = 0;
    for (final reading in readings) {
      if (reading.value > max) max = reading.value;
    }
    final maxY = (max / 10.0).ceil() * 10.0;
    return maxY > 0 ? maxY : 10;
  }

  @override
  Widget build(BuildContext context) {
    debugPrint('LOG: $readings');
    return Padding(
      padding: const EdgeInsets.only(right: 24, left: 8, top: 12, bottom: 12),
      child: BarChart(
        BarChartData(
          barTouchData: BarTouchData(
            touchTooltipData: BarTouchTooltipData(
              getTooltipColor: (group) => context.colorScheme.surface,
              tooltipBorderRadius: BorderRadius.circular(10),
            ),
          ),
          gridData: _getGridData(context),
          titlesData: _getTitlesData(context),
          borderData: FlBorderData(
            show: false,
            border: Border.all(color: context.colorScheme.outline),
          ),
          alignment: BarChartAlignment.spaceAround,
          maxY: getMaxY,
          barGroups: _getBarGroups(context),
          groupsSpace: 12,
        ),
      ),
    );
  }

  Widget bottomTitleWidgets(double value, TitleMeta meta) {
    if (value % 3 == 0) {
      return SideTitleWidget(meta: meta, child: Text(value.toInt().toString()));
    }
    return const SizedBox.shrink();
  }

  List<BarChartGroupData> _getBarGroups(BuildContext context) {
    return readings.asMap().entries.map((entry) {
      final index = entry.key;
      final reading = entry.value;
      return BarChartGroupData(
        x: index,
        barRods: [
          BarChartRodData(
            toY: reading.value.toDouble(),
            gradient: LinearGradient(
              colors: [
                context.colorScheme.tertiary,
                context.colorScheme.primaryContainer,
              ],
              begin: AlignmentGeometry.topCenter,
              end: AlignmentGeometry.bottomCenter,
            ),
            width: 10,
            borderRadius: BorderRadius.circular(4),
          ),
        ],
      );
    }).toList();
  }

  FlTitlesData _getTitlesData(BuildContext context) {
    return FlTitlesData(
      show: true,
      rightTitles: const AxisTitles(sideTitles: SideTitles(showTitles: false)),
      topTitles: const AxisTitles(sideTitles: SideTitles(showTitles: false)),
      bottomTitles: AxisTitles(
        sideTitles: SideTitles(
          showTitles: true,
          reservedSize: 30,
          interval: 1,
          getTitlesWidget: bottomTitleWidgets,
        ),
      ),
      leftTitles: AxisTitles(
        sideTitles: SideTitles(
          showTitles: true,
          // interval: ,
          getTitlesWidget: (double value, TitleMeta meta) {
            if (value == 0 || value == getMaxY) return const SizedBox.shrink();
            return SideTitleWidget(
              meta: meta,
              child: Text(value.toInt().toString()),
            );
          },
          reservedSize: 34,
        ),
      ),
    );
  }

  FlGridData _getGridData(BuildContext context) {
    return FlGridData(
      show: true,
      drawVerticalLine: false,
      drawHorizontalLine: true,
      // horizontalInterval: getMaxY / 5,
      getDrawingHorizontalLine: (value) {
        return FlLine(
          color: context.colorScheme.outlineVariant,
          strokeWidth: 1,
        );
      },
    );
  }
}
