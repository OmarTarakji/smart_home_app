import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

class LoadingOverlay extends ConsumerWidget {
  const LoadingOverlay({super.key, this.message});

  final Widget? child = null;
  final String? message;

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return Scaffold(
      backgroundColor: Colors.black.withAlpha(60),
      body: Center(
        child: Container(
          decoration: BoxDecoration(
            color: Colors.black.withAlpha(122),
            borderRadius: BorderRadius.circular(30),
          ),
          padding: const EdgeInsets.all(25),
          margin: const EdgeInsets.all(25),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              _buildLoadingIndicator(),
              if (message != null) _buildLoadingMessage(message!),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildLoadingMessage(String message) {
    return Column(
      children: [
        const SizedBox(height: 20),
        Text(message, style: const TextStyle(color: Colors.white)),
      ],
    );
  }

  Widget _buildLoadingIndicator() {
    return Container(
      margin: const EdgeInsets.symmetric(horizontal: 30),
      width: 60,
      height: 60,
      child: const CircularProgressIndicator(
        strokeWidth: 6,
        color: Colors.white70,
      ),
    );
  }
}
