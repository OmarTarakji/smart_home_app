import 'package:flutter/material.dart';

TextTheme createTextTheme(
  BuildContext context,
  String bodyFontFamily,
  String displayFontFamily,
) {
  TextTheme baseTextTheme = Theme.of(context).textTheme;

  // Create text themes using the custom font families
  TextTheme bodyTextTheme = baseTextTheme.apply(fontFamily: bodyFontFamily);

  TextTheme displayTextTheme = baseTextTheme.apply(
    fontFamily: displayFontFamily,
  );

  // Combine the text themes
  TextTheme textTheme = displayTextTheme.copyWith(
    bodyLarge: bodyTextTheme.bodyLarge,
    bodyMedium: bodyTextTheme.bodyMedium,
    bodySmall: bodyTextTheme.bodySmall,
    labelLarge: bodyTextTheme.labelLarge,
    labelMedium: bodyTextTheme.labelMedium,
    labelSmall: bodyTextTheme.labelSmall,
  );

  return textTheme;
}
