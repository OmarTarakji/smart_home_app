import 'dart:convert';

import 'package:riverpod_annotation/riverpod_annotation.dart';
import 'package:smart_home/core/providers/providers.dart';

import '../../models/dashboard_state.dart';
import '../../models/data_state.dart';

part 'dashboard_state_indicator_provider.g.dart';

@riverpod
class ReadingsState extends _$ReadingsState {
  @override
  DataState build() {
    return DataState.syncing;
  }

  void update(DataState newState) {
    state = newState;
  }
}
