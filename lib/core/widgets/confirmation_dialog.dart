import 'package:flutter/material.dart';

class ConfirmationDialog extends StatelessWidget {
  final String title;
  final String message;
  final String confirmText;
  final String cancelText;
  final String saveText;
  final VoidCallback? onSave;

  const ConfirmationDialog({
    super.key,
    title,
    message,
    confirmText,
    cancelText,
    saveText,
    this.onSave,
  }) : title = title ?? 'Unsaved Changes',
       message =
           message ??
           'Are you sure you want to leave? Your changes will be lost.',
       confirmText = confirmText ?? 'Discard',
       cancelText = cancelText ?? 'Cancel',
       saveText = saveText ?? 'Save';

  @override
  Widget build(BuildContext context) {
    return AlertDialog(
      title: Text(title),
      content: Text(message),
      actionsAlignment: MainAxisAlignment.spaceBetween,
      actions: [
        TextButton(
          onPressed: () => Navigator.pop(context, false),
          child: Text(cancelText),
        ),
        // const Spacer(),
        TextButton(
          onPressed: () => Navigator.pop(context, true),

          child: Text(
            confirmText,
            style: TextStyle(color: Theme.of(context).colorScheme.error),
          ),
        ),
        if (onSave != null)
          FilledButton(
            onPressed: () {
              onSave!();
              Navigator.pop(context);
            },
            child: Text(saveText),
          ),
      ],
    );
  }
}
