import 'package:flutter/material.dart';
import 'package:smart_home/core/l10n/app_localizations.dart';

class DeleteRoomDialog extends StatelessWidget {
  final String name;

  const DeleteRoomDialog({required this.name, super.key});

  @override
  Widget build(BuildContext context) {
    final l10n = AppLocalizations.of(context)!;
    return AlertDialog(
      title: Text(l10n.deleteRoomDialogTitle(name)),
      actions: [
        TextButton(
          onPressed: () => Navigator.pop(context, false),
          child: Text(l10n.exitAndCancel),
        ),
        TextButton(
          onPressed: () => Navigator.pop(context, true),
          child: Text(
            l10n.delete,
            style: TextStyle(color: Theme.of(context).colorScheme.error),
          ),
        ),
      ],
    );
  }
}

class DeleteLoadingDialog extends StatelessWidget {
  const DeleteLoadingDialog({super.key});

  @override
  Widget build(BuildContext context) {
    final l10n = AppLocalizations.of(context)!;
    return PopScope(
      canPop: false,
      child: AlertDialog(
        content: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            const CircularProgressIndicator(),
            const SizedBox(height: 16),
            Text(l10n.deleteRoomDialogLoadingText),
          ],
        ),
      ),
    );
  }
}
