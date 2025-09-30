import 'dart:ui';

import 'package:flutter/foundation.dart';
import 'package:intl/intl.dart';

import '../l10n/app_localizations.dart';
import 'exceptions.dart';

class TextFormatter {
  static String getErrorMessage(dynamic error, AppLocalizations l10n) {
    // Add AppLocalizations parameter
    debugPrint(error.toString());
    if (error is ClientException) {
      if (error.message.contains('Failed host lookup') ||
          error.message.contains('No address associated with hostname')) {
        return l10n.errorNoInternet; // Use localization key
      } else if (error.message.contains('Connection timed out')) {
        return l10n.errorConnectionTimeout; // Use localization key
      }
      return l10n.errorNetworkUnavailable; // Use localization key
    } else if (error is TimeoutException) {
      return l10n.errorRequestTimedOut; // Use localization key
    } else if (error is AuthRetryableFetchException) {
      return l10n.errorNetworkIssue; // Use localization key
    } else if (error is AuthException) {
      return l10n.errorAuthentication(error.message); // Use localization key
    } else if (error is PostgrestException) {
      return l10n.errorDatabase(error.message); // Use localization key
    } else if (error is StorageException) {
      return l10n.errorStorage(error.message); // Use localization key
    } else if (error is ProfileException) {
      return l10n.errorFailedSaveChanges(error.message); // Use localization key
    } else if (error is ImagePickerException) {
      return l10n.errorFailedPickImage(error.message); // Use localization key
    } else if (error is DeviceException) {
      return l10n.errorFailedLinkDevice(error.message); // Use localization key
    } else if (error is PermissionException) {
      if (error.message.contains('Location denied')) {
        return l10n.errorLocationPermissionRequired; // Use localization key
      } else if (error.message.contains('Location permanently denied')) {
        return l10n.errorPermissionDenied; // Use localization key
      }
    } else if (error is NetworkInfoException) {
      return l10n.errorNetwork(error.message); // Use localization key
    } else if (error is ValidatorException) {
      return l10n.errorInvalidInput(error.message); // Use localization key
    } else if (error is DemoAccountException) {
      return l10n.errorActionNotAllowed;
    }
    return l10n.errorUnexpected; // Use localization key
  }

  static String formatDate(
    DateTime timestamp,
    Locale locale,
    AppLocalizations l10n,
  ) {
    // Add AppLocalizations parameter
    final formattedTime = DateFormat.jm([locale]).format(timestamp);

    final now = DateTime.now();
    final yesterday = DateTime(now.year, now.month, now.day - 1);
    final formattedDate =
        timestamp.day == now.day &&
                timestamp.month == now.month &&
                timestamp.year == now.year
            ? l10n
                .dateToday // Use localization key
            : timestamp.day == yesterday.day &&
                timestamp.month == yesterday.month &&
                timestamp.year == yesterday.year
            ? l10n
                .dateYesterday // Use localization key
            : DateFormat.yMMMd().format(timestamp);
    return '$formattedTime $formattedDate';
  }
}
