// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'image_picker_provider.dart';

// **************************************************************************
// RiverpodGenerator
// **************************************************************************

// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint, type=warning

@ProviderFor(imagePickerRepository)
const imagePickerRepositoryProvider = ImagePickerRepositoryProvider._();

final class ImagePickerRepositoryProvider
    extends
        $FunctionalProvider<
          ImagePickerRepository,
          ImagePickerRepository,
          ImagePickerRepository
        >
    with $Provider<ImagePickerRepository> {
  const ImagePickerRepositoryProvider._()
    : super(
        from: null,
        argument: null,
        retry: null,
        name: r'imagePickerRepositoryProvider',
        isAutoDispose: true,
        dependencies: null,
        $allTransitiveDependencies: null,
      );

  @override
  String debugGetCreateSourceHash() => _$imagePickerRepositoryHash();

  @$internal
  @override
  $ProviderElement<ImagePickerRepository> $createElement(
    $ProviderPointer pointer,
  ) => $ProviderElement(pointer);

  @override
  ImagePickerRepository create(Ref ref) {
    return imagePickerRepository(ref);
  }

  /// {@macro riverpod.override_with_value}
  Override overrideWithValue(ImagePickerRepository value) {
    return $ProviderOverride(
      origin: this,
      providerOverride: $SyncValueProvider<ImagePickerRepository>(value),
    );
  }
}

String _$imagePickerRepositoryHash() =>
    r'059fb1934fdfddf50808f89c5eeee0aeb539d973';

@ProviderFor(ImageController)
const imageControllerProvider = ImageControllerProvider._();

final class ImageControllerProvider
    extends $NotifierProvider<ImageController, File?> {
  const ImageControllerProvider._()
    : super(
        from: null,
        argument: null,
        retry: null,
        name: r'imageControllerProvider',
        isAutoDispose: true,
        dependencies: null,
        $allTransitiveDependencies: null,
      );

  @override
  String debugGetCreateSourceHash() => _$imageControllerHash();

  @$internal
  @override
  ImageController create() => ImageController();

  /// {@macro riverpod.override_with_value}
  Override overrideWithValue(File? value) {
    return $ProviderOverride(
      origin: this,
      providerOverride: $SyncValueProvider<File?>(value),
    );
  }
}

String _$imageControllerHash() => r'93d59a9e0b095803fe0cbe016408237deee4dc48';

abstract class _$ImageController extends $Notifier<File?> {
  File? build();
  @$mustCallSuper
  @override
  void runBuild() {
    final created = build();
    final ref = this.ref as $Ref<File?, File?>;
    final element =
        ref.element
            as $ClassProviderElement<
              AnyNotifier<File?, File?>,
              File?,
              Object?,
              Object?
            >;
    element.handleValue(ref, created);
  }
}

@ProviderFor(ClearImageUrl)
const clearImageUrlProvider = ClearImageUrlProvider._();

final class ClearImageUrlProvider
    extends $NotifierProvider<ClearImageUrl, bool> {
  const ClearImageUrlProvider._()
    : super(
        from: null,
        argument: null,
        retry: null,
        name: r'clearImageUrlProvider',
        isAutoDispose: true,
        dependencies: null,
        $allTransitiveDependencies: null,
      );

  @override
  String debugGetCreateSourceHash() => _$clearImageUrlHash();

  @$internal
  @override
  ClearImageUrl create() => ClearImageUrl();

  /// {@macro riverpod.override_with_value}
  Override overrideWithValue(bool value) {
    return $ProviderOverride(
      origin: this,
      providerOverride: $SyncValueProvider<bool>(value),
    );
  }
}

String _$clearImageUrlHash() => r'29c3c830ef8e87d3c5af0a3be5f68ab3a067d187';

abstract class _$ClearImageUrl extends $Notifier<bool> {
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
