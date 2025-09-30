// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'rooms_provider.dart';

// **************************************************************************
// RiverpodGenerator
// **************************************************************************

// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint, type=warning

@ProviderFor(RoomsNotifier)
const roomsProvider = RoomsNotifierProvider._();

final class RoomsNotifierProvider
    extends $AsyncNotifierProvider<RoomsNotifier, Map<int, Room>> {
  const RoomsNotifierProvider._()
    : super(
        from: null,
        argument: null,
        retry: null,
        name: r'roomsProvider',
        isAutoDispose: true,
        dependencies: null,
        $allTransitiveDependencies: null,
      );

  @override
  String debugGetCreateSourceHash() => _$roomsNotifierHash();

  @$internal
  @override
  RoomsNotifier create() => RoomsNotifier();
}

String _$roomsNotifierHash() => r'eca37e48982d325ff8747cbdc1f7e1eb83b0508c';

abstract class _$RoomsNotifier extends $AsyncNotifier<Map<int, Room>> {
  FutureOr<Map<int, Room>> build();
  @$mustCallSuper
  @override
  void runBuild() {
    final created = build();
    final ref = this.ref as $Ref<AsyncValue<Map<int, Room>>, Map<int, Room>>;
    final element =
        ref.element
            as $ClassProviderElement<
              AnyNotifier<AsyncValue<Map<int, Room>>, Map<int, Room>>,
              AsyncValue<Map<int, Room>>,
              Object?,
              Object?
            >;
    element.handleValue(ref, created);
  }
}

@ProviderFor(AddRoom)
const addRoomProvider = AddRoomProvider._();

final class AddRoomProvider extends $NotifierProvider<AddRoom, LoadingState> {
  const AddRoomProvider._()
    : super(
        from: null,
        argument: null,
        retry: null,
        name: r'addRoomProvider',
        isAutoDispose: true,
        dependencies: null,
        $allTransitiveDependencies: null,
      );

  @override
  String debugGetCreateSourceHash() => _$addRoomHash();

  @$internal
  @override
  AddRoom create() => AddRoom();

  /// {@macro riverpod.override_with_value}
  Override overrideWithValue(LoadingState value) {
    return $ProviderOverride(
      origin: this,
      providerOverride: $SyncValueProvider<LoadingState>(value),
    );
  }
}

String _$addRoomHash() => r'6099c3344b00cb174d227633820509cf4cd8220f';

abstract class _$AddRoom extends $Notifier<LoadingState> {
  LoadingState build();
  @$mustCallSuper
  @override
  void runBuild() {
    final created = build();
    final ref = this.ref as $Ref<LoadingState, LoadingState>;
    final element =
        ref.element
            as $ClassProviderElement<
              AnyNotifier<LoadingState, LoadingState>,
              LoadingState,
              Object?,
              Object?
            >;
    element.handleValue(ref, created);
  }
}
