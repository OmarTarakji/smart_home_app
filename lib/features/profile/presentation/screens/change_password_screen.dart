import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';
import 'package:smart_home/core/constants/demo_account.dart';
import 'package:smart_home/core/l10n/app_localizations.dart';
import 'package:smart_home/core/utils/extensions.dart';
import 'package:smart_home/core/utils/text_formatter.dart';
import 'package:smart_home/core/utils/validators.dart';
import 'package:smart_home/core/widgets/confirmation_dialog.dart';
import 'package:smart_home/features/profile/application/profile_notifier.dart';
import 'package:smart_home/features/profile/presentation/widgets/save_button.dart';

class ChangePasswordScreen extends ConsumerStatefulWidget {
  const ChangePasswordScreen({super.key});

  @override
  ConsumerState<ChangePasswordScreen> createState() =>
      _ChangePasswordScreenState();
}

class _ChangePasswordScreenState extends ConsumerState<ChangePasswordScreen> {
  final formKey = GlobalKey<FormState>();
  final _currentController = TextEditingController();
  final _newController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    final l10n = AppLocalizations.of(context)!;
    final bool isLoading = ref.watch(profileProvider).isLoading;

    return Scaffold(
      appBar: AppBar(title: Text(l10n.changePasswordScreenTitle)),
      body: PopScope(
        canPop: false,
        onPopInvokedWithResult:
            (didPop, _) => onPop(didPop, isLoading, context),
        child: Form(
          key: formKey,
          child: ListView(
            padding: const EdgeInsets.all(16),
            children: [
              // Current Password Field
              _PasswordInput(
                controller: _currentController,
                label: l10n.changePasswordCurrentPasswordLabel,
                icon: Icons.lock,
                validator: (value) => Validators.password(l10n, value),
              ),
              const SizedBox(height: 16),
              // New Password Field
              _PasswordInput(
                controller: _newController,
                label: l10n.changePasswordNewPasswordLabel,
                icon: Icons.lock_outline,
                validator: (value) => Validators.password(l10n, value),
              ),
              const SizedBox(height: 16),

              // Confirm Password Field
              _PasswordInput(
                label: l10n.confirmPassword,
                icon: Icons.lock_reset,
                validator:
                    (value) => Validators.confirmPassword(
                      l10n,
                      value,
                      _newController.text,
                    ),
              ),
              const SizedBox(height: 32),

              // Submit Button
              SaveButton(
                isLoading: isLoading,
                onPressed: () => _handleSubmit(context, ref),
              ),
            ],
          ),
        ),
      ),
    );
  }

  @override
  void dispose() {
    _currentController.dispose();
    _newController.dispose();
    super.dispose();
  }

  Future<void> _handleSubmit(BuildContext context, WidgetRef ref) async {
    final l10n = AppLocalizations.of(context)!;
    if (DemoAccount.isCurrentlyUsed) {
      context.showSnackBar(l10n.errorActionNotAllowed);
      context.pop();
    }
    if (!formKey.currentState!.validate()) return;
    try {
      await ref
          .read(profileProvider.notifier)
          .changePassword(
            currentPassword: _currentController.text,
            newPassword: _newController.text,
          );
      context.showSnackBar(
        l10n.changePasswordSuccessSnackbar,
        clearSnackBars: true,
      );
      if (context.mounted) context.pop();
    } catch (e) {
      context.showErrorSnackBar(TextFormatter.getErrorMessage(e, l10n));
    }
  }

  void onPop(bool didPop, bool isLoading, BuildContext context) async {
    if (didPop || isLoading) return;
    final shouldPop =
        await showDialog<bool>(
          context: context,
          builder: (context) => const ConfirmationDialog(),
        ) ??
        false;
    if (shouldPop && context.mounted) context.pop();
  }
}

class _PasswordInput extends StatefulWidget {
  final TextEditingController? controller;
  final String label;
  final IconData icon;
  final String? Function(String?) validator;

  const _PasswordInput({
    this.controller,
    required this.label,
    required this.icon,
    required this.validator,
  });

  @override
  State<_PasswordInput> createState() => _PasswordInputState();
}

class _PasswordInputState extends State<_PasswordInput> {
  bool _obscureText = true;

  @override
  Widget build(BuildContext context) {
    return TextFormField(
      controller: widget.controller,
      obscureText: _obscureText,
      autocorrect: false,
      decoration: InputDecoration(
        labelText: widget.label,
        prefixIcon: Icon(widget.icon),
        suffixIcon: IconButton(
          icon: Icon(
            _obscureText ? Icons.visibility : Icons.visibility_off,
            color: Theme.of(context).hintColor,
          ),
          onPressed: () => setState(() => _obscureText = !_obscureText),
        ),
      ),
      validator: widget.validator,
    );
  }
}
