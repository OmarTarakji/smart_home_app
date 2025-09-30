// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'auth_provider.dart';

// **************************************************************************
// RiverpodGenerator
// **************************************************************************

// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint, type=warning
/// Main authentication logic provider

@ProviderFor(AuthNotifier)
const authProvider = AuthNotifierProvider._();

/// Main authentication logic provider
final class AuthNotifierProvider
    extends $AsyncNotifierProvider<AuthNotifier, void> {
  /// Main authentication logic provider
  const AuthNotifierProvider._()
    : super(
        from: null,
        argument: null,
        retry: null,
        name: r'authProvider',
        isAutoDispose: true,
        dependencies: null,
        $allTransitiveDependencies: null,
      );

  @override
  String debugGetCreateSourceHash() => _$authNotifierHash();

  @$internal
  @override
  AuthNotifier create() => AuthNotifier();
}

String _$authNotifierHash() => r'efb82a0937de8b88220eb79b3d543674a7aee237';

/// Main authentication logic provider

abstract class _$AuthNotifier extends $AsyncNotifier<void> {
  FutureOr<void> build();
  @$mustCallSuper
  @override
  void runBuild() {
    build();
    final ref = this.ref as $Ref<AsyncValue<void>, void>;
    final element =
        ref.element
            as $ClassProviderElement<
              AnyNotifier<AsyncValue<void>, void>,
              AsyncValue<void>,
              Object?,
              Object?
            >;
    element.handleValue(ref, null);
  }
}

@ProviderFor(savedCredentials)
const savedCredentialsProvider = SavedCredentialsProvider._();

final class SavedCredentialsProvider
    extends
        $FunctionalProvider<
          AsyncValue<(String?, String?)>,
          (String?, String?),
          FutureOr<(String?, String?)>
        >
    with
        $FutureModifier<(String?, String?)>,
        $FutureProvider<(String?, String?)> {
  const SavedCredentialsProvider._()
    : super(
        from: null,
        argument: null,
        retry: null,
        name: r'savedCredentialsProvider',
        isAutoDispose: true,
        dependencies: null,
        $allTransitiveDependencies: null,
      );

  @override
  String debugGetCreateSourceHash() => _$savedCredentialsHash();

  @$internal
  @override
  $FutureProviderElement<(String?, String?)> $createElement(
    $ProviderPointer pointer,
  ) => $FutureProviderElement(pointer);

  @override
  FutureOr<(String?, String?)> create(Ref ref) {
    return savedCredentials(ref);
  }
}

String _$savedCredentialsHash() => r'0dce8b25b09b244294f28f2f74944311db013c09';
