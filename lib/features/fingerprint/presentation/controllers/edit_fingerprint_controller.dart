import 'package:flutter/foundation.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';

part 'edit_fingerprint_controller.g.dart';

@riverpod
class EditingFingerprintState extends _$EditingFingerprintState {
  @override
  String? build() => null;

  void setState(String? value) {
    debugPrint('LOG: fingerprint state: $value');
    state = value;
  }
}
