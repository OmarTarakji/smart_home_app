import 'package:flutter/material.dart';
import 'package:smart_home/core/l10n/app_localizations.dart'; // Import AppLocalizations

class ComponentPopupMenu extends StatelessWidget {
  const ComponentPopupMenu({
    required this.onRename,
    required this.onPickIcon,
    List<PopupMenuItem>? extraActions,
    super.key,
  });

  final VoidCallback onRename;
  final VoidCallback onPickIcon;

  @override
  Widget build(BuildContext context) {
    final l10n = AppLocalizations.of(context)!;
    return PopupMenuButton<void>(
      icon: const Icon(Icons.menu_rounded),
      clipBehavior: Clip.antiAlias,
      borderRadius: BorderRadius.circular(50),
      itemBuilder: (BuildContext context) {
        return [
          PopupMenuItem(
            onTap: onRename,
            child: ListTile(
              leading: const Icon(Icons.edit_note_rounded),
              title: Text(l10n.componentPopupMenuRename),
            ),
          ),
          PopupMenuItem(
            onTap: onPickIcon,
            child: ListTile(
              leading: const Icon(Icons.draw),
              title: Text(l10n.componentPopupMenuChangeIcon),
            ),
          ),
        ];
      },
    );
  }
}
