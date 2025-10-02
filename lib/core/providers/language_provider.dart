import 'dart:io';
import 'dart:ui';

import 'package:intl/date_symbol_data_local.dart';
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
    initializeDateFormatting(languageCode, null);
    return Locale(languageCode);
  }

  void selectLanguage(String languageCode) async {
    if (state.languageCode == languageCode) return;
    ref.read(sharedPreferencesProvider).set('language', languageCode);
    await initializeDateFormatting(languageCode, null);
    state = Locale(languageCode);
  }
}
