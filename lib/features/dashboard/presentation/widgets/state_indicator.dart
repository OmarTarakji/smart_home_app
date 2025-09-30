import 'dart:math' show pi;

import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:smart_home/core/l10n/app_localizations.dart'; // Import AppLocalizations
import 'package:smart_home/core/utils/extensions.dart';

import '../../domain/data_state.dart';
import '../controllers/dashboard_screen_providers.dart';

class StateIndicator extends ConsumerStatefulWidget {
  const StateIndicator({super.key});

  @override
  ConsumerState<StateIndicator> createState() => _StateIndicatorState();
}

class _StateIndicatorState extends ConsumerState<StateIndicator>
    with SingleTickerProviderStateMixin {
  late AnimationController _animationController;
  late Animation<Offset> _slideAnimation;
  Future? _delayedFuture;

  @override
  void initState() {
    super.initState();
    _animationController = AnimationController(
      duration: const Duration(milliseconds: 450),
      vsync: this,
    );
    _slideAnimation = Tween<Offset>(
      begin: const Offset(0, -0.3),
      end: Offset.zero,
    ).animate(
      CurvedAnimation(parent: _animationController, curve: Curves.easeOut),
    );
  }

  @override
  void dispose() {
    _delayedFuture?.ignore();
    _animationController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final l10n = AppLocalizations.of(context)!; // Get AppLocalizations instance
    final state = ref.watch(readingsStateProvider);

    WidgetsBinding.instance.addPostFrameCallback((_) {
      if (state == DataState.syncing || state == DataState.error) {
        _animationController.forward();
      } else if (state == DataState.synced) {
        _delayedFuture = Future.delayed(const Duration(seconds: 2), () {
          if (_animationController.status == AnimationStatus.completed) {
            _animationController.reverse();
          }
        });
      }
    });

    return SlideTransition(
      position: _slideAnimation,
      child: Align(
        alignment: Alignment.topCenter,
        child: Container(
          margin: const EdgeInsets.only(top: 40),
          padding: const EdgeInsetsDirectional.only(
            start: 10,
            end: 14,
            top: 8,
            bottom: 8,
          ),
          decoration: BoxDecoration(
            color: context.colorScheme.surface,
            boxShadow: [
              BoxShadow(blurRadius: 2, color: Colors.grey.withAlpha(150)),
            ],
            borderRadius: BorderRadius.circular(20),
          ),
          child: Row(
            mainAxisSize: MainAxisSize.min,
            children: [
              SizedBox(width: 24, height: 24, child: _getStateIcon(state)),
              const SizedBox(width: 5),
              Text(
                _getStateText(state, l10n), // Pass l10n
                style: Theme.of(context).textTheme.bodyMedium!,
              ),
            ],
          ),
        ),
      ),
    );
  }

  String _getStateText(DataState state, AppLocalizations l10n) {
    // Add AppLocalizations parameter
    return switch (state) {
      DataState.syncing => l10n.stateIndicatorSyncing, // Use localization key
      DataState.synced => l10n.stateIndicatorSynced, // Use localization key
      DataState.error => l10n.stateIndicatorError, // Use localization key
    };
  }

  Widget _getStateIcon(DataState state) => switch (state) {
    DataState.syncing || DataState.error => const SpinningSyncIcon(),
    DataState.synced => const Icon(Icons.check, color: Colors.green, size: 20),
  };
}

class SpinningSyncIcon extends StatefulWidget {
  const SpinningSyncIcon({super.key});

  @override
  State<SpinningSyncIcon> createState() => _SpinningSyncIconState();
}

class _SpinningSyncIconState extends State<SpinningSyncIcon>
    with SingleTickerProviderStateMixin {
  late final AnimationController _controller;

  @override
  void initState() {
    super.initState();
    _controller = AnimationController(
      vsync: this,
      duration: const Duration(seconds: 1),
    )..repeat();
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return AnimatedBuilder(
      animation: _controller,
      builder: (context, child) {
        return Transform.rotate(
          angle: -_controller.value * 2 * pi,
          child: child,
        );
      },
      child: const Icon(Icons.sync, size: 20),
    );
  }
}
