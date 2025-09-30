import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';
import 'package:smart_home/core/l10n/app_localizations.dart';
import 'package:smart_home/core/utils/extensions.dart';
import 'package:smart_home/core/utils/text_formatter.dart';
import 'package:smart_home/core/widgets/loading_overlay.dart';

import '../../application/auth_provider.dart';
import '../widgets/auth_form.dart';
import '../widgets/auth_header.dart';
import '../widgets/auth_submit_button.dart';
import '../widgets/auth_title.dart';

class LoginScreen extends ConsumerStatefulWidget {
  const LoginScreen({super.key});

  @override
  ConsumerState<LoginScreen> createState() => _AuthScreenState();
}

class _AuthScreenState extends ConsumerState<LoginScreen> {
  final _formKey = GlobalKey<FormState>();
  late final ProviderSubscription<AsyncValue> _authListener;

  @override
  void initState() {
    super.initState();
    _setupAuthListener(context);
  }

  @override
  void dispose() {
    _authListener.close();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final l10n = AppLocalizations.of(context)!;
    debugPrint('LOG: login screen');
    final authState = ref.watch(authProvider);
    final isLoading = authState.isLoading;

    final gradient = LinearGradient(
      colors: [
        context.colorScheme.tertiaryContainer,
        context.colorScheme.secondaryContainer,
        context.colorScheme.secondaryContainer,
        context.colorScheme.tertiaryContainer,
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
                      AuthTitle(l10n.loginWelcomeBack),
                      const SizedBox(height: 20),
                      _buildCredentialsForm(),
                      const SizedBox(height: 30),
                      AuthSubmitButton(
                        text: l10n.loginButtonText,
                        onPressed: _submitForm,
                      ),
                      const SizedBox(height: 8),
                      OutlinedButton.icon(
                        onPressed: ref.read(authProvider.notifier).loginDemo,
                        style: FilledButton.styleFrom(
                          minimumSize: const Size(double.infinity, 48),
                          backgroundColor: context.colorScheme.primary
                              .withAlpha(30),
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(16),
                          ),
                        ),
                        label: Text(l10n.loginDemoButton),
                      ),
                      const SizedBox(height: 20),
                      ElevatedButton(
                        style: ElevatedButton.styleFrom(
                          minimumSize: const Size(double.infinity, 48),
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(16),
                          ),
                        ),
                        onPressed: () => context.push('/signup'),
                        child: Text(l10n.loginNeedAccount),
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
        if (isLoading) LoadingOverlay(message: l10n.loginLoggingIn),
      ],
    );
  }

  Consumer _buildCredentialsForm() {
    return Consumer(
      builder: (context, ref, child) {
        final credentials = ref.watch(savedCredentialsProvider);
        return credentials.when(
          data:
              (data) => Form(
                key: _formKey,
                child: AuthForm(
                  initialUsername: data.$1,
                  initialPassword: data.$2,
                ),
              ),
          error: (e, _) {
            debugPrint('LOG: credentials read error $e');
            return const SizedBox(height: 132);
          },
          loading: () => const SizedBox(height: 132),
        );
      },
    );
  }

  ///Handle errors from auth provider
  void _setupAuthListener(BuildContext context) {
    _authListener = ref.listenManual(authProvider, (_, next) {
      next.whenOrNull(
        error: (error, _) {
          if (!mounted) return;
          final l10n = AppLocalizations.of(context)!;
          context.showSnackBar(TextFormatter.getErrorMessage(error, l10n));
        },
      );
    });
  }

  void _submitForm() {
    if (!_formKey.currentState!.validate()) return;
    _formKey.currentState?.save();
    ref.read(authProvider.notifier).login();
  }
}
