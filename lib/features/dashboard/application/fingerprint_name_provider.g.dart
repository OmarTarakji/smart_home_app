// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'fingerprint_name_provider.dart';

// **************************************************************************
// RiverpodGenerator
// **************************************************************************

// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint, type=warning

@ProviderFor(fingerprintNameOfId)
const fingerprintNameOfIdProvider = FingerprintNameOfIdFamily._();

final class FingerprintNameOfIdProvider
    extends $FunctionalProvider<AsyncValue<String>, String, FutureOr<String>>
    with $FutureModifier<String>, $FutureProvider<String> {
  const FingerprintNameOfIdProvider._({
    required FingerprintNameOfIdFamily super.from,
    required (int, int) super.argument,
  }) : super(
         retry: null,
         name: r'fingerprintNameOfIdProvider',
         isAutoDispose: true,
         dependencies: null,
         $allTransitiveDependencies: null,
       );

  @override
  String debugGetCreateSourceHash() => _$fingerprintNameOfIdHash();

  @override
  String toString() {
    return r'fingerprintNameOfIdProvider'
        ''
        '$argument';
  }

  @$internal
  @override
  $FutureProviderElement<String> $createElement($ProviderPointer pointer) =>
      $FutureProviderElement(pointer);

  @override
  FutureOr<String> create(Ref ref) {
    final argument = this.argument as (int, int);
    return fingerprintNameOfId(ref, argument.$1, argument.$2);
  }

  @override
  bool operator ==(Object other) {
    return other is FingerprintNameOfIdProvider && other.argument == argument;
  }

  @override
  int get hashCode {
    return argument.hashCode;
  }
}

String _$fingerprintNameOfIdHash() =>
    r'1d8d23aab49ce296a9cee317825a2b7fd14c05bb';

final class FingerprintNameOfIdFamily extends $Family
    with $FunctionalFamilyOverride<FutureOr<String>, (int, int)> {
  const FingerprintNameOfIdFamily._()
    : super(
        retry: null,
        name: r'fingerprintNameOfIdProvider',
        dependencies: null,
        $allTransitiveDependencies: null,
        isAutoDispose: true,
      );

  FingerprintNameOfIdProvider call(int scannerId, int id) =>
      FingerprintNameOfIdProvider._(argument: (scannerId, id), from: this);

  @override
  String toString() => r'fingerprintNameOfIdProvider';
}
