// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'edit_profile_providers.dart';

// **************************************************************************
// RiverpodGenerator
// **************************************************************************

// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint, type=warning

@ProviderFor(ProfileController)
const profileControllerProvider = ProfileControllerProvider._();

final class ProfileControllerProvider
    extends $NotifierProvider<ProfileController, LoadingState> {
  const ProfileControllerProvider._()
    : super(
        from: null,
        argument: null,
        retry: null,
        name: r'profileControllerProvider',
        isAutoDispose: true,
        dependencies: null,
        $allTransitiveDependencies: null,
      );

  @override
  String debugGetCreateSourceHash() => _$profileControllerHash();

  @$internal
  @override
  ProfileController create() => ProfileController();

  /// {@macro riverpod.override_with_value}
  Override overrideWithValue(LoadingState value) {
    return $ProviderOverride(
      origin: this,
      providerOverride: $SyncValueProvider<LoadingState>(value),
    );
  }
}

String _$profileControllerHash() => r'eb92208bfed2ba0d99ffd23061a4198c97a21b7e';

abstract class _$ProfileController extends $Notifier<LoadingState> {
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
