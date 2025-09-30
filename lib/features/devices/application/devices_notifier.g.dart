// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'devices_notifier.dart';

// **************************************************************************
// RiverpodGenerator
// **************************************************************************

// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint, type=warning

@ProviderFor(devicesRepository)
const devicesRepositoryProvider = DevicesRepositoryProvider._();

final class DevicesRepositoryProvider
    extends
        $FunctionalProvider<
          DevicesRepository,
          DevicesRepository,
          DevicesRepository
        >
    with $Provider<DevicesRepository> {
  const DevicesRepositoryProvider._()
    : super(
        from: null,
        argument: null,
        retry: null,
        name: r'devicesRepositoryProvider',
        isAutoDispose: true,
        dependencies: null,
        $allTransitiveDependencies: null,
      );

  @override
  String debugGetCreateSourceHash() => _$devicesRepositoryHash();

  @$internal
  @override
  $ProviderElement<DevicesRepository> $createElement(
    $ProviderPointer pointer,
  ) => $ProviderElement(pointer);

  @override
  DevicesRepository create(Ref ref) {
    return devicesRepository(ref);
  }

  /// {@macro riverpod.override_with_value}
  Override overrideWithValue(DevicesRepository value) {
    return $ProviderOverride(
      origin: this,
      providerOverride: $SyncValueProvider<DevicesRepository>(value),
    );
  }
}

String _$devicesRepositoryHash() => r'007838cb09aaae7375d7aacb6c95de769af046e0';

@ProviderFor(DevicesNotifier)
const devicesProvider = DevicesNotifierProvider._();

final class DevicesNotifierProvider
    extends $AsyncNotifierProvider<DevicesNotifier, List<Device>> {
  const DevicesNotifierProvider._()
    : super(
        from: null,
        argument: null,
        retry: null,
        name: r'devicesProvider',
        isAutoDispose: true,
        dependencies: null,
        $allTransitiveDependencies: null,
      );

  @override
  String debugGetCreateSourceHash() => _$devicesNotifierHash();

  @$internal
  @override
  DevicesNotifier create() => DevicesNotifier();
}

String _$devicesNotifierHash() => r'ad22c5c0a2359f467e667e28b9a0574df214d990';

abstract class _$DevicesNotifier extends $AsyncNotifier<List<Device>> {
  FutureOr<List<Device>> build();
  @$mustCallSuper
  @override
  void runBuild() {
    final created = build();
    final ref = this.ref as $Ref<AsyncValue<List<Device>>, List<Device>>;
    final element =
        ref.element
            as $ClassProviderElement<
              AnyNotifier<AsyncValue<List<Device>>, List<Device>>,
              AsyncValue<List<Device>>,
              Object?,
              Object?
            >;
    element.handleValue(ref, created);
  }
}

@ProviderFor(LinkDeviceInProgress)
const linkDeviceInProgressProvider = LinkDeviceInProgressProvider._();

final class LinkDeviceInProgressProvider
    extends $NotifierProvider<LinkDeviceInProgress, bool> {
  const LinkDeviceInProgressProvider._()
    : super(
        from: null,
        argument: null,
        retry: null,
        name: r'linkDeviceInProgressProvider',
        isAutoDispose: true,
        dependencies: null,
        $allTransitiveDependencies: null,
      );

  @override
  String debugGetCreateSourceHash() => _$linkDeviceInProgressHash();

  @$internal
  @override
  LinkDeviceInProgress create() => LinkDeviceInProgress();

  /// {@macro riverpod.override_with_value}
  Override overrideWithValue(bool value) {
    return $ProviderOverride(
      origin: this,
      providerOverride: $SyncValueProvider<bool>(value),
    );
  }
}

String _$linkDeviceInProgressHash() =>
    r'bacbb1ec327b9434d55b13c5a65467e9d3e5cdc7';

abstract class _$LinkDeviceInProgress extends $Notifier<bool> {
  bool build();
  @$mustCallSuper
  @override
  void runBuild() {
    final created = build();
    final ref = this.ref as $Ref<bool, bool>;
    final element =
        ref.element
            as $ClassProviderElement<
              AnyNotifier<bool, bool>,
              bool,
              Object?,
              Object?
            >;
    element.handleValue(ref, created);
  }
}
