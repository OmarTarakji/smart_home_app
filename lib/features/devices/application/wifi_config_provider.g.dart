// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'wifi_config_provider.dart';

// **************************************************************************
// RiverpodGenerator
// **************************************************************************

// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint, type=warning

@ProviderFor(locationPermission)
const locationPermissionProvider = LocationPermissionProvider._();

final class LocationPermissionProvider
    extends $FunctionalProvider<AsyncValue<bool>, bool, FutureOr<bool>>
    with $FutureModifier<bool>, $FutureProvider<bool> {
  const LocationPermissionProvider._()
    : super(
        from: null,
        argument: null,
        retry: null,
        name: r'locationPermissionProvider',
        isAutoDispose: true,
        dependencies: null,
        $allTransitiveDependencies: null,
      );

  @override
  String debugGetCreateSourceHash() => _$locationPermissionHash();

  @$internal
  @override
  $FutureProviderElement<bool> $createElement($ProviderPointer pointer) =>
      $FutureProviderElement(pointer);

  @override
  FutureOr<bool> create(Ref ref) {
    return locationPermission(ref);
  }
}

String _$locationPermissionHash() =>
    r'be3b637fab8fde5c7e634c4e6d9a8f85bf5e5cd1';

@ProviderFor(NetworkNotifier)
const networkProvider = NetworkNotifierProvider._();

final class NetworkNotifierProvider
    extends $NotifierProvider<NetworkNotifier, WifiInfo> {
  const NetworkNotifierProvider._()
    : super(
        from: null,
        argument: null,
        retry: null,
        name: r'networkProvider',
        isAutoDispose: true,
        dependencies: null,
        $allTransitiveDependencies: null,
      );

  @override
  String debugGetCreateSourceHash() => _$networkNotifierHash();

  @$internal
  @override
  NetworkNotifier create() => NetworkNotifier();

  /// {@macro riverpod.override_with_value}
  Override overrideWithValue(WifiInfo value) {
    return $ProviderOverride(
      origin: this,
      providerOverride: $SyncValueProvider<WifiInfo>(value),
    );
  }
}

String _$networkNotifierHash() => r'cabdae91c2795fa8421328a5a9012071f208b8a7';

abstract class _$NetworkNotifier extends $Notifier<WifiInfo> {
  WifiInfo build();
  @$mustCallSuper
  @override
  void runBuild() {
    final created = build();
    final ref = this.ref as $Ref<WifiInfo, WifiInfo>;
    final element =
        ref.element
            as $ClassProviderElement<
              AnyNotifier<WifiInfo, WifiInfo>,
              WifiInfo,
              Object?,
              Object?
            >;
    element.handleValue(ref, created);
  }
}
