import 'package:flutter/material.dart';
import 'package:smart_home/core/l10n/app_localizations.dart';

class LanguageDialog extends StatefulWidget {
  const LanguageDialog(this.initialLanguage, {super.key});

  final String initialLanguage;

  @override
  State<LanguageDialog> createState() => _LanguageDialogState();
}

class _LanguageDialogState extends State<LanguageDialog> {
  late String _selectedLanguage;

  @override
  void initState() {
    _selectedLanguage = widget.initialLanguage;
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    final l10n = AppLocalizations.of(context)!;
    return AlertDialog(
      title: Center(child: Text(l10n.changeLanguageDialogTitle)),
      content: SegmentedButton<String>(
        style: SegmentedButton.styleFrom(
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadiusGeometry.circular(20),
          ),
          visualDensity: const VisualDensity(horizontal: 2, vertical: 4),
        ),
        expandedInsets: const EdgeInsets.all(10),
        segments: const <ButtonSegment<String>>[
          ButtonSegment<String>(value: 'en', label: Text('English')),
          ButtonSegment<String>(value: 'ar', label: Text('العربية')),
        ],
        selected: {_selectedLanguage},
        onSelectionChanged: (Set<String> newSelection) {
          setState(() {
            _selectedLanguage = newSelection.first;
          });
        },
      ),
      actions: <Widget>[
        TextButton(
          onPressed: () {
            Navigator.of(context).pop(_selectedLanguage);
          },
          child: Text(l10n.dashboardOptionsButtonOK),
        ),
      ],
    );
  }
}
