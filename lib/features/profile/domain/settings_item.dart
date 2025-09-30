import 'package:flutter/material.dart';

class SettingsItem {
  final IconData icon;
  final String label;
  final VoidCallback? onTap;

  const SettingsItem({required this.icon, required this.label, this.onTap});
}
