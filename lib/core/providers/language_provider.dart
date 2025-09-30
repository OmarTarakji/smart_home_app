import 'dart:io';
import 'dart:ui';

import 'package:riverpod_annotation/riverpod_annotation.dart';
import 'package:smart_home/core/providers/providers.dart';

part 'language_provider.g.dart';

@riverpod
class SelectedLanguage extends _$SelectedLanguage {
  @override
  Locale build() {
    final languageCode =
        ref.read(sharedPreferencesProvider).get('language') ??
        Platform.localeName.split('_')[0];
    return Locale(languageCode);
  }

  void selectLanguage(String languageCode) {
    if (state.languageCode == languageCode) return;
    ref.read(sharedPreferencesProvider).set('language', languageCode);
    state = Locale(languageCode);
  }
}
