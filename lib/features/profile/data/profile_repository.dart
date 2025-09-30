import 'package:smart_home/features/profile/domain/profile.dart';
import 'package:supabase_flutter/supabase_flutter.dart';

class ProfileRepository {
  final SupabaseClient _supabase = Supabase.instance.client;

  User get _currentUser {
    if (_supabase.auth.currentUser == null) {
      throw Exception('currentUser is null');
    }
    return _supabase.auth.currentUser!;
  }

  String get email => _currentUser.email!;

  Future<Profile> getUserInfo() async {
    final data =
        await _supabase
            .from('profiles')
            .select()
            .eq('id', _currentUser.id)
            .single();
    // debugPrint(data.toString());
    return Profile(
      username: (data['username'] ?? '') as String,
      avatarUrl: (data['avatar_url'] ?? '') as String,
    );
  }

  Future<void> updateProfile(Profile profile) async {
    final updates = {
      'id': _currentUser.id,
      'username': profile.username,
      'avatar_url': profile.avatarUrl,
      'updated_at': DateTime.now().toIso8601String(),
    };
    await _supabase.from('profiles').upsert(updates);
  }

  Future<void> changePassword({required String newPassword}) async {
    if (_supabase.auth.currentUser == null) {
      throw Exception('currentUser is null');
    }
    await _supabase.auth.updateUser(UserAttributes(password: newPassword));
  }
}
