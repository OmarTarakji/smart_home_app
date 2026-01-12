import 'package:riverpod_annotation/riverpod_annotation.dart';
import 'package:smart_home/features/dashboard/application/readings_provider.dart';

import '../models/reading.dart';

part 'chart_providers.g.dart';

@riverpod
Future<List<AvgComponentReading>> dayReadingsAvg(Ref ref, int id) async {
  final repo = ref.watch(readingsRepositoryProvider);
  final date = ref.watch(chartDateProvider);
  return repo.fetchDayReadingsAvg(id, date);
}

@riverpod
Future<List<ComponentReadingCount>> hourlyReadingsCount(Ref ref, int id) async {
  final repo = ref.watch(readingsRepositoryProvider);
  final date = ref.watch(chartDateProvider);
  return repo.fetchHourlyReadingsCount(id, date);
}

@riverpod
class ChartDate extends _$ChartDate {
  @override
  DateTime build() {
    final now = DateTime.now();
    return DateTime(now.year, now.month, now.day);
  }

  void previousDay() => state = state.subtract(const Duration(days: 1));

  void nextDay() => state = state.add(const Duration(days: 1));
}
