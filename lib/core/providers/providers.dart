import 'package:riverpod_annotation/riverpod_annotation.dart';
import 'package:supabase_flutter/supabase_flutter.dart';

import '../shared_preferences.dart';

part 'providers.g.dart';

@Riverpod(keepAlive: true)
CachedPreferences sharedPreferences(Ref ref) =>
    throw UnimplementedError('Initialize in main()');

@riverpod
bool hasSession(Ref ref) =>
    Supabase.instance.client.auth.currentSession != null;
