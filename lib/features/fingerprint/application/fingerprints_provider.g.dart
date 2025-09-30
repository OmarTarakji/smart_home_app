// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'fingerprints_provider.dart';

// **************************************************************************
// RiverpodGenerator
// **************************************************************************

// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint, type=warning

@ProviderFor(fpUdpService)
const fpUdpServiceProvider = FpUdpServiceProvider._();

final class FpUdpServiceProvider
    extends
        $FunctionalProvider<
          FingerprintUdpService,
          FingerprintUdpService,
          FingerprintUdpService
        >
    with $Provider<FingerprintUdpService> {
  const FpUdpServiceProvider._()
    : super(
        from: null,
        argument: null,
        retry: null,
        name: r'fpUdpServiceProvider',
        isAutoDispose: true,
        dependencies: null,
        $allTransitiveDependencies: null,
      );

  @override
  String debugGetCreateSourceHash() => _$fpUdpServiceHash();

  @$internal
  @override
  $ProviderElement<FingerprintUdpService> $createElement(
    $ProviderPointer pointer,
  ) => $ProviderElement(pointer);

  @override
  FingerprintUdpService create(Ref ref) {
    return fpUdpService(ref);
  }

  /// {@macro riverpod.override_with_value}
  Override overrideWithValue(FingerprintUdpService value) {
    return $ProviderOverride(
      origin: this,
      providerOverride: $SyncValueProvider<FingerprintUdpService>(value),
    );
  }
}

String _$fpUdpServiceHash() => r'ecf729178c4dda98b96c72d1534e0bcbd32f6c7b';

@ProviderFor(fingerprintsRepository)
const fingerprintsRepositoryProvider = FingerprintsRepositoryProvider._();

final class FingerprintsRepositoryProvider
    extends
        $FunctionalProvider<
          FingerprintsRepository,
          FingerprintsRepository,
          FingerprintsRepository
        >
    with $Provider<FingerprintsRepository> {
  const FingerprintsRepositoryProvider._()
    : super(
        from: null,
        argument: null,
        retry: null,
        name: r'fingerprintsRepositoryProvider',
        isAutoDispose: true,
        dependencies: null,
        $allTransitiveDependencies: null,
      );

  @override
  String debugGetCreateSourceHash() => _$fingerprintsRepositoryHash();

  @$internal
  @override
  $ProviderElement<FingerprintsRepository> $createElement(
    $ProviderPointer pointer,
  ) => $ProviderElement(pointer);

  @override
  FingerprintsRepository create(Ref ref) {
    return fingerprintsRepository(ref);
  }

  /// {@macro riverpod.override_with_value}
  Override overrideWithValue(FingerprintsRepository value) {
    return $ProviderOverride(
      origin: this,
      providerOverride: $SyncValueProvider<FingerprintsRepository>(value),
    );
  }
}

String _$fingerprintsRepositoryHash() =>
    r'47030dffcf774e2a3da4f27849ffa38ee558ea4a';

@ProviderFor(ComponentFingerprintsNotifier)
const componentFingerprintsProvider = ComponentFingerprintsNotifierFamily._();

final class ComponentFingerprintsNotifierProvider
    extends
        $AsyncNotifierProvider<
          ComponentFingerprintsNotifier,
          List<Fingerprint>
        > {
  const ComponentFingerprintsNotifierProvider._({
    required ComponentFingerprintsNotifierFamily super.from,
    required int super.argument,
  }) : super(
         retry: null,
         name: r'componentFingerprintsProvider',
         isAutoDispose: true,
         dependencies: null,
         $allTransitiveDependencies: null,
       );

  @override
  String debugGetCreateSourceHash() => _$componentFingerprintsNotifierHash();

  @override
  String toString() {
    return r'componentFingerprintsProvider'
        ''
        '($argument)';
  }

  @$internal
  @override
  ComponentFingerprintsNotifier create() => ComponentFingerprintsNotifier();

  @override
  bool operator ==(Object other) {
    return other is ComponentFingerprintsNotifierProvider &&
        other.argument == argument;
  }

  @override
  int get hashCode {
    return argument.hashCode;
  }
}

String _$componentFingerprintsNotifierHash() =>
    r'ec1ebcd5d81dadff19a1f8f6a4d88b71dd876341';

final class ComponentFingerprintsNotifierFamily extends $Family
    with
        $ClassFamilyOverride<
          ComponentFingerprintsNotifier,
          AsyncValue<List<Fingerprint>>,
          List<Fingerprint>,
          FutureOr<List<Fingerprint>>,
          int
        > {
  const ComponentFingerprintsNotifierFamily._()
    : super(
        retry: null,
        name: r'componentFingerprintsProvider',
        dependencies: null,
        $allTransitiveDependencies: null,
        isAutoDispose: true,
      );

  ComponentFingerprintsNotifierProvider call(int componentId) =>
      ComponentFingerprintsNotifierProvider._(
        argument: componentId,
        from: this,
      );

  @override
  String toString() => r'componentFingerprintsProvider';
}

abstract class _$ComponentFingerprintsNotifier
    extends $AsyncNotifier<List<Fingerprint>> {
  late final _$args = ref.$arg as int;
  int get componentId => _$args;

  FutureOr<List<Fingerprint>> build(int componentId);
  @$mustCallSuper
  @override
  void runBuild() {
    final created = build(_$args);
    final ref =
        this.ref as $Ref<AsyncValue<List<Fingerprint>>, List<Fingerprint>>;
    final element =
        ref.element
            as $ClassProviderElement<
              AnyNotifier<AsyncValue<List<Fingerprint>>, List<Fingerprint>>,
              AsyncValue<List<Fingerprint>>,
              Object?,
              Object?
            >;
    element.handleValue(ref, created);
  }
}
