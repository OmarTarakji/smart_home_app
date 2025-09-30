import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';
import 'package:smart_home/features/dashboard/data/flame_activity_repository.dart';
import 'package:smart_home/features/dashboard/domain/reading.dart';

part 'flame_activity_provider.g.dart';

@riverpod
Future<List<ComponentReading>> flameActivity(Ref ref, int componentId) async {
  final repo = FlameActivityRepository();

  final readings = await repo.fetch(componentId);
  return readings;
}
