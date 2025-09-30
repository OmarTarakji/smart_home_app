import 'dart:io';

import 'package:image_picker/image_picker.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';

import '../data/image_picker_repository.dart';

part 'image_picker_provider.g.dart';

@riverpod
ImagePickerRepository imagePickerRepository(Ref ref) => ImagePickerRepository();

@riverpod
class ImageController extends _$ImageController {
  @override
  File? build() => null;
  Future<bool> pickImage(ImageSource source, {bool isProfile = false}) async {
    final picker = ref.watch(imagePickerRepositoryProvider);
    var imageFile = await picker.pickImage(source);
    if (imageFile == null) return false;

    if (Platform.isAndroid) {
      imageFile = await picker.cropImage(imageFile, isProfile: isProfile);
      if (imageFile == null) return false;
    }

    state = imageFile;
    return true;
  }

  void clear() {
    state = null;
    ref.read(clearImageUrlProvider.notifier).setTrue();
  }
}

@riverpod
class ClearImageUrl extends _$ClearImageUrl {
  @override
  bool build() => false;

  void setTrue() => state = true;
}
