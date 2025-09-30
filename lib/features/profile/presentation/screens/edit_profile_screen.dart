import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';
import 'package:smart_home/core/l10n/app_localizations.dart';
import 'package:smart_home/core/utils/extensions.dart';
import 'package:smart_home/core/utils/text_formatter.dart';
import 'package:smart_home/core/widgets/confirmation_dialog.dart';
import 'package:smart_home/core/widgets/loading_overlay.dart';
import 'package:smart_home/features/images/domain/loading_state.dart';
import 'package:smart_home/features/profile/application/edit_profile_providers.dart';
import 'package:smart_home/features/profile/domain/profile.dart';

import '../../application/profile_notifier.dart';
import '../widgets/avatar_editor.dart';
import '../widgets/save_button.dart';

class EditProfileScreen extends ConsumerStatefulWidget {
  const EditProfileScreen({super.key});

  @override
  ConsumerState<EditProfileScreen> createState() => _EditProfileScreenState();
}

class _EditProfileScreenState extends ConsumerState<EditProfileScreen> {
  late final TextEditingController _nameController;
  late final Profile profile;

  @override
  initState() {
    super.initState();
    profile = ref.read(profileProvider).requireValue.copyWith();
    _nameController = TextEditingController(text: profile.username);
  }

  @override
  Widget build(BuildContext context) {
    final l10n = AppLocalizations.of(context)!;
    LoadingState loadingState = ref.watch(profileControllerProvider);

    final child = Scaffold(
      appBar: AppBar(title: Text(l10n.editProfileScreenTitle)),
      body: ListView(
        padding: const EdgeInsets.symmetric(horizontal: 8.0),
        children: [
          const SizedBox(height: 16),
          AvatarEditor(imageUrl: profile.avatarUrl, onClear: _clearImage),
          const SizedBox(height: 16),
          _buildNameTextField(l10n),
          const SizedBox(height: 16),
          SaveButton(isLoading: false, onPressed: _onSave),
        ],
      ),
    );

    return PopScope(
      canPop: false,
      onPopInvokedWithResult:
          (didPop, _) => onPop(didPop, loadingState, context, l10n),
      child: Stack(
        children: [
          child,
          if (loadingState != LoadingState.none)
            LoadingOverlay(
              message:
                  loadingState == LoadingState.uploading
                      ? l10n.editProfileUploadingImage
                      : l10n.editProfileUpdatingData,
            ),
        ],
      ),
    );
  }

  @override
  void dispose() {
    _nameController.dispose();
    super.dispose();
  }

  Widget _buildNameTextField(AppLocalizations l10n) {
    return TextField(
      controller: _nameController,
      maxLength: 50,
      decoration: InputDecoration(
        border: OutlineInputBorder(borderRadius: BorderRadius.circular(20)),
        prefixIcon: const Icon(Icons.person_outline_rounded),
        labelText: l10n.deviceQuickOptionsRenameDialogHint,
      ),
    );
  }

  void _clearImage() => profile.avatarUrl = null;

  Future<void> _onSave() async {
    final l10n = AppLocalizations.of(context)!;
    profile.username = _nameController.text;
    try {
      await ref.read(profileControllerProvider.notifier).saveProfile(profile);
      context.showSnackBar(l10n.editProfileSuccessSnackbar);
      if (mounted) context.pop();
    } catch (e) {
      final message = TextFormatter.getErrorMessage(e, l10n);
      context.showErrorSnackBar(message);
    }
  }

  void onPop(
    bool didPop,
    LoadingState ls,
    BuildContext ctx,
    AppLocalizations l10n,
  ) async {
    if (didPop || ls != LoadingState.none) return;
    final shouldPop =
        await showDialog<bool>(
          context: ctx,
          builder:
              (context) => ConfirmationDialog(
                saveText: l10n.editProfileConfirmationDialogSaveChanges,
                onSave: _onSave,
              ),
        ) ??
        false;
    if (shouldPop && ctx.mounted) ctx.pop();
  }
}
