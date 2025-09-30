import 'package:dotted_border/dotted_border.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:smart_home/core/constants/images.dart';
import 'package:smart_home/core/l10n/app_localizations.dart';
import 'package:smart_home/core/utils/extensions.dart';

class AddRoomButton extends StatelessWidget {
  final double radius;
  final double padding;
  final VoidCallback onTap;

  const AddRoomButton({
    required this.radius,
    required this.padding,
    required this.onTap,
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    final l10n = AppLocalizations.of(context)!;
    final color = context.colorScheme.secondary;

    return Padding(
      padding: EdgeInsets.only(
        top: padding,
        right: padding,
        left: padding,
        bottom: 24 + padding,
      ),
      child: InkWell(
        borderRadius: BorderRadius.circular(radius),
        highlightColor: color.withAlpha(26),
        splashColor: color.withAlpha(52),
        onTap: onTap,
        child: DottedBorder(
          options: CircularDottedBorderOptions(
            stackFit: StackFit.expand,
            color: color,
            padding: const EdgeInsets.all(1.5),
            strokeWidth: 3,
            dashPattern: const [5, 5],
          ),
          child: Padding(
            padding: const EdgeInsets.symmetric(vertical: 8.0),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: [
                if (radius > 70) const SizedBox(height: 20),
                SvgPicture.asset(
                  Images.ADD,
                  width: radius * 0.9,
                  colorFilter: ColorFilter.mode(
                    context.colorScheme.secondary,
                    BlendMode.srcIn,
                  ),
                ),
                if (radius > 70)
                  Text(
                    l10n.roomsScreenAddRoomButton,
                    style: Theme.of(context).textTheme.bodyMedium!.copyWith(
                      color: context.colorScheme.secondary,
                    ),
                  ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
