import 'package:go_router/go_router.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';
import 'package:smart_home/features/auth/presentation/screens/login_screen.dart';
import 'package:smart_home/features/auth/presentation/screens/signup_screen.dart';
import 'package:smart_home/features/dashboard/domain/component.dart';
import 'package:smart_home/features/dashboard/presentation/screens/component_screen.dart';
import 'package:smart_home/features/dashboard/presentation/screens/dashboard_screen.dart';
import 'package:smart_home/features/devices/application/devices_notifier.dart';
import 'package:smart_home/features/devices/presentation/screens/devices_screen.dart';
import 'package:smart_home/features/devices/presentation/screens/new_device_screen.dart';
import 'package:smart_home/features/fingerprint/domain/fingerprint.dart';
import 'package:smart_home/features/fingerprint/presentation/screens/add_fingerprint_screen.dart';
import 'package:smart_home/features/fingerprint/presentation/screens/edit_fingerprint_screen.dart';
import 'package:smart_home/features/fingerprint/presentation/screens/fingerprints_manager_screen.dart';
import 'package:smart_home/features/notifications/application/notifications_provider.dart';
import 'package:smart_home/features/notifications/presentation/screens/notifications_screen.dart';
import 'package:smart_home/features/profile/application/profile_notifier.dart';
import 'package:smart_home/features/profile/presentation/screens/change_password_screen.dart';
import 'package:smart_home/features/profile/presentation/screens/edit_profile_screen.dart';
import 'package:smart_home/features/profile/presentation/screens/profile_screen.dart';
import 'package:smart_home/features/rooms/application/rooms_provider.dart';
import 'package:smart_home/features/rooms/presentation/screens/add_room_screen.dart';
import 'package:smart_home/features/rooms/presentation/screens/components_picker.dart';
import 'package:smart_home/features/rooms/presentation/screens/room_screen.dart';
import 'package:smart_home/features/rooms/presentation/screens/rooms_screen.dart';
import 'package:supabase_flutter/supabase_flutter.dart';

import '../../../providers/providers.dart';
import '../main_navigation_shell.dart';

part 'app_router.g.dart';

@riverpod
GoRouter appRouter(Ref ref) {
  final stream = Supabase.instance.client.auth.onAuthStateChange.listen(
    (_) => ref.refresh(hasSessionProvider),
  );
  ref.onDispose(() => stream.cancel());

  final hasSession = ref.watch(hasSessionProvider);

  return GoRouter(
    initialLocation: '/dashboard',
    routes: [
      ShellRoute(
        builder: (context, state, child) => MainNavigationShell(child: child),
        routes: [
          GoRoute(
            path: '/dashboard',
            builder: (_, _) => const DashboardScreen(),
          ),
          GoRoute(path: '/devices', builder: (_, _) => const DevicesScreen()),
          GoRoute(path: '/rooms', builder: (_, _) => const RoomsScreen()),
          GoRoute(path: '/profile', builder: (_, _) => const ProfileScreen()),
        ],
      ),
      GoRoute(path: '/login', builder: (_, _) => const LoginScreen()),
      GoRoute(path: '/signup', builder: (_, _) => const SignUpScreen()),
      GoRoute(
        path: '/edit-profile',
        builder: (_, _) => const EditProfileScreen(),
      ),
      GoRoute(
        path: '/change-password',
        builder: (_, _) => const ChangePasswordScreen(),
      ),
      GoRoute(path: '/add-device', builder: (_, _) => const NewDeviceScreen()),
      GoRoute(
        path: '/add-room',
        builder: (context, state) => const RoomEditorScreen(),
      ),
      GoRoute(
        path: '/room',
        builder: (_, state) => RoomScreen(roomId: state.extra as int),
        routes: [
          GoRoute(
            path: 'components-picker',
            builder: (_, state) => ComponentsPicker(roomId: state.extra as int),
          ),
        ],
      ),
      GoRoute(
        path: '/component',
        builder:
            (context, state) => ComponentScreenRouter(state.extra as Component),
      ),
      GoRoute(
        path: '/fingerprints-manager',
        builder:
            (context, state) => FingerprintsManagerScreen(state.extra as int),
      ),
      GoRoute(
        path: '/edit-fingerprint',
        builder:
            (context, state) =>
                EditFingerprintScreen(state.extra as Fingerprint),
      ),
      GoRoute(
        path: '/add-fingerprint',
        builder: (context, state) => AddFingerprintScreen(state.extra as int),
      ),
      // GoRoute(
      //   path: '/add-fingerprint-2',
      //   builder: (context, state) => AddFingerprintScreen2(),
      // ),
      GoRoute(
        path: '/notifications',
        builder: (context, state) => const NotificationsScreen(),
      ),
    ],
    redirect: (context, state) {
      final String goingTo = state.matchedLocation;
      if (!hasSession && goingTo != '/login' && goingTo != '/signup') {
        // invalidate all user specific providers
        ref.invalidate(devicesProvider);
        ref.invalidate(profileProvider);
        ref.invalidate(roomsProvider);
        ref.invalidate(notificationsProvider);
        return '/login';
      }
      return null;
    },
  );
}
