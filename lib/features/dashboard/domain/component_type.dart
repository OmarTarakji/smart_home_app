import 'package:flutter/material.dart';
import 'package:smart_home/core/l10n/app_localizations.dart';

import '../../../core/constants/images.dart';

enum CSType { control, sensor }

enum ComponentType {
  temperature(Icons.thermostat, CSType.sensor, Images.THERMOSTAT),
  humidity(Icons.water_drop, CSType.sensor, Images.WATER_DROP),
  waterLevel(Icons.water, CSType.sensor, Images.WATER_TANK),
  gas(Icons.air, CSType.sensor, Images.GAS),
  flame(Icons.local_fire_department, CSType.sensor, Images.FIRE),
  pir(Icons.directions_run, CSType.sensor, Images.MOTION_SENSOR),
  ldr(Icons.light_mode, CSType.sensor, Images.LIGHT_SENSOR),
  fingerprint(Icons.fingerprint, CSType.sensor, Images.FINGERPRINT),
  window(Icons.window, CSType.control, Images.WINDOW),
  door(Icons.sensor_door, CSType.control, Images.DOOR),
  light(Icons.lightbulb, CSType.control, Images.BULB),
  buzzer(Icons.notifications_active, CSType.control, Images.BELL),
  security(Icons.shield, CSType.control, Images.SECURITY);

  final IconData icon;
  final CSType type;
  final String defaultImage;

  const ComponentType(this.icon, this.type, this.defaultImage);

  String getLocalizedName(BuildContext context) {
    final l10n = AppLocalizations.of(context);
    // Fallback to enum name if AppLocalizations is not available,
    // though in a correctly set up app, it should be.
    if (l10n == null) return name;

    switch (this) {
      case ComponentType.temperature:
        return l10n.componentNameTemperature;
      case ComponentType.humidity:
        return l10n.componentNameHumidity;
      case ComponentType.waterLevel:
        return l10n.componentNameWaterLevel;
      case ComponentType.gas:
        return l10n.componentNameGas;
      case ComponentType.flame:
        return l10n.componentNameFlame;
      case ComponentType.pir:
        return l10n.componentNamePir;
      case ComponentType.ldr:
        return l10n.componentNameLdr;
      case ComponentType.fingerprint:
        return l10n.componentNameFingerprint;
      case ComponentType.window:
        return l10n.componentNameWindow;
      case ComponentType.door:
        return l10n.componentNameDoor;
      case ComponentType.light:
        return l10n.componentNameLight;
      case ComponentType.buzzer:
        return l10n.componentNameBuzzer;
      case ComponentType.security:
        return l10n.componentNameSecurity;
    }
  }

  static ComponentType from(String comType) => ComponentType.values.firstWhere(
    (e) => e.name == comType,
    orElse: () => throw ArgumentError('Unknown component type: \$comType'),
  );
}
