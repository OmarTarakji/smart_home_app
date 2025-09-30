import 'package:flutter/material.dart';
import 'package:smart_home/core/theme/app_colors.dart';
import 'package:smart_home/core/utils/extensions.dart';

class CustomLevelSlider extends StatefulWidget {
  final double initialValue;
  final ValueChanged<double>? onChanged;
  final bool isOff;

  const CustomLevelSlider({
    super.key,
    this.initialValue = 60,
    this.isOff = true,
    this.onChanged,
  });

  @override
  State<CustomLevelSlider> createState() => _CustomLevelSliderState();
}

class _CustomLevelSliderState extends State<CustomLevelSlider> {
  late double _value;

  @override
  Widget build(BuildContext context) {
    final gradientColors =
        widget.isOff ? AppColors.greyGradient : AppColors.yellowGradient;

    Widget line = Container(
      width: 45,
      height: 2,
      decoration: BoxDecoration(
        color: context.colorScheme.outlineVariant,
        borderRadius: const BorderRadius.all(Radius.circular(2)),
      ),
    );

    return GestureDetector(
      onVerticalDragEnd: (details) {
        widget.onChanged?.call(_value);
      },
      onVerticalDragUpdate: (details) {
        if (widget.onChanged != null) {
          setState(() {
            _value -= details.delta.dy * 0.4; // Adjust sensitivity
            _value = _value.clamp(0.0, 100.0); // Clamp value between 0 and 100
          });
        }
      },
      child: Stack(
        children: [
          Container(
            padding: const EdgeInsets.all(2),
            decoration: BoxDecoration(
              color: context.colorScheme.secondaryContainer.withAlpha(150),
              borderRadius: BorderRadius.circular(20),
              border: Border.all(
                color: context.colorScheme.outline,
                width: 1.5,
                strokeAlign: 1,
              ),
            ),
            clipBehavior: Clip.antiAlias,
            width: 75,
            height: 254,
            child: Stack(
              alignment: Alignment.bottomCenter,
              children: [
                // Lines indicating levels
                Center(
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                    children: List.filled(3, line),
                  ),
                ),
                SizedBox(
                  height: _value * 2.5,
                  child: Container(
                    decoration: BoxDecoration(
                      gradient: LinearGradient(
                        colors: gradientColors,
                        begin: Alignment.centerRight,
                        end: Alignment.centerLeft,
                      ),
                      borderRadius: BorderRadius.circular(18),
                    ),
                  ),
                ),
                Positioned(
                  top: (250 - _value * 2.5) + 7,
                  child: Container(
                    width: 27,
                    height: 6,
                    decoration: const BoxDecoration(
                      color: Colors.white,
                      borderRadius: BorderRadius.all(Radius.circular(10)),
                    ),
                  ),
                ),
                // Text displaying the current value
                Positioned(
                  bottom: 10,
                  child: Text(
                    _value.round().toString(),
                    style: const TextStyle(
                      color: Colors.blueGrey,
                      fontSize: 14,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }

  @override
  void initState() {
    super.initState();
    _value = widget.initialValue.clamp(0.0, 100.0);
  }

  @override
  void didUpdateWidget(CustomLevelSlider oldWidget) {
    super.didUpdateWidget(oldWidget);
    if (oldWidget.initialValue != widget.initialValue) {
      _value = widget.initialValue.clamp(0.0, 100.0);
    }
  }
}
