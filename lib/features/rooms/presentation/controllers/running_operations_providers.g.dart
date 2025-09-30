// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'running_operations_providers.dart';

// **************************************************************************
// RiverpodGenerator
// **************************************************************************

// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint, type=warning

@ProviderFor(RenameRoomLoadingState)
const renameRoomLoadingStateProvider = RenameRoomLoadingStateProvider._();

final class RenameRoomLoadingStateProvider
    extends $NotifierProvider<RenameRoomLoadingState, bool> {
  const RenameRoomLoadingStateProvider._()
    : super(
        from: null,
        argument: null,
        retry: null,
        name: r'renameRoomLoadingStateProvider',
        isAutoDispose: true,
        dependencies: null,
        $allTransitiveDependencies: null,
      );

  @override
  String debugGetCreateSourceHash() => _$renameRoomLoadingStateHash();

  @$internal
  @override
  RenameRoomLoadingState create() => RenameRoomLoadingState();

  /// {@macro riverpod.override_with_value}
  Override overrideWithValue(bool value) {
    return $ProviderOverride(
      origin: this,
      providerOverride: $SyncValueProvider<bool>(value),
    );
  }
}

String _$renameRoomLoadingStateHash() =>
    r'1338a797a619d89627e0acb6b556c6bff2db465e';

abstract class _$RenameRoomLoadingState extends $Notifier<bool> {
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

@ProviderFor(RunningOperations)
const runningOperationsProvider = RunningOperationsProvider._();

final class RunningOperationsProvider
    extends $NotifierProvider<RunningOperations, int> {
  const RunningOperationsProvider._()
    : super(
        from: null,
        argument: null,
        retry: null,
        name: r'runningOperationsProvider',
        isAutoDispose: true,
        dependencies: null,
        $allTransitiveDependencies: null,
      );

  @override
  String debugGetCreateSourceHash() => _$runningOperationsHash();

  @$internal
  @override
  RunningOperations create() => RunningOperations();

  /// {@macro riverpod.override_with_value}
  Override overrideWithValue(int value) {
    return $ProviderOverride(
      origin: this,
      providerOverride: $SyncValueProvider<int>(value),
    );
  }
}

String _$runningOperationsHash() => r'18cda2e9ffb0dde68981e0d6d9717a351f1d3afb';

abstract class _$RunningOperations extends $Notifier<int> {
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
