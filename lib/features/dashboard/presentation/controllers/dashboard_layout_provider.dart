import 'dart:convert';

import 'package:riverpod_annotation/riverpod_annotation.dart';

import 'package:smart_home/core/providers/providers.dart';
import '../../models/dashboard_state.dart';

part 'dashboard_layout_provider.g.dart';

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
