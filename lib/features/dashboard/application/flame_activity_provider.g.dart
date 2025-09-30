// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'flame_activity_provider.dart';

// **************************************************************************
// RiverpodGenerator
// **************************************************************************

// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint, type=warning

@ProviderFor(flameActivity)
const flameActivityProvider = FlameActivityFamily._();

final class FlameActivityProvider
    extends
        $FunctionalProvider<
          AsyncValue<List<ComponentReading>>,
          List<ComponentReading>,
          FutureOr<List<ComponentReading>>
        >
    with
        $FutureModifier<List<ComponentReading>>,
        $FutureProvider<List<ComponentReading>> {
  const FlameActivityProvider._({
    required FlameActivityFamily super.from,
    required int super.argument,
  }) : super(
         retry: null,
         name: r'flameActivityProvider',
         isAutoDispose: true,
         dependencies: null,
         $allTransitiveDependencies: null,
       );

  @override
  String debugGetCreateSourceHash() => _$flameActivityHash();

  @override
  String toString() {
    return r'flameActivityProvider'
        ''
        '($argument)';
  }

  @$internal
  @override
  $FutureProviderElement<List<ComponentReading>> $createElement(
    $ProviderPointer pointer,
  ) => $FutureProviderElement(pointer);

  @override
  FutureOr<List<ComponentReading>> create(Ref ref) {
    final argument = this.argument as int;
    return flameActivity(ref, argument);
  }

  @override
  bool operator ==(Object other) {
    return other is FlameActivityProvider && other.argument == argument;
  }

  @override
  int get hashCode {
    return argument.hashCode;
  }
}

String _$flameActivityHash() => r'be9f54697103842f9905cbca1726ea6a5fc9a53b';

final class FlameActivityFamily extends $Family
    with $FunctionalFamilyOverride<FutureOr<List<ComponentReading>>, int> {
  const FlameActivityFamily._()
    : super(
        retry: null,
        name: r'flameActivityProvider',
        dependencies: null,
        $allTransitiveDependencies: null,
        isAutoDispose: true,
      );

  FlameActivityProvider call(int componentId) =>
      FlameActivityProvider._(argument: componentId, from: this);

  @override
  String toString() => r'flameActivityProvider';
}
