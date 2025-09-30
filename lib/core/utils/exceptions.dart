export 'dart:async' show TimeoutException;
export 'dart:io' show SocketException;

export 'package:http/http.dart' show ClientException; // For ClientException
export 'package:supabase_flutter/supabase_flutter.dart'
    show
        PostgrestException,
        AuthException,
        StorageException,
        AuthRetryableFetchException;

class DeviceException implements Exception {
  final String message;
  const DeviceException(this.message);
}

class RetrieveDataException implements Exception {
  final String message;
  const RetrieveDataException(this.message);
}

class ProfileException implements Exception {
  final String message;
  const ProfileException(this.message);
}

class ImagePickerException implements Exception {
  final String message;
  const ImagePickerException(this.message);
}

class DiscoveryInProgressException implements Exception {
  final String message;
  const DiscoveryInProgressException(this.message);
}

class PermissionException implements Exception {
  final String message;
  const PermissionException(this.message);
}

class NetworkInfoException implements Exception {
  final String message;
  const NetworkInfoException(this.message);
}

class ValidatorException implements Exception {
  final String message;
  const ValidatorException(this.message);
}

class FingerprintException implements Exception {
  final String title;
  final String message;
  const FingerprintException(this.title, this.message);
}

class DemoAccountException implements Exception {}
