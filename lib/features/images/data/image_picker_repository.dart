import 'dart:io';

import 'package:image_cropper/image_cropper.dart';
import 'package:image_picker/image_picker.dart';
import 'package:smart_home/core/theme/app_colors.dart';
import 'package:smart_home/core/utils/exceptions.dart';

class ImagePickerRepository {
  final ImagePicker _imagePicker;
  final ImageCropper _imageCropper;

  ImagePickerRepository({ImagePicker? imagePicker, ImageCropper? imageCropper})
    : _imagePicker = imagePicker ?? ImagePicker(),
      _imageCropper = imageCropper ?? ImageCropper();

  Future<File?> pickImage(ImageSource source) async {
    try {
      final XFile? pickedFile = await _imagePicker.pickImage(
        source: source,
        imageQuality: 60,
        maxWidth: 1200,
        maxHeight: 1200,
      );
      return pickedFile != null ? File(pickedFile.path) : null;
    } catch (e) {
      throw const ImagePickerException('Image picker error.');
    }
  }

  Future<File?> cropImage(File imageFile, {required bool isProfile}) async {
    try {
      final CroppedFile? croppedFile;
      if (isProfile) {
        croppedFile = await _imageCropper.cropImage(
          sourcePath: imageFile.path,
          aspectRatio: const CropAspectRatio(ratioX: 1, ratioY: 1),
          maxHeight: 500,
          maxWidth: 500,
          uiSettings: [
            AndroidUiSettings(
              toolbarTitle: 'Crop Image',
              toolbarColor: AppColors.lightColorScheme.primary,
              toolbarWidgetColor: AppColors.lightColorScheme.onPrimary,
              activeControlsWidgetColor: AppColors.lightColorScheme.primary,
              cropStyle: CropStyle.circle,
              initAspectRatio: CropAspectRatioPreset.square,
              lockAspectRatio: true,
            ),
            // IOSUiSettings(title: 'Crop Image'),
          ],
        );
      } else {
        croppedFile = await _imageCropper.cropImage(
          sourcePath: imageFile.path,
          maxHeight: 1200,
          maxWidth: 1200,
          uiSettings: [
            AndroidUiSettings(
              toolbarTitle: 'Crop Image',
              toolbarColor: AppColors.lightColorScheme.primary,
              toolbarWidgetColor: AppColors.lightColorScheme.onPrimary,
              activeControlsWidgetColor: AppColors.lightColorScheme.primary,
              lockAspectRatio: false,
            ),
            // IOSUiSettings(title: 'Crop Image'),
          ],
        );
      }
      return croppedFile != null ? File(croppedFile.path) : null;
    } catch (e) {
      throw const ImagePickerException('Image cropper error');
    }
  }
}
