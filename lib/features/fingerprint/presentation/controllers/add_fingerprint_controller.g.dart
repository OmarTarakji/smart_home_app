// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'add_fingerprint_controller.dart';

// **************************************************************************
// RiverpodGenerator
// **************************************************************************

// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint, type=warning

@ProviderFor(AddFingerprintNotifier)
const addFingerprintProvider = AddFingerprintNotifierProvider._();

final class AddFingerprintNotifierProvider
    extends $NotifierProvider<AddFingerprintNotifier, AddFingerprintResponse> {
  const AddFingerprintNotifierProvider._()
    : super(
        from: null,
        argument: null,
        retry: null,
        name: r'addFingerprintProvider',
        isAutoDispose: true,
        dependencies: null,
        $allTransitiveDependencies: null,
      );

  @override
  String debugGetCreateSourceHash() => _$addFingerprintNotifierHash();

  @$internal
  @override
  AddFingerprintNotifier create() => AddFingerprintNotifier();

  /// {@macro riverpod.override_with_value}
  Override overrideWithValue(AddFingerprintResponse value) {
    return $ProviderOverride(
      origin: this,
      providerOverride: $SyncValueProvider<AddFingerprintResponse>(value),
    );
  }
}

String _$addFingerprintNotifierHash() =>
    r'8df8cd90e6f9f84fe38b29d69ea9ede60d80f0ae';

abstract class _$AddFingerprintNotifier
    extends $Notifier<AddFingerprintResponse> {
  AddFingerprintResponse build();
  @$mustCallSuper
  @override
  void runBuild() {
    final created = build();
    final ref =
        this.ref as $Ref<AddFingerprintResponse, AddFingerprintResponse>;
    final element =
        ref.element
            as $ClassProviderElement<
              AnyNotifier<AddFingerprintResponse, AddFingerprintResponse>,
              AddFingerprintResponse,
              Object?,
              Object?
            >;
    element.handleValue(ref, created);
  }
}
