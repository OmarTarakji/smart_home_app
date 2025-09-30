import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';

class LoadingBody extends StatefulWidget {
  final String text;
  const LoadingBody(this.text, {super.key});

  @override
  State<LoadingBody> createState() => _LoadingBodyState();
}

class _LoadingBodyState extends State<LoadingBody>
    with SingleTickerProviderStateMixin {
  late AnimationController _animationController;
  late Animation<double> _animation;

  @override
  void initState() {
    super.initState();
    _animationController = AnimationController(
      duration: const Duration(seconds: 1),
      vsync: this,
    )..repeat(reverse: true);

    _animation = CurvedAnimation(
      parent: _animationController,
      curve: Curves.easeInOut,
    );
  }

  @override
  void dispose() {
    _animationController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          Stack(
            children: [
              AnimatedBuilder(
                animation: _animation,
                builder: (context, child) {
                  return ShaderMask(
                    shaderCallback: (bounds) {
                      final progress = _animation.value.clamp(0.0, 1.0);
                      final colorStop = progress * 0.8 + 0.2;

                      return RadialGradient(
                        center: Alignment.center,
                        radius: 1.75,
                        colors: const [Color(0xFFFFB929), Color(0xFF187282)],
                        stops: [0.0, colorStop],
                        tileMode: TileMode.mirror,
                      ).createShader(bounds);
                    },
                    blendMode: BlendMode.srcIn,
                    child: SvgPicture.asset(
                      'assets/images/loading_background.svg',
                      height: 150,
                    ),
                  );
                },
              ),
              SvgPicture.asset(
                'assets/images/loading_foreground.svg',
                height: 150,
              ),
            ],
          ),
          const SizedBox(height: 16),
          Text(widget.text),
        ],
      ),
    );
  }
}
