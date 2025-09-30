import 'package:flutter/material.dart';
import 'package:smart_home/core/utils/extensions.dart';

class AuthHeader extends StatelessWidget {
  const AuthHeader({super.key});

  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisSize: MainAxisSize.min,
      children: [
        const Padding(
          padding: EdgeInsets.symmetric(horizontal: 20, vertical: 10),
          child: Image(
            image: AssetImage('assets/images/login-image.png'),
            width: 300,
          ),
        ),
        const SizedBox(height: 10),
        ShaderMask(
          blendMode: BlendMode.srcIn,
          shaderCallback:
              (bounds) => LinearGradient(
                colors: [
                  context.colorScheme.onPrimaryContainer,
                  context.colorScheme.tertiary,
                ],
                begin: Alignment.bottomCenter,
                end: Alignment.topCenter,
              ).createShader(Rect.fromLTWH(0, 0, bounds.width, bounds.height)),
          child: Text(
            'Smart Home',
            style: Theme.of(
              context,
            ).textTheme.displaySmall?.copyWith(fontWeight: FontWeight.bold),
          ),
        ),
      ],
    );
  }
}
