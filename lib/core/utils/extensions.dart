import 'package:flutter/material.dart';

extension ContextExtension on BuildContext {
  void showErrorDialog(String label, String message) {
    showDialog(
      context: this,
      builder:
          (context) => AlertDialog(
            title: Text(label),
            icon: Icon(
              Icons.error_outline,
              color: Theme.of(context).colorScheme.error,
              size: 75,
            ),
            content: Text(message),
            actions: [
              TextButton(
                onPressed: () => Navigator.pop(context),
                child: const Text('OK'),
              ),
            ],
          ),
    );
  }

  void showErrorSnackBar(String message, {SnackBarAction? action}) =>
      showSnackBar(
        message,
        isError: true,
        clearSnackBars: true,
        action: action,
      );

  void showSnackBar(
    String message, {
    bool isError = false,
    bool clearSnackBars = false,
    SnackBarAction? action,
  }) {
    if (clearSnackBars) ScaffoldMessenger.of(this).clearSnackBars();

    ScaffoldMessenger.of(this).showSnackBar(
      SnackBar(
        content: Text(
          message,
          style: Theme.of(this).textTheme.bodyMedium!.copyWith(
            color:
                isError
                    ? Theme.of(this).colorScheme.onErrorContainer
                    : Theme.of(this).colorScheme.onInverseSurface,
          ),
        ),
        backgroundColor:
            isError
                ? Theme.of(this).colorScheme.errorContainer
                : Theme.of(this).snackBarTheme.backgroundColor,
        action: action,
      ),
    );
  }

  ColorScheme get colorScheme => Theme.of(this).colorScheme;
}
