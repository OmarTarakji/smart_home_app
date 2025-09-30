import 'package:flutter/material.dart';
import 'package:smart_home/core/l10n/app_localizations.dart';

class ConfirmDeleteDialog extends StatelessWidget {
  const ConfirmDeleteDialog({
    required this.title,
    required this.message,
    this.confirmText,
    super.key,
  });

  final String title;
  final String message;
  final String? confirmText;

  @override
  Widget build(BuildContext context) {
    final l10n = AppLocalizations.of(context)!;

    return AlertDialog(
      icon: Icon(
        Icons.delete_forever_rounded,
        color: Theme.of(context).colorScheme.error,
        size: 65,
      ),
      title: Text(title),
      content: Text(message),
      actions: [
        ElevatedButton(
          onPressed: () => Navigator.pop(context, false),
          child: Text(l10n.exitAndCancel),
        ),
        FilledButton(
          onPressed: () => Navigator.pop(context, true),
          style: FilledButton.styleFrom(
            backgroundColor: Theme.of(context).colorScheme.error,
            foregroundColor: Theme.of(context).colorScheme.onError,
          ),
          child: Text(confirmText ?? l10n.delete),
        ),
      ],
    );
  }
}
