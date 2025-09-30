import 'dart:async';

import 'package:flutter/material.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';
import 'package:smart_home/core/utils/exceptions.dart';
import 'package:smart_home/features/images/application/image_picker_provider.dart';
import 'package:smart_home/features/images/domain/loading_state.dart';
import 'package:smart_home/features/images/domain/storage_buckets.dart';

import '../../images/data/cloud_storage.dart';

part 'room_editor_provider.g.dart';

@riverpod
class RoomImageController extends _$RoomImageController {
  String? _url;
  Completer<String?>? _uploadCompleter;
  final _storage = CloudStorage();

  @override
  LoadingState build() => LoadingState.none;

  Future<void> uploadImage() async {
    final imageFile = ref.read(imageControllerProvider);
    if (imageFile == null) return;

    _url = null;
    debugPrint('log: Uploading image, _url is set to $_url');

    state = LoadingState.uploading;
    _uploadCompleter = Completer<String?>();
    debugPrint('log: uploading image');

    try {
      _url = await _storage.uploadImage(StorageBucket.rooms, imageFile);
      debugPrint('log: image uploaded\nlink: $_url');
      state = LoadingState.none;
      _uploadCompleter?.complete(_url);
    } catch (e) {
      debugPrint('log: failed to upload image');
      debugPrint(e.toString());
      state = LoadingState.error;
      _uploadCompleter?.completeError(e);
    } finally {
      _uploadCompleter = null;
    }
  }

  void clearImage() {
    _url = null;
    state = LoadingState.none;
  }

  Future<String?> url() async {
    // If we already have a URL, return it immediately
    debugPrint('log: _url: $url');
    if (_url != null) return _url;
    // If there was an error, try again
    if (state == LoadingState.error) {
      await uploadImage();
      if (state == LoadingState.error) {
        throw const StorageException('Failed to upload image!');
      }
    }

    // If upload is in progress, wait for it to complete
    if (state == LoadingState.uploading && _uploadCompleter != null) {
      try {
        return await _uploadCompleter!.future;
      } catch (e) {
        throw const StorageException('Failed to upload image!');
      }
    }

    // If we get here with no URL and no upload in progress, return null
    return _url;
  }
}

@riverpod
class RoomFormController extends _$RoomFormController {
  String? _name;

  @override
  GlobalKey<FormState> build() => GlobalKey<FormState>();

  String save() {
    if (!state.currentState!.validate()) {
      throw const ValidatorException('missing arguments');
    }
    state.currentState!.save();
    return _name!;
  }

  String? nameValidator(String? value) {
    if (value == null || value.isEmpty) return 'This field is required';
    return null;
  }

  void saveName(String? name) => _name = name;
}
