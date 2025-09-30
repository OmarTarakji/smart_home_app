// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'room_editor_provider.dart';

// **************************************************************************
// RiverpodGenerator
// **************************************************************************

// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint, type=warning

@ProviderFor(RoomImageController)
const roomImageControllerProvider = RoomImageControllerProvider._();

final class RoomImageControllerProvider
    extends $NotifierProvider<RoomImageController, LoadingState> {
  const RoomImageControllerProvider._()
    : super(
        from: null,
        argument: null,
        retry: null,
        name: r'roomImageControllerProvider',
        isAutoDispose: true,
        dependencies: null,
        $allTransitiveDependencies: null,
      );

  @override
  String debugGetCreateSourceHash() => _$roomImageControllerHash();

  @$internal
  @override
  RoomImageController create() => RoomImageController();

  /// {@macro riverpod.override_with_value}
  Override overrideWithValue(LoadingState value) {
    return $ProviderOverride(
      origin: this,
      providerOverride: $SyncValueProvider<LoadingState>(value),
    );
  }
}

String _$roomImageControllerHash() =>
    r'a5e8be61c4b7db93d17e9411f599c63e4d544163';

abstract class _$RoomImageController extends $Notifier<LoadingState> {
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

@ProviderFor(RoomFormController)
const roomFormControllerProvider = RoomFormControllerProvider._();

final class RoomFormControllerProvider
    extends $NotifierProvider<RoomFormController, GlobalKey<FormState>> {
  const RoomFormControllerProvider._()
    : super(
        from: null,
        argument: null,
        retry: null,
        name: r'roomFormControllerProvider',
        isAutoDispose: true,
        dependencies: null,
        $allTransitiveDependencies: null,
      );

  @override
  String debugGetCreateSourceHash() => _$roomFormControllerHash();

  @$internal
  @override
  RoomFormController create() => RoomFormController();

  /// {@macro riverpod.override_with_value}
  Override overrideWithValue(GlobalKey<FormState> value) {
    return $ProviderOverride(
      origin: this,
      providerOverride: $SyncValueProvider<GlobalKey<FormState>>(value),
    );
  }
}

String _$roomFormControllerHash() =>
    r'ba3d238025b510f43deb739f01bb676f9463600c';

abstract class _$RoomFormController extends $Notifier<GlobalKey<FormState>> {
  GlobalKey<FormState> build();
  @$mustCallSuper
  @override
  void runBuild() {
    final created = build();
    final ref = this.ref as $Ref<GlobalKey<FormState>, GlobalKey<FormState>>;
    final element =
        ref.element
            as $ClassProviderElement<
              AnyNotifier<GlobalKey<FormState>, GlobalKey<FormState>>,
              GlobalKey<FormState>,
              Object?,
              Object?
            >;
    element.handleValue(ref, created);
  }
}
