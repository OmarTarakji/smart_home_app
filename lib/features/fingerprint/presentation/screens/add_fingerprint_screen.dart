import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';
import 'package:smart_home/core/l10n/app_localizations.dart';
import 'package:smart_home/core/utils/exceptions.dart';
import 'package:smart_home/core/utils/extensions.dart';
import 'package:smart_home/core/utils/text_formatter.dart';
import 'package:smart_home/features/fingerprint/application/fingerprints_provider.dart';

import '../../domain/add_fingerprint_state.dart';
import '../controllers/add_fingerprint_controller.dart';
import '../widgets/add_fingerprint_overlay.dart';

class AddFingerprintScreen extends ConsumerStatefulWidget {
  const AddFingerprintScreen(this.sensorId, {super.key});

  final int sensorId;

  @override
  ConsumerState<AddFingerprintScreen> createState() =>
      _AddFingerprintScreenState();
}

class _AddFingerprintScreenState extends ConsumerState<AddFingerprintScreen> {
  final _controller = TextEditingController();
  String? nameError;

  @override
  void initState() {
    super.initState();
    ref.listenManual(addFingerprintProvider, (previous, next) {
      if (next.state == AddFpState.success) {
        context.pop(true);
      }
    });
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final l10n = AppLocalizations.of(context)!;
    final notifier = ref.read(
      componentFingerprintsProvider(widget.sensorId).notifier,
    );
    final addResponse = ref.watch(addFingerprintProvider);
    final body = Scaffold(
      appBar: AppBar(title: Text(l10n.addFingerprintScreenTitle)),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: ListView(
          children: [
            Text(
              '   ${l10n.fingerprintNameTitle}',
              style: Theme.of(context).textTheme.bodySmall,
            ),
            const SizedBox(height: 5),
            TextField(
              controller: _controller,
              autofocus: true,
              decoration: InputDecoration(
                suffixIcon: IconButton(
                  onPressed: _controller.clear,
                  icon: const Icon(Icons.clear),
                ),
                error: nameError == null ? null : Text(nameError!),
              ),
              maxLength: 50,
            ),
            const SizedBox(height: 30),
            FilledButton(
              onPressed: () async {
                if (_controller.text.isEmpty) {
                  setState(() => nameError = l10n.fingerprintNameEmpty);
                } else {
                  try {
                    await notifier.enrollFingerprint(
                      widget.sensorId,
                      _controller.text,
                    );
                  } on FingerprintException catch (error) {
                    context.showErrorDialog(error.title, error.message);
                  } catch (error, st) {
                    debugPrint('LOG: Error $error $st');
                    context.showErrorSnackBar(
                      TextFormatter.getErrorMessage(error, l10n),
                    );
                  }
                }
              },
              child: Text(l10n.addFingerprintNext),
            ),
          ],
        ),
      ),
    );

    return Stack(
      children: [
        body,
        if (addResponse.state != AddFpState.none)
          AddFingerprintOverlay(addResponse),
      ],
    );
  }
}
