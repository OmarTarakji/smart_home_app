import 'package:flutter/material.dart';

class VerticalButton extends StatelessWidget {
  final IconData icon;
  final String label;
  final VoidCallback? onPressed;
  final double? width;
  final double? height;
  final Color? color;
  final Color? background;

  const VerticalButton({
    required this.icon,
    required this.label,
    this.onPressed,
    this.width,
    this.height,
    this.color,
    this.background,
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.symmetric(vertical: 3, horizontal: 6),
      width: width,
      height: height,
      child: InkWell(
        borderRadius: BorderRadius.circular(12),
        onTap: onPressed,
        child: Ink(
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(12),
            color: background,
          ),
          padding: const EdgeInsets.symmetric(vertical: 6),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              Icon(icon, size: 24, color: color),
              const SizedBox(height: 8),
              Text(
                label,
                softWrap: false,
                overflow: TextOverflow.fade,
                style: Theme.of(
                  context,
                ).textTheme.labelMedium!.copyWith(color: color),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
