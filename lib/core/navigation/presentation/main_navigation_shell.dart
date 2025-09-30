import 'package:device_info_plus/device_info_plus.dart';
import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';
import 'package:smart_home/core/l10n/app_localizations.dart';
import 'package:smart_home/core/utils/extensions.dart';
import 'package:smart_home/features/notifications/application/notifications_provider.dart';
import 'package:supabase_flutter/supabase_flutter.dart';

import '../../../core/utils/smart_home_icons.dart';
import 'widgets/custom_navigation.dart';
import 'widgets/custom_navigation_bar.dart';
import 'widgets/custom_navigation_rail.dart';

class MainNavigationShell extends ConsumerStatefulWidget {
  const MainNavigationShell({required this.child, super.key});

  final Widget child;

  @override
  ConsumerState<MainNavigationShell> createState() =>
      _MainNavigationShellState();
}

class _MainNavigationShellState extends ConsumerState<MainNavigationShell> {
  final supabase = Supabase.instance.client;

  @override
  void initState() {
    supabase.auth.onAuthStateChange.listen((event) async {
      if (event.event == AuthChangeEvent.signedIn) {
        debugPrint('LOG: Here\'s the problem');
        final settings = await FirebaseMessaging.instance.requestPermission(
          provisional: true,
        );
        debugPrint('LOG: settings $settings');
        final fcmToken = await FirebaseMessaging.instance.getToken();
        debugPrint('LOG: fcmToken $fcmToken');
        if (fcmToken != null) {
          await _setFcmToken(fcmToken);
        }
      }
    });
    FirebaseMessaging.instance.onTokenRefresh.listen((fcmToken) async {
      _setFcmToken(fcmToken);
    });

    FirebaseMessaging.onMessage.listen((payload) {
      final notification = payload.notification;
      if (notification != null) {
        debugPrint('LOG: ${notification.title}: ${notification.body}');
        context.showSnackBar('${notification.title}: ${notification.body}');
        ref.read(notificationsProvider.notifier).refresh();
      }
    });
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    // Eagerly initialize the necessary providers
    final l10n = AppLocalizations.of(context)!;

    final isWideScreen = MediaQuery.of(context).size.width >= 600;
    final selectedIndex = _calculateSelectedIndex(context);

    return Scaffold(
      bottomNavigationBar:
          isWideScreen
              ? null
              : CustomNavigationBar(
                onDestinationSelected: (idx) => _onItemTapped(idx, context),
                selectedIndex: _calculateSelectedIndex(context),
                destinations: _navDestinations(l10n),
              ),
      body:
          isWideScreen
              ? CustomNavigationRail(
                onDestinationSelected: (idx) => _onItemTapped(idx, context),
                selectedIndex: selectedIndex,
                destinations: _navDestinations(l10n),
                body: widget.child,
              )
              : widget.child,
    );
  }

  static int _calculateSelectedIndex(BuildContext context) {
    final location = GoRouterState.of(context).uri.path;
    debugPrint('App Route: $location');
    if (location.startsWith('/dashboard')) return 0;
    if (location.startsWith('/devices')) return 1;
    if (location.startsWith('/rooms')) return 2;
    if (location.startsWith('/profile')) return 3;
    return 0;
  }

  void _onItemTapped(int index, BuildContext context) {
    final routes = ['/dashboard', '/devices', '/rooms', '/profile'];
    if (index >= 0 && index < routes.length) {
      context.go(routes[index]);
    }
  }

  List<CustomDestination> _navDestinations(AppLocalizations l10n) {
    return [
      CustomDestination(icon: AppIcons.dashboard, label: l10n.dashboard),
      CustomDestination(icon: AppIcons.chip, label: l10n.devices),
      CustomDestination(icon: AppIcons.room, label: l10n.rooms),
      CustomDestination(icon: AppIcons.user, label: l10n.profile),
    ];
  }

  Future<void> _setFcmToken(String fcmToken) async {
    final userId = supabase.auth.currentUser?.id;
    if (userId != null) {
      try {
        await supabase.from('user_fcm_tokens').upsert({
          'user_id': userId,
          'fcm_token': fcmToken,
          'device_name': await _getId(), // Optional: You can get device name
          'last_used_at': DateTime.now().toIso8601String(),
        }, onConflict: 'user_id,fcm_token');

        debugPrint('FCM token stored/updated successfully');
      } catch (e) {
        debugPrint('Error storing FCM token: $e');
      }
    }
  }

  Future<String?> _getId() async {
    DeviceInfoPlugin deviceInfo = DeviceInfoPlugin();
    AndroidDeviceInfo androidInfo = await deviceInfo.androidInfo;
    debugPrint('LOG: Running on ${androidInfo.model}'); // e.g. "Moto G (4)"
    return androidInfo.id;
  }
}
