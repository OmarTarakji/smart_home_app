// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'components_provider.dart';

// **************************************************************************
// RiverpodGenerator
// **************************************************************************

// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint, type=warning

@ProviderFor(componentsByRoom)
const componentsByRoomProvider = ComponentsByRoomProvider._();

final class ComponentsByRoomProvider
    extends
        $FunctionalProvider<
          AsyncValue<Map<Room?, List<Component>>>,
          Map<Room?, List<Component>>,
          FutureOr<Map<Room?, List<Component>>>
        >
    with
        $FutureModifier<Map<Room?, List<Component>>>,
        $FutureProvider<Map<Room?, List<Component>>> {
  const ComponentsByRoomProvider._()
    : super(
        from: null,
        argument: null,
        retry: null,
        name: r'componentsByRoomProvider',
        isAutoDispose: true,
        dependencies: null,
        $allTransitiveDependencies: null,
      );

  @override
  String debugGetCreateSourceHash() => _$componentsByRoomHash();

  @$internal
  @override
  $FutureProviderElement<Map<Room?, List<Component>>> $createElement(
    $ProviderPointer pointer,
  ) => $FutureProviderElement(pointer);

  @override
  FutureOr<Map<Room?, List<Component>>> create(Ref ref) {
    return componentsByRoom(ref);
  }
}

String _$componentsByRoomHash() => r'72da2ff10a565400b684478b9f23273e328e4802';
