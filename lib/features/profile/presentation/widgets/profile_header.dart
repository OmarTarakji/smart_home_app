import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';
import 'package:smart_home/core/l10n/app_localizations.dart';
import 'package:smart_home/core/utils/extensions.dart';
import 'package:supabase_flutter/supabase_flutter.dart';

import '../../../images/presentation/dynamic_image.dart';
import '../../application/profile_notifier.dart';

class Avatar extends ConsumerWidget {
  const Avatar({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    debugPrint('Avatar build');
    final profileAsync = ref.watch(profileProvider);
    final bool isLoaded = profileAsync.hasValue;
    final String? url = isLoaded ? profileAsync.requireValue.avatarUrl : null;

    return GestureDetector(
      onTap: isLoaded ? () => context.push('/edit-profile') : null,
      child: RoundedImage(imageUrl: url),
    );
  }
}

class ProfileName extends ConsumerWidget {
  const ProfileName({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final l10n = AppLocalizations.of(context)!;
    final profileAsync = ref.watch(profileProvider);
    TextStyle textStyle = Theme.of(context).textTheme.bodyLarge!;

    late final String text;
    profileAsync.when(
      data: (data) {
        if (data.username?.isEmpty ?? true) {
          text = l10n.profileAddName;
          textStyle = textStyle.apply(
            color: context.colorScheme.outline,
            fontStyle: FontStyle.italic,
          );
        } else {
          text = data.username!;
          textStyle = textStyle = textStyle.apply(fontSizeFactor: 1.5);
        }
      },
      error: (_, _) {
        text = l10n.profileFailedToLoad;
        textStyle = textStyle.apply(color: context.colorScheme.error);
      },
      loading: () {
        text = l10n.profileLoadingUserInformation;
        textStyle = textStyle.apply(
          color: context.colorScheme.outline,
          fontStyle: FontStyle.italic,
        );
      },
    );

    final textWidget = Text(
      text,
      style: textStyle,
      textAlign: TextAlign.center,
    );

    return profileAsync.hasValue
        ? GestureDetector(
          onTap: () => context.push('/edit-profile'),
          child:
              (profileAsync.requireValue.username?.isEmpty ?? true)
                  ? Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      textWidget,
                      const SizedBox(width: 10),
                      Icon(
                        Icons.edit,
                        size: 20,
                        color: context.colorScheme.outline,
                      ),
                    ],
                  )
                  : textWidget,
        )
        : textWidget;
  }
}

class UserEmail extends ConsumerWidget {
  const UserEmail({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return Container(
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(20),
        color: Theme.of(context).colorScheme.primaryContainer.withAlpha(150),
      ),
      padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 4),
      child: Text(
        Supabase.instance.client.auth.currentUser?.email ?? '',
        style: Theme.of(
          context,
        ).textTheme.bodyLarge!.apply(color: context.colorScheme.primary),
      ),
    );
  }
}
