import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:smart_home/core/l10n/app_localizations.dart'; // Import AppLocalizations
import 'package:smart_home/core/utils/extensions.dart';
import 'package:smart_home/core/widgets/loading_overlay.dart';

import '../../application/auth_provider.dart';
import '../widgets/auth_form.dart';
import '../widgets/auth_header.dart';
import '../widgets/auth_submit_button.dart';
import '../widgets/auth_title.dart';

class SignUpScreen extends ConsumerWidget {
  const SignUpScreen({super.key});

  void _submitForm(WidgetRef ref, GlobalKey<FormState> key) {
    if (!key.currentState!.validate()) return;
    key.currentState?.save();
    ref.read(authProvider.notifier).signUp();
  }

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final l10n = AppLocalizations.of(context)!;
    debugPrint('LOG: sign up screen');
    final formKey = GlobalKey<FormState>();

    final authState = ref.watch(authProvider);
    final isLoading = authState.isLoading;
    final gradient = LinearGradient(
      colors: [
        context.colorScheme.primaryContainer,
        context.colorScheme.secondaryContainer,
        context.colorScheme.secondaryContainer,
        context.colorScheme.primaryContainer,
      ],
      begin: Alignment.centerLeft,
      end: Alignment.centerRight,
    ).withOpacity(0.5);

    final child = Scaffold(
      body: Container(
        decoration: BoxDecoration(gradient: gradient),
        child: SafeArea(
          child: CustomScrollView(
            slivers: [
              SliverFillRemaining(
                hasScrollBody: false,
                child: Padding(
                  padding: const EdgeInsets.all(16.0),
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      const AuthHeader(),
                      const SizedBox(height: 30),
                      AuthTitle(l10n.signupCreateAccountTitle),
                      const SizedBox(height: 20),
                      Form(
                        key: formKey,
                        child: const AuthForm(confirmPasswordEnabled: true),
                      ),
                      const SizedBox(height: 30),
                      AuthSubmitButton(
                        text: l10n.signupButtonText,
                        onPressed: () => _submitForm(ref, formKey),
                      ),
                      const SizedBox(height: 20),
                      const Spacer(),
                      TextButton(
                        child: Text(l10n.signupSignInInstead),
                        onPressed: () => Navigator.pop(context),
                      ),
                    ],
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );

    return Stack(
      children: [
        child,
        if (isLoading)
          LoadingOverlay(
            message: l10n.signupCreatingAccount,
          ), // Use localization key
      ],
    );
  }
}
