import 'package:esp_smartconfig/esp_smartconfig.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:permission_handler/permission_handler.dart';
import 'package:smart_home/core/l10n/app_localizations.dart';
import 'package:smart_home/core/utils/extensions.dart';
import 'package:smart_home/core/utils/text_formatter.dart';

import '../../application/wifi_config_provider.dart';

class WifiConfig extends ConsumerWidget {
  WifiConfig({super.key});

  final _formKey = GlobalKey<FormState>();

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final l10n = AppLocalizations.of(context)!;
    final String? ssid = ref.watch(networkProvider).ssid;

    return Padding(
      padding: const EdgeInsets.all(16.0),
      child: Column(
        children: [
          Align(
            alignment: AlignmentDirectional.centerStart,
            child: Text(
              l10n.wifiConfigCredentialsTitle,
              style: const TextStyle(fontSize: 18),
            ),
          ),
          const SizedBox(height: 16),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  mainAxisSize: MainAxisSize.max,
                  children: [
                    Text(
                      l10n.wifiConfigSsidLabel,
                      style: TextStyle(
                        fontSize: 12,
                        color: context.colorScheme.primary,
                      ),
                      textAlign: TextAlign.start,
                    ),
                    Text(
                      overflow: TextOverflow.ellipsis,
                      ssid ?? l10n.wifiConfigSsidNotFound,
                      style: const TextStyle(fontSize: 16),
                    ),
                  ],
                ),
              ),
              TextButton.icon(
                label: Text(l10n.wifiConfigGetSsidButton),
                icon: const Icon(Icons.refresh),
                onPressed: () => _getSsid(context, ref),
              ),
            ],
          ),
          Form(
            key: _formKey,
            child: WifiPasswordTextField(
              onSaved: ref.read(networkProvider.notifier).setPassword,
            ),
          ),
          const SizedBox(height: 16),
          Text(
            l10n.wifiConfigInstructions,
            style: TextStyle(color: Theme.of(context).colorScheme.tertiary),
          ),
          const SizedBox(height: 8),
          FilledButton(
            onPressed: () => _startProvisioning(context, ref),
            child: Text(l10n.wifiConfigStartProvisioningButton),
          ),
        ],
      ),
    );
  }

  Future<void> _startProvisioning(BuildContext context, WidgetRef ref) async {
    final l10n = AppLocalizations.of(context)!;
    // Validate values
    _formKey.currentState!.save();
    final wifiInfo = ref.read(networkProvider);
    if (wifiInfo.ssid == null) {
      context.showSnackBar(
        l10n.wifiConfigMissingArgsSnackbar,
        clearSnackBars: true,
      );
      return;
    }

    final provisioner = Provisioner.espTouch();

    provisioner.listen((response) {
      Navigator.of(context).pop(response);
    });

    provisioner.start(
      ProvisioningRequest.fromStrings(
        ssid: wifiInfo.ssid!,
        bssid: wifiInfo.macAddress,
        password: wifiInfo.password,
      ),
    );

    ProvisioningResponse? response = await showDialog<ProvisioningResponse>(
      context: context,
      builder: (context) {
        return AlertDialog(
          title: Text(l10n.wifiConfigProvisioningDialogTitle),
          content: Text(l10n.wifiConfigProvisioningDialogContent),
          actions: <Widget>[
            TextButton(
              onPressed: () {
                Navigator.of(context).pop();
              },
              child: Text(l10n.wifiConfigStopButton),
            ),
          ],
        );
      },
    );

    if (provisioner.running) {
      provisioner.stop();
    }

    if (response != null) {
      _onDeviceProvisioned(response, context);
    }
  }

  void _onDeviceProvisioned(
    ProvisioningResponse response,
    BuildContext context,
  ) {
    final l10n = AppLocalizations.of(context)!;
    showDialog(
      context: context,
      builder: (context) {
        return AlertDialog(
          title: Text(l10n.wifiConfigDeviceProvisionedDialogTitle),
          content: Column(
            mainAxisSize: MainAxisSize.min,
            children: <Widget>[
              Text(l10n.wifiConfigDeviceProvisionedDialogContentSuccess),
              SizedBox.fromSize(size: const Size.fromHeight(20)),
              Text(l10n.wifiConfigDeviceProvisionedDialogContentDeviceLabel),
              Text(l10n.wifiConfigDialogDeviceIp(response.ipAddressText!)),
              Text(l10n.wifiConfigDialogDeviceBssid(response.bssidText)),
            ],
          ),
          actions: <Widget>[
            TextButton(
              onPressed: () {
                Navigator.of(context).pop();
              },
              child: Text(l10n.dashboardOptionsButtonOK),
            ),
          ],
        );
      },
    );
  }

  void _getSsid(BuildContext context, WidgetRef ref) async {
    final l10n = AppLocalizations.of(context)!;

    try {
      final ssid = await ref.read(networkProvider.notifier).getInfo();
      if (context.mounted) {
        context.showSnackBar(
          l10n.wifiConfigSsidSnackbar(
            ssid.isEmpty ? l10n.wifiConfigSsidNotFound : ssid,
          ),
        );
      }
    } catch (e) {
      final message = TextFormatter.getErrorMessage(e, l10n);
      final action =
          message.contains('Manually allow location')
              ? SnackBarAction(
                label: l10n.wifiConfigOpenSettingsButton,
                onPressed: openAppSettings,
              )
              : null;
      if (context.mounted) {
        context.showErrorSnackBar(message, action: action);
      }
    }
  }
}

class WifiPasswordTextField extends StatefulWidget {
  const WifiPasswordTextField({required this.onSaved, super.key});

  final Function(String? text) onSaved;

  @override
  State<WifiPasswordTextField> createState() => _WifiPasswordTextFieldState();
}

class _WifiPasswordTextFieldState extends State<WifiPasswordTextField> {
  bool obscure = true;

  @override
  Widget build(BuildContext context) {
    final l10n = AppLocalizations.of(context)!;
    return TextFormField(
      decoration: InputDecoration(
        // Use regular text field style with underline
        border: const UnderlineInputBorder(),
        focusedBorder: const UnderlineInputBorder(),
        labelText: l10n.password,
        suffixIcon: IconButton(
          icon: Icon(obscure ? Icons.visibility_off : Icons.visibility),
          onPressed: () => setState(() => obscure = !obscure),
        ),
      ),
      obscureText: obscure,
      validator: (_) => null,

      /// Network may be unprotected
      onSaved: widget.onSaved,
    );
  }
}
