// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'language_provider.dart';

// **************************************************************************
// RiverpodGenerator
// **************************************************************************

// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint, type=warning

@ProviderFor(SelectedLanguage)
const selectedLanguageProvider = SelectedLanguageProvider._();

final class SelectedLanguageProvider
    extends $NotifierProvider<SelectedLanguage, Locale> {
  const SelectedLanguageProvider._()
    : super(
        from: null,
        argument: null,
        retry: null,
        name: r'selectedLanguageProvider',
        isAutoDispose: true,
        dependencies: null,
        $allTransitiveDependencies: null,
      );

  @override
  String debugGetCreateSourceHash() => _$selectedLanguageHash();

  @$internal
  @override
  SelectedLanguage create() => SelectedLanguage();

  /// {@macro riverpod.override_with_value}
  Override overrideWithValue(Locale value) {
    return $ProviderOverride(
      origin: this,
      providerOverride: $SyncValueProvider<Locale>(value),
    );
  }
}

String _$selectedLanguageHash() => r'710770c10fafcafa47f3c110a351445a2b06dbb9';

abstract class _$SelectedLanguage extends $Notifier<Locale> {
  Locale build();
  @$mustCallSuper
  @override
  void runBuild() {
    final created = build();
    final ref = this.ref as $Ref<Locale, Locale>;
    final element =
        ref.element
            as $ClassProviderElement<
              AnyNotifier<Locale, Locale>,
              Locale,
              Object?,
              Object?
            >;
    element.handleValue(ref, created);
  }
}
