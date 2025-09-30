// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'edit_fingerprint_controller.dart';

// **************************************************************************
// RiverpodGenerator
// **************************************************************************

// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint, type=warning

@ProviderFor(EditingFingerprintState)
const editingFingerprintStateProvider = EditingFingerprintStateProvider._();

final class EditingFingerprintStateProvider
    extends $NotifierProvider<EditingFingerprintState, String?> {
  const EditingFingerprintStateProvider._()
    : super(
        from: null,
        argument: null,
        retry: null,
        name: r'editingFingerprintStateProvider',
        isAutoDispose: true,
        dependencies: null,
        $allTransitiveDependencies: null,
      );

  @override
  String debugGetCreateSourceHash() => _$editingFingerprintStateHash();

  @$internal
  @override
  EditingFingerprintState create() => EditingFingerprintState();

  /// {@macro riverpod.override_with_value}
  Override overrideWithValue(String? value) {
    return $ProviderOverride(
      origin: this,
      providerOverride: $SyncValueProvider<String?>(value),
    );
  }
}

String _$editingFingerprintStateHash() =>
    r'94c2fe6e0971a27ea015b7f7285f6cff60d79018';

abstract class _$EditingFingerprintState extends $Notifier<String?> {
  String? build();
  @$mustCallSuper
  @override
  void runBuild() {
    final created = build();
    final ref = this.ref as $Ref<String?, String?>;
    final element =
        ref.element
            as $ClassProviderElement<
              AnyNotifier<String?, String?>,
              String?,
              Object?,
              Object?
            >;
    element.handleValue(ref, created);
  }
}
