import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_svg/svg.dart';
import 'package:smart_home/core/constants/api_keys.dart';
import 'package:smart_home/core/providers/language_provider.dart';
import 'package:smart_home/core/shared_preferences.dart';
import 'package:supabase_flutter/supabase_flutter.dart';

import 'core/constants/images.dart';
import 'core/l10n/app_localizations.dart';
import 'core/navigation/presentation/controllers/app_router.dart';
import 'core/providers/providers.dart';
import 'core/theme/app_theme.dart';
import 'core/theme/text_theme.dart';
import 'firebase_options.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();

  const loader = SvgAssetLoader(Images.ESP32);
  final prefs = CachedPreferences();

  await Future.wait([
    Firebase.initializeApp(options: DefaultFirebaseOptions.currentPlatform),
    Supabase.initialize(url: APIKeys.SUPABASE_URL, anonKey: APIKeys.ANON_KEY),
    prefs.init(),
    svg.cache.putIfAbsent(loader.cacheKey(null), () => loader.loadBytes(null)),
  ]);

  runApp(
    ProviderScope(
      overrides: [sharedPreferencesProvider.overrideWithValue(prefs)],
      child: const MyApp(),
    ),
  );
}

class MyApp extends ConsumerWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final selectedLanguage = ref.watch(selectedLanguageProvider);
    TextTheme textTheme =
        selectedLanguage.languageCode == 'ar'
            ? createTextTheme(context, 'Cairo', 'Cairo')
            : createTextTheme(context, 'AvantGarde', 'AvantGarde');
    AppTheme theme = AppTheme(textTheme);
    return MaterialApp.router(
      title: 'Smart Home',
      debugShowCheckedModeBanner: false,
      theme: theme.lightTheme,
      darkTheme: theme.darkTheme,
      routerConfig: ref.watch(appRouterProvider),
      locale: selectedLanguage,
      localizationsDelegates: AppLocalizations.localizationsDelegates,
      supportedLocales: AppLocalizations.supportedLocales,
    );
  }
}
