// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'component_provider.dart';

// **************************************************************************
// RiverpodGenerator
// **************************************************************************

// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint, type=warning

@ProviderFor(component)
const componentProvider = ComponentFamily._();

final class ComponentProvider
    extends
        $FunctionalProvider<
          AsyncValue<Component>,
          Component,
          FutureOr<Component>
        >
    with $FutureModifier<Component>, $FutureProvider<Component> {
  const ComponentProvider._({
    required ComponentFamily super.from,
    required int super.argument,
  }) : super(
         retry: null,
         name: r'componentProvider',
         isAutoDispose: true,
         dependencies: null,
         $allTransitiveDependencies: null,
       );

  @override
  String debugGetCreateSourceHash() => _$componentHash();

  @override
  String toString() {
    return r'componentProvider'
        ''
        '($argument)';
  }

  @$internal
  @override
  $FutureProviderElement<Component> $createElement($ProviderPointer pointer) =>
      $FutureProviderElement(pointer);

  @override
  FutureOr<Component> create(Ref ref) {
    final argument = this.argument as int;
    return component(ref, argument);
  }

  @override
  bool operator ==(Object other) {
    return other is ComponentProvider && other.argument == argument;
  }

  @override
  int get hashCode {
    return argument.hashCode;
  }
}

String _$componentHash() => r'a1b2291ad513b9ebbd7cc753c02b6808fa031092';

final class ComponentFamily extends $Family
    with $FunctionalFamilyOverride<FutureOr<Component>, int> {
  const ComponentFamily._()
    : super(
        retry: null,
        name: r'componentProvider',
        dependencies: null,
        $allTransitiveDependencies: null,
        isAutoDispose: true,
      );

  ComponentProvider call(int id) =>
      ComponentProvider._(argument: id, from: this);

  @override
  String toString() => r'componentProvider';
}
