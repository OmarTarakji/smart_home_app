import 'dart:convert';

import 'package:riverpod_annotation/riverpod_annotation.dart';
import 'package:smart_home/core/providers/providers.dart';

import '../../domain/dashboard_state.dart';
import '../../domain/data_state.dart';

part 'dashboard_screen_providers.g.dart';

@riverpod
class ReadingsState extends _$ReadingsState {
  @override
  DataState build() {
    return DataState.syncing;
  }

  //TODO: update on error
  void update(DataState newState) {
    state = newState;
  }
}

@riverpod
class DashboardStateNotifier extends _$DashboardStateNotifier {
  late final _prefs = ref.watch(sharedPreferencesProvider);

  @override
  DashboardState build() {
    final initialState = jsonDecode(_prefs.get('dashboard_state') ?? '{}');
    return DashboardState.fromJson(initialState);
  }

  void setState(DashboardState dashboardState) {
    state = dashboardState;
    _prefs.set('dashboard_state', state.toJson());
  }
}
