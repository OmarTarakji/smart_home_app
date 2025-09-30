// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'room_providers.dart';

// **************************************************************************
// RiverpodGenerator
// **************************************************************************

// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint, type=warning

@ProviderFor(roomComponents)
const roomComponentsProvider = RoomComponentsFamily._();

final class RoomComponentsProvider
    extends
        $FunctionalProvider<
          AsyncValue<List<Component>>,
          List<Component>,
          FutureOr<List<Component>>
        >
    with $FutureModifier<List<Component>>, $FutureProvider<List<Component>> {
  const RoomComponentsProvider._({
    required RoomComponentsFamily super.from,
    required int super.argument,
  }) : super(
         retry: null,
         name: r'roomComponentsProvider',
         isAutoDispose: true,
         dependencies: null,
         $allTransitiveDependencies: null,
       );

  @override
  String debugGetCreateSourceHash() => _$roomComponentsHash();

  @override
  String toString() {
    return r'roomComponentsProvider'
        ''
        '($argument)';
  }

  @$internal
  @override
  $FutureProviderElement<List<Component>> $createElement(
    $ProviderPointer pointer,
  ) => $FutureProviderElement(pointer);

  @override
  FutureOr<List<Component>> create(Ref ref) {
    final argument = this.argument as int;
    return roomComponents(ref, argument);
  }

  @override
  bool operator ==(Object other) {
    return other is RoomComponentsProvider && other.argument == argument;
  }

  @override
  int get hashCode {
    return argument.hashCode;
  }
}

String _$roomComponentsHash() => r'79145290b1988e3b333dad9ec07ee78ab0b781c2';

final class RoomComponentsFamily extends $Family
    with $FunctionalFamilyOverride<FutureOr<List<Component>>, int> {
  const RoomComponentsFamily._()
    : super(
        retry: null,
        name: r'roomComponentsProvider',
        dependencies: null,
        $allTransitiveDependencies: null,
        isAutoDispose: true,
      );

  RoomComponentsProvider call(int roomId) =>
      RoomComponentsProvider._(argument: roomId, from: this);

  @override
  String toString() => r'roomComponentsProvider';
}

@ProviderFor(FilteredComponentsNotifier)
const filteredComponentsProvider = FilteredComponentsNotifierFamily._();

final class FilteredComponentsNotifierProvider
    extends
        $AsyncNotifierProvider<FilteredComponentsNotifier, FilteredComponents> {
  const FilteredComponentsNotifierProvider._({
    required FilteredComponentsNotifierFamily super.from,
    required int super.argument,
  }) : super(
         retry: null,
         name: r'filteredComponentsProvider',
         isAutoDispose: true,
         dependencies: null,
         $allTransitiveDependencies: null,
       );

  @override
  String debugGetCreateSourceHash() => _$filteredComponentsNotifierHash();

  @override
  String toString() {
    return r'filteredComponentsProvider'
        ''
        '($argument)';
  }

  @$internal
  @override
  FilteredComponentsNotifier create() => FilteredComponentsNotifier();

  @override
  bool operator ==(Object other) {
    return other is FilteredComponentsNotifierProvider &&
        other.argument == argument;
  }

  @override
  int get hashCode {
    return argument.hashCode;
  }
}

String _$filteredComponentsNotifierHash() =>
    r'6ed429cbc682b8730561880b4b65741dfb83faa8';

final class FilteredComponentsNotifierFamily extends $Family
    with
        $ClassFamilyOverride<
          FilteredComponentsNotifier,
          AsyncValue<FilteredComponents>,
          FilteredComponents,
          FutureOr<FilteredComponents>,
          int
        > {
  const FilteredComponentsNotifierFamily._()
    : super(
        retry: null,
        name: r'filteredComponentsProvider',
        dependencies: null,
        $allTransitiveDependencies: null,
        isAutoDispose: true,
      );

  FilteredComponentsNotifierProvider call(int roomId) =>
      FilteredComponentsNotifierProvider._(argument: roomId, from: this);

  @override
  String toString() => r'filteredComponentsProvider';
}

abstract class _$FilteredComponentsNotifier
    extends $AsyncNotifier<FilteredComponents> {
  late final _$args = ref.$arg as int;
  int get roomId => _$args;

  FutureOr<FilteredComponents> build(int roomId);
  @$mustCallSuper
  @override
  void runBuild() {
    final created = build(_$args);
    final ref =
        this.ref as $Ref<AsyncValue<FilteredComponents>, FilteredComponents>;
    final element =
        ref.element
            as $ClassProviderElement<
              AnyNotifier<AsyncValue<FilteredComponents>, FilteredComponents>,
              AsyncValue<FilteredComponents>,
              Object?,
              Object?
            >;
    element.handleValue(ref, created);
  }
}
