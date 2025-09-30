import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:go_router/go_router.dart';
import 'package:smart_home/core/constants/images.dart';
import 'package:smart_home/core/l10n/app_localizations.dart';
import 'package:smart_home/core/utils/exceptions.dart';
import 'package:smart_home/core/utils/extensions.dart';
import 'package:smart_home/core/utils/text_formatter.dart';
import 'package:smart_home/core/widgets/confirm_delete_dialog.dart';
import 'package:smart_home/core/widgets/loading_overlay.dart';
import 'package:smart_home/features/fingerprint/application/fingerprints_provider.dart';
import 'package:smart_home/features/fingerprint/domain/fingerprint.dart';

import '../controllers/edit_fingerprint_controller.dart';
import '../widgets/fingerprint_tile.dart';

class FingerprintsManagerScreen extends ConsumerWidget {
  const FingerprintsManagerScreen(this.componentId, {super.key});

  final int componentId;

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final fingerprintsAsync = ref.watch(
      componentFingerprintsProvider(componentId),
    );
    final editingState = ref.watch(editingFingerprintStateProvider);

    final screen = Scaffold(
      appBar: AppBar(
        title: const Text('Saved Fingerprints'),
        centerTitle: true,
      ),
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.all(12.0),
          child: Column(
            spacing: 10,
            children: [
              Padding(
                padding: const EdgeInsets.all(10.0),
                child: SvgPicture.asset(
                  Images.FINGERPRINT_SETTINGS,
                  height: 120,
                ),
              ),
              Text(
                'Adding/Deleting fingerprints requires you to be connected to the same Wi-Fi network as the smart device.',
                style: Theme.of(context).textTheme.bodyMedium?.copyWith(
                  color: Theme.of(context).colorScheme.onTertiaryContainer,
                ),
              ),
              fingerprintsAsync.when(
                data: (fingerprints) => _buildData(fingerprints, context, ref),
                error: (error, _) => _buildError(error, context, ref),
                loading: () => const Center(child: CircularProgressIndicator()),
              ),
            ],
          ),
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

  Widget _buildError(Object error, BuildContext context, WidgetRef ref) {
    final l10n = AppLocalizations.of(context)!;

    debugPrint('LOG: $error');
    return Column(
      spacing: 20,
      mainAxisSize: MainAxisSize.min,
      children: [
        Icon(
          Icons.error_outline,
          size: 75,
          color: Theme.of(context).colorScheme.error,
        ),
        Text(
          TextFormatter.getErrorMessage(error, l10n),
          textAlign: TextAlign.center,
          style: Theme.of(context).textTheme.bodyLarge?.copyWith(
            color: Theme.of(context).colorScheme.error,
          ),
        ),
        FilledButton(
          onPressed: () {
            ref.invalidate(componentFingerprintsProvider(componentId));
          },
          child: const Text('Try again'),
        ),
      ],
    );
  }

  Widget _buildData(
    List<Fingerprint> fingerprints,
    BuildContext context,
    WidgetRef ref,
  ) {
    return Column(
      spacing: 16,
      children: [
        ListView.builder(
          shrinkWrap: true,
          physics: const NeverScrollableScrollPhysics(),
          itemCount: fingerprints.length,
          itemBuilder: (context, index) {
            return FingerprintTile(fingerprints[index]);
          },
        ),
        (fingerprints.length < 128)
            ? ElevatedButton(
              onPressed: () async {
                final bool success =
                    await context.push(
                      '/add-fingerprint',
                      extra: componentId,
                    ) ??
                    false;
                if (success) {
                  ref.invalidate(componentFingerprintsProvider(componentId));
                }
              },
              child: const Text('Add fingerprint'),
            )
            : const Text('Reached maximum number of fingerprints'),
        if (fingerprints.isNotEmpty)
          FilledButton(
            onPressed: () => _onDeleteAllPressed(context, ref),
            style: FilledButton.styleFrom(
              backgroundColor: Theme.of(context).colorScheme.error,
              foregroundColor: Theme.of(context).colorScheme.onError,
            ),
            child: const Text('Delete all'),
          ),
      ],
    );
  }

  void _onDeleteAllPressed(BuildContext context, WidgetRef ref) async {
    final l10n = AppLocalizations.of(context)!;

    final bool confirmed =
        await showDialog(
          context: context,
          builder:
              (context) => const ConfirmDeleteDialog(
                title: 'Delete all fingerprints?',
                message: '',
                confirmText: 'Delete',
              ),
        ) ??
        false;
    if (!confirmed) return;
    final notifier = ref.read(
      componentFingerprintsProvider(componentId).notifier,
    );
    final stateNotifier = ref.read(editingFingerprintStateProvider.notifier);
    stateNotifier.setState('Deleting all fingerprints...');
    try {
      await notifier.deleteAll();
    } on FingerprintException catch (e) {
      if (context.mounted) {
        context.showErrorDialog('Failed to delete fingerprints', e.message);
      }
    } catch (e) {
      if (context.mounted) {
        debugPrint(e.toString());
        context.showErrorSnackBar(TextFormatter.getErrorMessage(e, l10n));
      }
    }
    stateNotifier.setState(null);
  }
}
