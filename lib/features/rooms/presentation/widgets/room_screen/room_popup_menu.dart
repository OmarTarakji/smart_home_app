import 'package:flutter/material.dart';
import 'package:smart_home/core/l10n/app_localizations.dart';
import 'package:smart_home/core/utils/extensions.dart';

class RoomPopupMenu extends StatelessWidget {
  final VoidCallback onRename;
  final VoidCallback onDelete;
  final VoidCallback onGallery;
  final VoidCallback onCamera;
  const RoomPopupMenu({
    required this.onRename,
    required this.onCamera,
    required this.onGallery,
    required this.onDelete,
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    final l10n = AppLocalizations.of(context)!;
    return PopupMenuButton<void>(
      icon: Icon(Icons.menu_rounded, color: context.colorScheme.onSurface),
      style: IconButton.styleFrom(
        backgroundColor: context.colorScheme.secondaryContainer,
      ),
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
          const PopupMenuDivider(height: 1),
          PopupMenuItem(
            onTap: onGallery,
            child: ListTile(
              leading: const Icon(Icons.image),
              title: Text(l10n.imageOptionsGalleryButton),
            ),
          ),
          PopupMenuItem(
            onTap: onCamera,
            child: ListTile(
              leading: const Icon(Icons.camera_alt_rounded),
              title: Text(l10n.imageOptionsCameraButton),
            ),
          ),
          const PopupMenuDivider(height: 1),
          PopupMenuItem(
            onTap: onDelete,
            child: ListTile(
              leading: Icon(
                Icons.delete_rounded,
                color: context.colorScheme.error,
              ),
              title: Text(l10n.roomPopupMenuDeleteRoom),
            ),
          ),
        ];
      },
    );
  }
}
