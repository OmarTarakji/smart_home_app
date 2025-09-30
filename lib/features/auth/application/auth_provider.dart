import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';
import 'package:smart_home/core/constants/demo_account.dart';
import 'package:supabase_flutter/supabase_flutter.dart';

part 'auth_provider.g.dart';

/// Main authentication logic provider
@riverpod
class AuthNotifier extends _$AuthNotifier {
  final _supabase = Supabase.instance.client;
  final _safeStorage = FlutterSecureStorage();
  String _username = '';
  String _password = '';

  @override
  Future<void> build() async {
    // Initial empty state
    return;
  }

  void setUsername(String value) => _username = value.trim();

  void setPassword(String value) => _password = value.trim();

  Future<void> login() async {
    if (_username.isEmpty || _password.isEmpty) return;
    state = const AsyncValue.loading();
    state = await AsyncValue.guard(() async {
      await _supabase.auth.signInWithPassword(
        email: '$_username@smarthome.com',
        password: _password,
      );
    });
    _saveCredentials();
  }

  Future<void> signUp() async {
    if (_username.isEmpty || _password.isEmpty) return;
    state = const AsyncValue.loading();
    state = await AsyncValue.guard(() async {
      await _supabase.auth.signUp(
        email: '$_username@smarthome.com',
        password: _password,
      );
    });

    _saveCredentials();
  }

  Future<void> loginDemo() async {
    state = const AsyncValue.loading();
    state = await AsyncValue.guard(() async {
      await _supabase.auth.signInWithPassword(
        email: DemoAccount.email,
        password: DemoAccount.password,
      );
    });
  }

  Future<void> _saveCredentials() async {
    await _safeStorage.write(key: 'username', value: _username);
    await _safeStorage.write(key: 'password', value: _password);
  }
}

@riverpod
Future<(String?, String?)> savedCredentials(Ref ref) async {
  const storage = FlutterSecureStorage();
  final username = await storage.read(key: 'username');
  final password = await storage.read(key: 'password');
  return (username, password);
}
