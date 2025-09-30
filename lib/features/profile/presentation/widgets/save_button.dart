import 'package:flutter/material.dart';
import 'package:smart_home/core/l10n/app_localizations.dart';

class SaveButton extends StatelessWidget {
  final bool isLoading;
  final VoidCallback onPressed;

  const SaveButton({
    required this.isLoading,
    required this.onPressed,
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    final l10n = AppLocalizations.of(context)!;

    return isLoading
        ? const FilledButton(
          onPressed: null,
          child: SizedBox(
            height: 30,
            width: 30,
            child: CircularProgressIndicator(),
          ),
        )
        : FilledButton(onPressed: onPressed, child: Text(l10n.save));
  }
}
