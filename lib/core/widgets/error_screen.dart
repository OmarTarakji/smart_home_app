import 'package:flutter/material.dart';
import 'package:smart_home/core/l10n/app_localizations.dart';

import '../utils/text_formatter.dart';

class StyledError extends StatelessWidget {
  const StyledError({
    super.key,
    required this.error,
    this.stackTrace,
    this.showLoadingIndicator = true,
  });

  final Object error;
  final StackTrace? stackTrace;
  final bool showLoadingIndicator;

  @override
  Widget build(BuildContext context) {
    final message = TextFormatter.getErrorMessage(
      error,
      AppLocalizations.of(context)!,
    );
    debugPrint('LOG: $error');
    debugPrint('LOG: Stack Trace: $stackTrace');
    return Padding(
      padding: const EdgeInsets.all(16.0),
      child: Column(
        spacing: 20,
        mainAxisSize: MainAxisSize.min,
        children: [
          Icon(
            Icons.error_outline,
            size: 100,
            color: Theme.of(context).colorScheme.error,
          ),
          Text(
            message,
            textAlign: TextAlign.center,
            style: Theme.of(context).textTheme.bodyLarge,
          ),
          if (showLoadingIndicator) const CircularProgressIndicator(),
        ],
      ),
    );
  }
}
