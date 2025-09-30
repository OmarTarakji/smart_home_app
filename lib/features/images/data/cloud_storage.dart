import 'dart:io';

import 'package:supabase_flutter/supabase_flutter.dart';

class CloudStorage {
  final SupabaseClient supabase = Supabase.instance.client;

  // Upload (store only the path)
  Future<String> uploadImage(String bucket, File imageFile) async {
    final userId = supabase.auth.currentUser!.id;
    final bytes = await imageFile.readAsBytes();
    final fileExt = imageFile.path.split('.').last;
    final fileName = '${DateTime.now().toIso8601String()}.$fileExt';
    final filePath = '$userId/$fileName';

    await supabase.storage.from(bucket).uploadBinary(filePath, bytes);

    // Fetch URL when needed (with short expiry)
    return await supabase.storage
        .from(bucket)
        .createSignedUrl(filePath, 3600 * 24 * 365 * 10); // 10 years expiry
  }
}
