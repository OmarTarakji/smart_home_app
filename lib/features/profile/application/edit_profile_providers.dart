import 'dart:io';

import 'package:riverpod_annotation/riverpod_annotation.dart';
import 'package:smart_home/features/images/application/image_picker_provider.dart';
import 'package:smart_home/features/images/data/cloud_storage.dart';
import 'package:smart_home/features/images/domain/loading_state.dart';
import 'package:smart_home/features/profile/domain/profile.dart';

import '../../images/domain/storage_buckets.dart';
import 'profile_notifier.dart';

part 'edit_profile_providers.g.dart';

@riverpod
class ProfileController extends _$ProfileController {
  final _storage = CloudStorage();
  @override
  LoadingState build() => LoadingState.none;

  Future<void> saveProfile(Profile profile) async {
    try {
      final File? imageFile = ref.read(imageControllerProvider);
      state = LoadingState.uploading;

      if (imageFile != null) {
        profile.avatarUrl = await _storage.uploadImage(
          StorageBucket.avatars,
          imageFile,
        );
      }
      state = LoadingState.saving;
      await ref.read(profileProvider.notifier).updateProfile(profile);
      // state = LoadingState.none;
    } catch (e) {
      state = LoadingState.none;
      rethrow;
    }
  }
}
