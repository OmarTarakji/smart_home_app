// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'readings_provider.dart';

// **************************************************************************
// RiverpodGenerator
// **************************************************************************

// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint, type=warning
/// Returns the latest reading for the given component.
/// if value is loading return ComponentReading.loading()

@ProviderFor(componentReading)
const componentReadingProvider = ComponentReadingFamily._();

/// Returns the latest reading for the given component.
/// if value is loading return ComponentReading.loading()

final class ComponentReadingProvider
    extends
        $FunctionalProvider<
          ComponentReading?,
          ComponentReading?,
          ComponentReading?
        >
    with $Provider<ComponentReading?> {
  /// Returns the latest reading for the given component.
  /// if value is loading return ComponentReading.loading()
  const ComponentReadingProvider._({
    required ComponentReadingFamily super.from,
    required int super.argument,
  }) : super(
         retry: null,
         name: r'componentReadingProvider',
         isAutoDispose: true,
         dependencies: null,
         $allTransitiveDependencies: null,
       );

  @override
  String debugGetCreateSourceHash() => _$componentReadingHash();

  @override
  String toString() {
    return r'componentReadingProvider'
        ''
        '($argument)';
  }

  @$internal
  @override
  $ProviderElement<ComponentReading?> $createElement(
    $ProviderPointer pointer,
  ) => $ProviderElement(pointer);

  @override
  ComponentReading? create(Ref ref) {
    final argument = this.argument as int;
    return componentReading(ref, argument);
  }

  /// {@macro riverpod.override_with_value}
  Override overrideWithValue(ComponentReading? value) {
    return $ProviderOverride(
      origin: this,
      providerOverride: $SyncValueProvider<ComponentReading?>(value),
    );
  }

  @override
  bool operator ==(Object other) {
    return other is ComponentReadingProvider && other.argument == argument;
  }

  @override
  int get hashCode {
    return argument.hashCode;
  }
}

String _$componentReadingHash() => r'0f3360aae9b8c064c676c49407bcc574bbcb8c1d';

/// Returns the latest reading for the given component.
/// if value is loading return ComponentReading.loading()

final class ComponentReadingFamily extends $Family
    with $FunctionalFamilyOverride<ComponentReading?, int> {
  const ComponentReadingFamily._()
    : super(
        retry: null,
        name: r'componentReadingProvider',
        dependencies: null,
        $allTransitiveDependencies: null,
        isAutoDispose: true,
      );

  /// Returns the latest reading for the given component.
  /// if value is loading return ComponentReading.loading()

  ComponentReadingProvider call(int componentId) =>
      ComponentReadingProvider._(argument: componentId, from: this);

  @override
  String toString() => r'componentReadingProvider';
}

@ProviderFor(readingsRepository)
const readingsRepositoryProvider = ReadingsRepositoryProvider._();

final class ReadingsRepositoryProvider
    extends
        $FunctionalProvider<
          ReadingsRepository,
          ReadingsRepository,
          ReadingsRepository
        >
    with $Provider<ReadingsRepository> {
  const ReadingsRepositoryProvider._()
    : super(
        from: null,
        argument: null,
        retry: null,
        name: r'readingsRepositoryProvider',
        isAutoDispose: true,
        dependencies: null,
        $allTransitiveDependencies: null,
      );

  @override
  String debugGetCreateSourceHash() => _$readingsRepositoryHash();

  @$internal
  @override
  $ProviderElement<ReadingsRepository> $createElement(
    $ProviderPointer pointer,
  ) => $ProviderElement(pointer);

  @override
  ReadingsRepository create(Ref ref) {
    return readingsRepository(ref);
  }

  /// {@macro riverpod.override_with_value}
  Override overrideWithValue(ReadingsRepository value) {
    return $ProviderOverride(
      origin: this,
      providerOverride: $SyncValueProvider<ReadingsRepository>(value),
    );
  }
}

String _$readingsRepositoryHash() =>
    r'bf9f3cea7f7c545cf38ea2b472c1675c476b27b3';

@ProviderFor(ReadingsNotifier)
const readingsProvider = ReadingsNotifierProvider._();

final class ReadingsNotifierProvider
    extends $NotifierProvider<ReadingsNotifier, ComponentReadings> {
  const ReadingsNotifierProvider._()
    : super(
        from: null,
        argument: null,
        retry: null,
        name: r'readingsProvider',
        isAutoDispose: true,
        dependencies: null,
        $allTransitiveDependencies: null,
      );

  @override
  String debugGetCreateSourceHash() => _$readingsNotifierHash();

  @$internal
  @override
  ReadingsNotifier create() => ReadingsNotifier();

  /// {@macro riverpod.override_with_value}
  Override overrideWithValue(ComponentReadings value) {
    return $ProviderOverride(
      origin: this,
      providerOverride: $SyncValueProvider<ComponentReadings>(value),
    );
  }
}

String _$readingsNotifierHash() => r'028e3d5b19c30655caaa59ecbf865ca4996fed84';

abstract class _$ReadingsNotifier extends $Notifier<ComponentReadings> {
  ComponentReadings build();
  @$mustCallSuper
  @override
  void runBuild() {
    final created = build();
    final ref = this.ref as $Ref<ComponentReadings, ComponentReadings>;
    final element =
        ref.element
            as $ClassProviderElement<
              AnyNotifier<ComponentReadings, ComponentReadings>,
              ComponentReadings,
              Object?,
              Object?
            >;
    element.handleValue(ref, created);
  }
}
