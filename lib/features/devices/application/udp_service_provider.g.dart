// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'udp_service_provider.dart';

// **************************************************************************
// RiverpodGenerator
// **************************************************************************

// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint, type=warning

@ProviderFor(udpService)
const udpServiceProvider = UdpServiceProvider._();

final class UdpServiceProvider
    extends
        $FunctionalProvider<
          DeviceUdpService,
          DeviceUdpService,
          DeviceUdpService
        >
    with $Provider<DeviceUdpService> {
  const UdpServiceProvider._()
    : super(
        from: null,
        argument: null,
        retry: null,
        name: r'udpServiceProvider',
        isAutoDispose: true,
        dependencies: null,
        $allTransitiveDependencies: null,
      );

  @override
  String debugGetCreateSourceHash() => _$udpServiceHash();

  @$internal
  @override
  $ProviderElement<DeviceUdpService> $createElement($ProviderPointer pointer) =>
      $ProviderElement(pointer);

  @override
  DeviceUdpService create(Ref ref) {
    return udpService(ref);
  }

  /// {@macro riverpod.override_with_value}
  Override overrideWithValue(DeviceUdpService value) {
    return $ProviderOverride(
      origin: this,
      providerOverride: $SyncValueProvider<DeviceUdpService>(value),
    );
  }
}

String _$udpServiceHash() => r'5f6ab52725c49c4b019c03e1694a818cfd2d440d';

@ProviderFor(DeviceDiscovery)
const deviceDiscoveryProvider = DeviceDiscoveryProvider._();

final class DeviceDiscoveryProvider
    extends $NotifierProvider<DeviceDiscovery, List<UdpDevice>> {
  const DeviceDiscoveryProvider._()
    : super(
        from: null,
        argument: null,
        retry: null,
        name: r'deviceDiscoveryProvider',
        isAutoDispose: true,
        dependencies: null,
        $allTransitiveDependencies: null,
      );

  @override
  String debugGetCreateSourceHash() => _$deviceDiscoveryHash();

  @$internal
  @override
  DeviceDiscovery create() => DeviceDiscovery();

  /// {@macro riverpod.override_with_value}
  Override overrideWithValue(List<UdpDevice> value) {
    return $ProviderOverride(
      origin: this,
      providerOverride: $SyncValueProvider<List<UdpDevice>>(value),
    );
  }
}

String _$deviceDiscoveryHash() => r'accef6ece63ab0e61d6be0310dcea4d0e6e09c1e';

abstract class _$DeviceDiscovery extends $Notifier<List<UdpDevice>> {
  List<UdpDevice> build();
  @$mustCallSuper
  @override
  void runBuild() {
    final created = build();
    final ref = this.ref as $Ref<List<UdpDevice>, List<UdpDevice>>;
    final element =
        ref.element
            as $ClassProviderElement<
              AnyNotifier<List<UdpDevice>, List<UdpDevice>>,
              List<UdpDevice>,
              Object?,
              Object?
            >;
    element.handleValue(ref, created);
  }
}

@ProviderFor(DiscoveryLoadingState)
const discoveryLoadingStateProvider = DiscoveryLoadingStateProvider._();

final class DiscoveryLoadingStateProvider
    extends $NotifierProvider<DiscoveryLoadingState, bool> {
  const DiscoveryLoadingStateProvider._()
    : super(
        from: null,
        argument: null,
        retry: null,
        name: r'discoveryLoadingStateProvider',
        isAutoDispose: true,
        dependencies: null,
        $allTransitiveDependencies: null,
      );

  @override
  String debugGetCreateSourceHash() => _$discoveryLoadingStateHash();

  @$internal
  @override
  DiscoveryLoadingState create() => DiscoveryLoadingState();

  /// {@macro riverpod.override_with_value}
  Override overrideWithValue(bool value) {
    return $ProviderOverride(
      origin: this,
      providerOverride: $SyncValueProvider<bool>(value),
    );
  }
}

String _$discoveryLoadingStateHash() =>
    r'0e21e75bca706f0bc06af0cd4e0d2e3be2075221';

abstract class _$DiscoveryLoadingState extends $Notifier<bool> {
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

@ProviderFor(ReloadAttempts)
const reloadAttemptsProvider = ReloadAttemptsProvider._();

final class ReloadAttemptsProvider
    extends $NotifierProvider<ReloadAttempts, int> {
  const ReloadAttemptsProvider._()
    : super(
        from: null,
        argument: null,
        retry: null,
        name: r'reloadAttemptsProvider',
        isAutoDispose: true,
        dependencies: null,
        $allTransitiveDependencies: null,
      );

  @override
  String debugGetCreateSourceHash() => _$reloadAttemptsHash();

  @$internal
  @override
  ReloadAttempts create() => ReloadAttempts();

  /// {@macro riverpod.override_with_value}
  Override overrideWithValue(int value) {
    return $ProviderOverride(
      origin: this,
      providerOverride: $SyncValueProvider<int>(value),
    );
  }
}

String _$reloadAttemptsHash() => r'd52a44dcd20ce27a472db870d3323565c39eede9';

abstract class _$ReloadAttempts extends $Notifier<int> {
  int build();
  @$mustCallSuper
  @override
  void runBuild() {
    final created = build();
    final ref = this.ref as $Ref<int, int>;
    final element =
        ref.element
            as $ClassProviderElement<
              AnyNotifier<int, int>,
              int,
              Object?,
              Object?
            >;
    element.handleValue(ref, created);
  }
}
