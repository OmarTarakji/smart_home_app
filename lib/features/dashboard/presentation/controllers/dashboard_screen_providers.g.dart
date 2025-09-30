// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'dashboard_screen_providers.dart';

// **************************************************************************
// RiverpodGenerator
// **************************************************************************

// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint, type=warning

@ProviderFor(ReadingsState)
const readingsStateProvider = ReadingsStateProvider._();

final class ReadingsStateProvider
    extends $NotifierProvider<ReadingsState, DataState> {
  const ReadingsStateProvider._()
    : super(
        from: null,
        argument: null,
        retry: null,
        name: r'readingsStateProvider',
        isAutoDispose: true,
        dependencies: null,
        $allTransitiveDependencies: null,
      );

  @override
  String debugGetCreateSourceHash() => _$readingsStateHash();

  @$internal
  @override
  ReadingsState create() => ReadingsState();

  /// {@macro riverpod.override_with_value}
  Override overrideWithValue(DataState value) {
    return $ProviderOverride(
      origin: this,
      providerOverride: $SyncValueProvider<DataState>(value),
    );
  }
}

String _$readingsStateHash() => r'c1ed66f13d947e6fb8f58ba13cb67d0127b57e70';

abstract class _$ReadingsState extends $Notifier<DataState> {
  DataState build();
  @$mustCallSuper
  @override
  void runBuild() {
    final created = build();
    final ref = this.ref as $Ref<DataState, DataState>;
    final element =
        ref.element
            as $ClassProviderElement<
              AnyNotifier<DataState, DataState>,
              DataState,
              Object?,
              Object?
            >;
    element.handleValue(ref, created);
  }
}

@ProviderFor(DashboardStateNotifier)
const dashboardStateProvider = DashboardStateNotifierProvider._();

final class DashboardStateNotifierProvider
    extends $NotifierProvider<DashboardStateNotifier, DashboardState> {
  const DashboardStateNotifierProvider._()
    : super(
        from: null,
        argument: null,
        retry: null,
        name: r'dashboardStateProvider',
        isAutoDispose: true,
        dependencies: null,
        $allTransitiveDependencies: null,
      );

  @override
  String debugGetCreateSourceHash() => _$dashboardStateNotifierHash();

  @$internal
  @override
  DashboardStateNotifier create() => DashboardStateNotifier();

  /// {@macro riverpod.override_with_value}
  Override overrideWithValue(DashboardState value) {
    return $ProviderOverride(
      origin: this,
      providerOverride: $SyncValueProvider<DashboardState>(value),
    );
  }
}

String _$dashboardStateNotifierHash() =>
    r'7b7e1abfa54d1f9c7e54136bd1cf77e6ea390c3e';

abstract class _$DashboardStateNotifier extends $Notifier<DashboardState> {
  DashboardState build();
  @$mustCallSuper
  @override
  void runBuild() {
    final created = build();
    final ref = this.ref as $Ref<DashboardState, DashboardState>;
    final element =
        ref.element
            as $ClassProviderElement<
              AnyNotifier<DashboardState, DashboardState>,
              DashboardState,
              Object?,
              Object?
            >;
    element.handleValue(ref, created);
  }
}
