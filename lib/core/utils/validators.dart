import 'package:smart_home/core/l10n/app_localizations.dart';

class Validators {
  static String? username(AppLocalizations l10n, String? value) {
    if (value == null || value.trim().isEmpty) {
      return l10n.validatorsUsernameRequired;
    }
    if (value.trim().contains(' ')) {
      return l10n.validatorsUsernameNoSpaces;
    }
    // if (value.trim().length < 3) {
    //   return l10n.validatorsUsernameMinLength(3);
    // }
    return null;
  }

  static String? confirmPassword(
    AppLocalizations l10n,
    String? value,
    String password,
  ) {
    if (value != password) {
      return l10n.validatorsPasswordsDoNotMatch;
    }
    return null;
  }

  static String? password6(AppLocalizations l10n, String? value) {
    if (value?.isEmpty ?? true) {
      return l10n.validatorsFieldRequired;
    }
    if (value!.length < 6) {
      return l10n.validatorsPasswordMinLength(6);
    }
    return null;
  }

  static String? password(AppLocalizations l10n, String? value) {
    if (value?.isEmpty ?? true) {
      return l10n.validatorsFieldRequired;
    }
    if (value!.length < 8) {
      // Assuming you meant 8 characters for the general password validator
      return l10n.validatorsPasswordMinLength(8);
    }
    return null;
  }
}
