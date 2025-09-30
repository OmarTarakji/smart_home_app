import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:smart_home/core/l10n/app_localizations.dart';
import 'package:smart_home/core/utils/extensions.dart';
import 'package:smart_home/core/utils/validators.dart';

import '../../application/auth_provider.dart';

class AuthForm extends ConsumerStatefulWidget {
  final bool confirmPasswordEnabled;
  final String initialUsername;
  final String initialPassword;

  const AuthForm({
    this.confirmPasswordEnabled = false,
    String? initialUsername,
    String? initialPassword,
    super.key,
  }) : initialUsername = initialUsername ?? '',
       initialPassword = initialPassword ?? '';

  @override
  ConsumerState<AuthForm> createState() => _AuthFormState();
}

class _AuthFormState extends ConsumerState<AuthForm> {
  late final TextEditingController _usernameController;
  late final TextEditingController _passwordController;

  @override
  void initState() {
    super.initState();
    _usernameController = TextEditingController(text: widget.initialUsername);
    _passwordController = TextEditingController(text: widget.initialPassword);
  }

  @override
  Widget build(BuildContext context) {
    final l10n = AppLocalizations.of(context)!;
    return Directionality(
      textDirection: TextDirection.ltr,
      child: Column(
        spacing: 20,
        children: [
          _buildUsernameField(context.colorScheme, l10n),
          PasswordField(
            controller: _passwordController,
            label: l10n.password,
            icon: Icons.lock_outline,
            validator: (value) => Validators.password(l10n, value),
            onSaved: (value) {
              ref.read(authProvider.notifier).setPassword(value!);
            },
          ),
          if (widget.confirmPasswordEnabled)
            PasswordField(
              label: l10n.confirmPassword,
              icon: Icons.lock_reset,
              validator: (value) {
                return Validators.confirmPassword(
                  l10n,
                  value,
                  _passwordController.text,
                );
              },
            ),
        ],
      ),
    );
  }

  Widget _buildUsernameField(ColorScheme colorScheme, AppLocalizations l10n) {
    return TextFormField(
      controller: _usernameController,
      decoration: InputDecoration(
        labelText: l10n.username,
        hintText: l10n.enterUsername,
        prefixIcon: const Icon(Icons.person_outline),
        suffix: const Text('@smarthome.com'),
        filled: true,
        fillColor: colorScheme.surface,
        border: OutlineInputBorder(
          borderRadius: BorderRadius.circular(16.0),
          borderSide: BorderSide(color: colorScheme.onSurface.withAlpha(60)),
        ),
        enabledBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(16.0),
          borderSide: BorderSide(color: colorScheme.onSurface.withAlpha(60)),
        ),
      ),
      autocorrect: false,
      enableSuggestions: true,
      textCapitalization: TextCapitalization.none,
      validator: (value) => Validators.username(l10n, value),
      onSaved: (value) {
        ref.read(authProvider.notifier).setUsername(value!);
      },
    );
  }
}

class PasswordField extends StatefulWidget {
  final TextEditingController? controller;
  final String label;
  final IconData icon;
  final String? Function(String?) validator;
  final void Function(String?)? onSaved;

  const PasswordField({
    super.key,
    this.controller,
    required this.label,
    required this.icon,
    required this.validator,
    this.onSaved,
  });

  @override
  State<PasswordField> createState() => _PasswordFieldState();
}

class _PasswordFieldState extends State<PasswordField> {
  bool isObscured = true;

  @override
  Widget build(BuildContext context) {
    return TextFormField(
      controller: widget.controller,
      decoration: InputDecoration(
        labelText: widget.label,
        filled: true,
        border: OutlineInputBorder(
          borderRadius: BorderRadius.circular(16.0),
          borderSide: BorderSide(
            color: context.colorScheme.onSurface.withAlpha(60),
          ),
        ),
        enabledBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(16.0),
          borderSide: BorderSide(
            color: context.colorScheme.onSurface.withAlpha(60),
          ),
        ),
        fillColor: context.colorScheme.surface,
        prefixIcon: Icon(widget.icon),
        suffixIcon: IconButton(
          icon: Icon(isObscured ? Icons.visibility_off : Icons.visibility),
          onPressed: () => setState(() => isObscured = !isObscured),
        ),
      ),
      obscureText: isObscured,
      autocorrect: false,
      validator: widget.validator,
      onSaved: widget.onSaved,
    );
  }
}
