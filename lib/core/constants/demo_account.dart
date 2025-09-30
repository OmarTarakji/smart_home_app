import 'package:supabase_flutter/supabase_flutter.dart';

class DemoAccount {
  static const email = 'demo@smarthome.com';
  static const password = 'demo1234';

  static bool get isCurrentlyUsed =>
      Supabase.instance.client.auth.currentUser?.email == DemoAccount.email;
}
