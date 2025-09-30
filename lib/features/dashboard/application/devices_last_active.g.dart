// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'devices_last_active.dart';

// **************************************************************************
// RiverpodGenerator
// **************************************************************************

// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint, type=warning

@ProviderFor(DevicesLastActive)
const devicesLastActiveProvider = DevicesLastActiveProvider._();

final class DevicesLastActiveProvider
    extends $NotifierProvider<DevicesLastActive, Map<String, DateTime>> {
  const DevicesLastActiveProvider._()
    : super(
        from: null,
        argument: null,
        retry: null,
        name: r'devicesLastActiveProvider',
        isAutoDispose: true,
        dependencies: null,
        $allTransitiveDependencies: null,
      );

  @override
  String debugGetCreateSourceHash() => _$devicesLastActiveHash();

  @$internal
  @override
  DevicesLastActive create() => DevicesLastActive();

  /// {@macro riverpod.override_with_value}
  Override overrideWithValue(Map<String, DateTime> value) {
    return $ProviderOverride(
      origin: this,
      providerOverride: $SyncValueProvider<Map<String, DateTime>>(value),
    );
  }
}

String _$devicesLastActiveHash() => r'578dc5c45b3d9ec83166707583ca3e43033e70dd';

abstract class _$DevicesLastActive extends $Notifier<Map<String, DateTime>> {
  Map<String, DateTime> build();
  @$mustCallSuper
  @override
  void runBuild() {
    final created = build();
    final ref = this.ref as $Ref<Map<String, DateTime>, Map<String, DateTime>>;
    final element =
        ref.element
            as $ClassProviderElement<
              AnyNotifier<Map<String, DateTime>, Map<String, DateTime>>,
              Map<String, DateTime>,
              Object?,
              Object?
            >;
    element.handleValue(ref, created);
  }
}
