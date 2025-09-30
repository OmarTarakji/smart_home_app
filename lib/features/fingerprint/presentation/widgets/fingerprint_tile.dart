import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:smart_home/features/fingerprint/domain/fingerprint.dart';

class FingerprintTile extends StatelessWidget {
  const FingerprintTile(this.fingerprint, {super.key});

  final Fingerprint fingerprint;

  @override
  Widget build(BuildContext context) {
    return ListTile(
      title: Text(fingerprint.name),
      trailing: const Icon(Icons.arrow_forward_ios_rounded, size: 16),
      onTap: () => context.push('/edit-fingerprint', extra: fingerprint),
    );
  }
}
