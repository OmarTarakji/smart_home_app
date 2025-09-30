import 'dart:async';

import 'package:flutter/foundation.dart' show debugPrint;
import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';
import 'package:smart_home/core/utils/exceptions.dart';
import 'package:smart_home/features/profile/data/profile_repository.dart';
import 'package:smart_home/features/profile/domain/profile.dart';

part 'profile_notifier.g.dart';

@riverpod
class ProfileNotifier extends _$ProfileNotifier {
  late final ProfileRepository _repo = ProfileRepository();
  final safeStorage = FlutterSecureStorage();

  @override
  Future<Profile> build() async {
    ref.keepAlive();
    try {
      // Fetch profile data
      final profile = await _repo.getUserInfo();
      debugPrint('log: built Profile Notifier');
      return profile;
    } catch (e) {
      // Start auto-reload if initial load fails
      debugPrint('log: Failed to load Profile, starting auto-reload');
      _autoReload();
      rethrow;
    }
  }

  void _autoReload() async {
    while (true) {
      try {
        debugPrint('log: Loading profile...');
        final profile = await _repo.getUserInfo();
        state = AsyncData(profile);
        break;
      } catch (e) {
        debugPrint('log: Error loading profile, Scheduling for auto-reload');
        await Future.delayed(const Duration(seconds: 5));
      }
    }
  }

  Future<void> changePassword({
    required String currentPassword,
    required String newPassword,
  }) async {
    final Profile previous = state.requireValue;
    state = const AsyncValue.loading();
    await Future.delayed(const Duration(seconds: 3));
    try {
      final storedPassword = await safeStorage.read(key: 'password');
      if (storedPassword != currentPassword) {
        throw const ProfileException('Current password is incorrect');
      }
      if (storedPassword == newPassword) {
        throw const ProfileException(
          'New password cannot be the same as the current password',
        );
      }
      await _repo.changePassword(newPassword: newPassword);
      await safeStorage.write(key: 'password', value: newPassword);
    } finally {
      state = AsyncValue.data(previous);
    }
  }

  Future<void> updateProfile(Profile newProfile) async {
    final Profile previous = state.requireValue;
    state = const AsyncValue.loading();
    try {
      await _repo.updateProfile(newProfile);
      state = AsyncValue.data(newProfile);
    } catch (e) {
      state = AsyncValue.data(previous);
      rethrow;
    }
  }
}

@riverpod
class OptionsController extends _$OptionsController {
  @override
  bool build() {
    return ref.watch(profileProvider).hasValue;
  }
}
