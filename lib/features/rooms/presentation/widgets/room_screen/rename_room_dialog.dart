import 'package:flutter/material.dart';
import 'package:smart_home/core/l10n/app_localizations.dart';

class RenameRoomDialog extends StatefulWidget {
  final String name;

  const RenameRoomDialog(this.name, {super.key});

  @override
  State<RenameRoomDialog> createState() => _RenameRoomDialogState();
}

class _RenameRoomDialogState extends State<RenameRoomDialog> {
  late final TextEditingController _controller;
  String? error;

  @override
  void initState() {
    super.initState();
    _controller = TextEditingController(text: widget.name);
  }

  @override
  Widget build(BuildContext context) {
    final l10n = AppLocalizations.of(context)!;

    return AlertDialog(
      title: Text(l10n.renameRoomDialogTitle),
      content: TextField(
        controller: _controller,
        decoration: InputDecoration(labelText: l10n.renameRoomDialogNewNameLabel, errorText: error),
        maxLength: 25,
      ),
      actions: [
        TextButton(
          onPressed: () => Navigator.pop(context),
          child: Text(l10n.exitAndCancel),
        ),
        TextButton(
          onPressed: () {
            if (_controller.text.isEmpty) {
              setState(() => error = l10n.renameRoomDialogEmptyNameError);
              return;
            }
            Navigator.pop(context, _controller.text);
          },
          child: Text(l10n.save),
        ),
      ],
    );
  }
}
