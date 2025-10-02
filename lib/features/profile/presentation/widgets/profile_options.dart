import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';
import 'package:smart_home/core/l10n/app_localizations.dart';
import 'package:smart_home/core/providers/language_provider.dart';
import 'package:smart_home/core/utils/text_formatter.dart';
import 'package:smart_home/features/profile/application/profile_notifier.dart';
import 'package:smart_home/features/profile/domain/settings_item.dart';
import 'package:supabase_flutter/supabase_flutter.dart';

import 'language_dialog.dart';
import 'options.dart';

class ProfileActions extends ConsumerWidget {
  const ProfileActions({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final l10n = AppLocalizations.of(context)!;
    bool isActive = ref.watch(optionsControllerProvider);
    debugPrint('ProfileActions build');

    return OptionsList(
      items: [
        SettingsItem(
          icon: Icons.edit,
          label: l10n.editProfileScreenTitle,
          onTap: isActive ? () => context.push('/edit-profile') : null,
        ),
        SettingsItem(
          icon: Icons.password,
          label: l10n.changePasswordScreenTitle,
          onTap: isActive ? () => context.push('/change-password') : null,
        ),
        SettingsItem(
          icon: Icons.logout,
          label: l10n.profileActionsLogOut,
          onTap: () => onSignOut(l10n),
        ),
      ],
    );
  }

  void onSignOut(AppLocalizations l10n) async {
    try {
      await Supabase.instance.client.auth.signOut();
    } catch (error) {
      TextFormatter.getErrorMessage(error, l10n);
    }
  }
}

class AppInfoSection extends ConsumerWidget {
  const AppInfoSection({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final l10n = AppLocalizations.of(context)!;
    final initialLanguage = ref.watch(selectedLanguageProvider).languageCode;
    return OptionsList(
      items: [
        SettingsItem(
          icon: Icons.language,
          label: l10n.appInfoLanguageLabel,
          onTap: () async {
            final selectedLanguage = await showDialog(
              context: context,
              builder: (context) => LanguageDialog(initialLanguage),
            );
            if (selectedLanguage == null) return;
            ref
                .read(selectedLanguageProvider.notifier)
                .selectLanguage(selectedLanguage);
          },
        ),
        SettingsItem(icon: Icons.help, label: l10n.appInfoContactSupport),
        const SettingsItem(icon: Icons.info, label: 'Smart Home 1.2.2'),
      ],
    );
  }
}
