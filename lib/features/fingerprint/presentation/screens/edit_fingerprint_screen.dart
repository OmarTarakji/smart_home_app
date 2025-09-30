import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';
import 'package:smart_home/core/l10n/app_localizations.dart';
import 'package:smart_home/core/utils/exceptions.dart';
import 'package:smart_home/core/utils/extensions.dart';
import 'package:smart_home/core/utils/text_formatter.dart';
import 'package:smart_home/core/widgets/confirm_delete_dialog.dart';
import 'package:smart_home/core/widgets/loading_overlay.dart';
import 'package:smart_home/features/fingerprint/application/fingerprints_provider.dart';
import 'package:smart_home/features/fingerprint/presentation/controllers/edit_fingerprint_controller.dart';

import '../../domain/fingerprint.dart';

class EditFingerprintScreen extends ConsumerStatefulWidget {
  const EditFingerprintScreen(this.fingerprint, {super.key});

  final Fingerprint fingerprint;

  @override
  ConsumerState<EditFingerprintScreen> createState() =>
      _EditFingerprintScreenState();
}

class _EditFingerprintScreenState extends ConsumerState<EditFingerprintScreen> {
  late final TextEditingController _controller = TextEditingController(
    text: widget.fingerprint.name,
  );
  late final notifier = ref.read(
    componentFingerprintsProvider(widget.fingerprint.sensorId).notifier,
  );
  late final stateNotifier = ref.read(editingFingerprintStateProvider.notifier);

  String? nameError;

  @override
  Widget build(BuildContext context) {
    final editingState = ref.watch(editingFingerprintStateProvider);
    final screen = Scaffold(
      appBar: AppBar(
        leading: IconButton(
          icon: const Icon(Icons.close, size: 30),
          onPressed: () => Navigator.pop(context),
        ),
        centerTitle: true,
        actions: [_buildRenameButton(context)],
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          spacing: 40,
          children: [
            const Icon(
              Icons.fingerprint_rounded,
              color: Colors.green,
              size: 100,
            ),
            Column(
              mainAxisSize: MainAxisSize.min,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  '   Change fingerprint name',
                  style: Theme.of(context).textTheme.bodySmall,
                ),
                const SizedBox(height: 5),
                TextField(
                  controller: _controller,
                  decoration: InputDecoration(
                    hintText: 'name',
                    suffixIcon: IconButton(
                      onPressed: _controller.clear,
                      icon: const Icon(Icons.clear),
                    ),
                    error: nameError == null ? null : Text(nameError!),
                  ),
                  maxLength: 50,
                ),
              ],
            ),
            const Spacer(),
            SizedBox(
              width: double.infinity,
              child: _buildDeleteButton(context),
            ),
          ],
        ),
      ),
    );

    return PopScope(
      canPop: editingState == null,
      child: Stack(
        children: [
          screen,
          if (editingState != null) LoadingOverlay(message: editingState),
        ],
      ),
    );
  }

  IconButton _buildRenameButton(BuildContext context) {
    final l10n = AppLocalizations.of(context)!;

    return IconButton(
      icon: const Icon(Icons.check, size: 30),
      onPressed: () async {
        if (_controller.text == widget.fingerprint.name) {
          context.pop();
        } else if (_controller.text.isEmpty) {
          setState(() => nameError = 'this field cannot be empty');
        } else {
          if (nameError != null) setState(() => nameError = null);
          stateNotifier.setState('Renaming fingerprint...');
          try {
            await notifier.renameFingerprint(
              widget.fingerprint.id,
              _controller.text,
            );
            stateNotifier.setState(null);
            if (context.mounted) context.pop();
          } catch (e) {
            stateNotifier.setState(null);
            if (context.mounted) {
              context.showErrorSnackBar(TextFormatter.getErrorMessage(e, l10n));
            }
          }
        }
      },
    );
  }

  @override
  void dispose() {
    super.dispose();
    _controller.dispose();
  }

  Widget _buildDeleteButton(BuildContext context) {
    final l10n = AppLocalizations.of(context)!;

    return FilledButton.icon(
      onPressed: () async {
        final bool delete =
            await showDialog(
              context: context,
              builder:
                  (context) => ConfirmDeleteDialog(
                    title: 'Delete ${widget.fingerprint.name}',
                    message: 'Do you want to delete this fingerprint?',
                    confirmText: 'Delete',
                  ),
            ) ??
            false;
        if (delete) {
          stateNotifier.setState('Deleting fingerprint...');
          try {
            await notifier.deleteFingerprint(
              widget.fingerprint.sensorFingerprintId,
            );
            stateNotifier.setState(null);
            if (context.mounted) context.pop();
          } on FingerprintException catch (e) {
            stateNotifier.setState(null);
            if (context.mounted) context.showErrorDialog(e.title, e.message);
          } catch (e) {
            stateNotifier.setState(null);
            if (context.mounted) {
              debugPrint('LOG: Delete fingerprint error: $e');
              context.showErrorSnackBar(TextFormatter.getErrorMessage(e, l10n));
            }
          }
        }
      },
      icon: const Icon(Icons.delete_forever_rounded),
      label: const Text('Delete'),
      style: FilledButton.styleFrom(
        backgroundColor: Theme.of(context).colorScheme.errorContainer,
        foregroundColor: Theme.of(context).colorScheme.onErrorContainer,
      ),
    );
  }
}
