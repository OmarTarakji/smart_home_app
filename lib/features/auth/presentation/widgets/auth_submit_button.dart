import 'package:flutter/material.dart';

class AuthSubmitButton extends StatelessWidget {
  final String text;
  final VoidCallback onPressed;

  const AuthSubmitButton({
    super.key,
    required this.text,
    required this.onPressed,
  });

  @override
  Widget build(BuildContext context) {
    return FilledButton(
      onPressed: onPressed,
      style: FilledButton.styleFrom(
        minimumSize: const Size(double.infinity, 48),
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(16)),
      ),
      child: Text(text),
    );
  }
}
