import 'dart:async';

import 'package:flutter/foundation.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_localizations/flutter_localizations.dart';
import 'package:intl/intl.dart' as intl;

import 'app_localizations_ar.dart';
import 'app_localizations_en.dart';

// ignore_for_file: type=lint

/// Callers can lookup localized strings with an instance of AppLocalizations
/// returned by `AppLocalizations.of(context)`.
///
/// Applications need to include `AppLocalizations.delegate()` in their app's
/// `localizationDelegates` list, and the locales they support in the app's
/// `supportedLocales` list. For example:
///
/// ```dart
/// import 'l10n/app_localizations.dart';
///
/// return MaterialApp(
///   localizationsDelegates: AppLocalizations.localizationsDelegates,
///   supportedLocales: AppLocalizations.supportedLocales,
///   home: MyApplicationHome(),
/// );
/// ```
///
/// ## Update pubspec.yaml
///
/// Please make sure to update your pubspec.yaml to include the following
/// packages:
///
/// ```yaml
/// dependencies:
///   # Internationalization support.
///   flutter_localizations:
///     sdk: flutter
///   intl: any # Use the pinned version from flutter_localizations
///
///   # Rest of dependencies
/// ```
///
/// ## iOS Applications
///
/// iOS applications define key application metadata, including supported
/// locales, in an Info.plist file that is built into the application bundle.
/// To configure the locales supported by your app, you’ll need to edit this
/// file.
///
/// First, open your project’s ios/Runner.xcworkspace Xcode workspace file.
/// Then, in the Project Navigator, open the Info.plist file under the Runner
/// project’s Runner folder.
///
/// Next, select the Information Property List item, select Add Item from the
/// Editor menu, then select Localizations from the pop-up menu.
///
/// Select and expand the newly-created Localizations item then, for each
/// locale your application supports, add a new item and select the locale
/// you wish to add from the pop-up menu in the Value field. This list should
/// be consistent with the languages listed in the AppLocalizations.supportedLocales
/// property.
abstract class AppLocalizations {
  AppLocalizations(String locale)
    : localeName = intl.Intl.canonicalizedLocale(locale.toString());

  final String localeName;

  static AppLocalizations? of(BuildContext context) {
    return Localizations.of<AppLocalizations>(context, AppLocalizations);
  }

  static const LocalizationsDelegate<AppLocalizations> delegate =
      _AppLocalizationsDelegate();

  /// A list of this localizations delegate along with the default localizations
  /// delegates.
  ///
  /// Returns a list of localizations delegates containing this delegate along with
  /// GlobalMaterialLocalizations.delegate, GlobalCupertinoLocalizations.delegate,
  /// and GlobalWidgetsLocalizations.delegate.
  ///
  /// Additional delegates can be added by appending to this list in
  /// MaterialApp. This list does not have to be used at all if a custom list
  /// of delegates is preferred or required.
  static const List<LocalizationsDelegate<dynamic>> localizationsDelegates =
      <LocalizationsDelegate<dynamic>>[
        delegate,
        GlobalMaterialLocalizations.delegate,
        GlobalCupertinoLocalizations.delegate,
        GlobalWidgetsLocalizations.delegate,
      ];

  /// A list of this localizations delegate's supported locales.
  static const List<Locale> supportedLocales = <Locale>[
    Locale('ar'),
    Locale('en'),
  ];

  /// No description provided for @language.
  ///
  /// In en, this message translates to:
  /// **'English'**
  String get language;

  /// No description provided for @dashboard.
  ///
  /// In en, this message translates to:
  /// **'Dashboard'**
  String get dashboard;

  /// No description provided for @devices.
  ///
  /// In en, this message translates to:
  /// **'Devices'**
  String get devices;

  /// No description provided for @rooms.
  ///
  /// In en, this message translates to:
  /// **'Rooms'**
  String get rooms;

  /// No description provided for @profile.
  ///
  /// In en, this message translates to:
  /// **'Profile'**
  String get profile;

  /// No description provided for @exitAndCancel.
  ///
  /// In en, this message translates to:
  /// **'Cancel'**
  String get exitAndCancel;

  /// No description provided for @delete.
  ///
  /// In en, this message translates to:
  /// **'Delete'**
  String get delete;

  /// No description provided for @loading.
  ///
  /// In en, this message translates to:
  /// **'Loading...'**
  String get loading;

  /// No description provided for @add.
  ///
  /// In en, this message translates to:
  /// **'Add'**
  String get add;

  /// No description provided for @save.
  ///
  /// In en, this message translates to:
  /// **'Save'**
  String get save;

  /// No description provided for @loginWelcomeBack.
  ///
  /// In en, this message translates to:
  /// **'Welcome back'**
  String get loginWelcomeBack;

  /// No description provided for @loginButtonText.
  ///
  /// In en, this message translates to:
  /// **'Log in'**
  String get loginButtonText;

  /// No description provided for @loginDemoButton.
  ///
  /// In en, this message translates to:
  /// **'Demo account'**
  String get loginDemoButton;

  /// No description provided for @loginNeedAccount.
  ///
  /// In en, this message translates to:
  /// **'Need an account? Register Now'**
  String get loginNeedAccount;

  /// No description provided for @loginLoggingIn.
  ///
  /// In en, this message translates to:
  /// **'Logging in...'**
  String get loginLoggingIn;

  /// No description provided for @signupCreateAccountTitle.
  ///
  /// In en, this message translates to:
  /// **'Create Your Account'**
  String get signupCreateAccountTitle;

  /// No description provided for @signupButtonText.
  ///
  /// In en, this message translates to:
  /// **'Sign up'**
  String get signupButtonText;

  /// No description provided for @signupSignInInstead.
  ///
  /// In en, this message translates to:
  /// **'Sign in instead'**
  String get signupSignInInstead;

  /// No description provided for @signupCreatingAccount.
  ///
  /// In en, this message translates to:
  /// **'Creating account...'**
  String get signupCreatingAccount;

  /// No description provided for @password.
  ///
  /// In en, this message translates to:
  /// **'Password'**
  String get password;

  /// No description provided for @confirmPassword.
  ///
  /// In en, this message translates to:
  /// **'Confirm password'**
  String get confirmPassword;

  /// No description provided for @username.
  ///
  /// In en, this message translates to:
  /// **'Username'**
  String get username;

  /// No description provided for @enterUsername.
  ///
  /// In en, this message translates to:
  /// **'Enter username'**
  String get enterUsername;

  /// No description provided for @dashboardLoadingComponents.
  ///
  /// In en, this message translates to:
  /// **'Loading components...'**
  String get dashboardLoadingComponents;

  /// No description provided for @dashboardNoComponentsFound.
  ///
  /// In en, this message translates to:
  /// **'No components found'**
  String get dashboardNoComponentsFound;

  /// No description provided for @dashboardUnassignedRoom.
  ///
  /// In en, this message translates to:
  /// **'Unassigned'**
  String get dashboardUnassignedRoom;

  /// No description provided for @dashboardOptionsLayout.
  ///
  /// In en, this message translates to:
  /// **'Layout:'**
  String get dashboardOptionsLayout;

  /// No description provided for @dashboardOptionsLayoutGrid.
  ///
  /// In en, this message translates to:
  /// **'Grid'**
  String get dashboardOptionsLayoutGrid;

  /// No description provided for @dashboardOptionsLayoutList.
  ///
  /// In en, this message translates to:
  /// **'List'**
  String get dashboardOptionsLayoutList;

  /// No description provided for @dashboardOptionsGroupBy.
  ///
  /// In en, this message translates to:
  /// **'Group by:'**
  String get dashboardOptionsGroupBy;

  /// No description provided for @dashboardOptionsGroupByNone.
  ///
  /// In en, this message translates to:
  /// **'None'**
  String get dashboardOptionsGroupByNone;

  /// No description provided for @dashboardOptionsGroupByRoom.
  ///
  /// In en, this message translates to:
  /// **'Room'**
  String get dashboardOptionsGroupByRoom;

  /// No description provided for @dashboardOptionsGroupByDevice.
  ///
  /// In en, this message translates to:
  /// **'Device'**
  String get dashboardOptionsGroupByDevice;

  /// No description provided for @dashboardOptionsButtonOK.
  ///
  /// In en, this message translates to:
  /// **'OK'**
  String get dashboardOptionsButtonOK;

  /// No description provided for @fingerprintManage.
  ///
  /// In en, this message translates to:
  /// **'Manage fingerprints'**
  String get fingerprintManage;

  /// No description provided for @fingerprintScanHistory.
  ///
  /// In en, this message translates to:
  /// **'Scan history'**
  String get fingerprintScanHistory;

  /// No description provided for @latestActivities.
  ///
  /// In en, this message translates to:
  /// **'Latest Activities'**
  String get latestActivities;

  /// No description provided for @flameSensorNoActivities.
  ///
  /// In en, this message translates to:
  /// **'No Activities yet'**
  String get flameSensorNoActivities;

  /// No description provided for @flameSensorFlameDetected.
  ///
  /// In en, this message translates to:
  /// **'Flame detected'**
  String get flameSensorFlameDetected;

  /// No description provided for @stateIndicatorSyncing.
  ///
  /// In en, this message translates to:
  /// **'Syncing...'**
  String get stateIndicatorSyncing;

  /// No description provided for @stateIndicatorSynced.
  ///
  /// In en, this message translates to:
  /// **'Synced'**
  String get stateIndicatorSynced;

  /// No description provided for @stateIndicatorError.
  ///
  /// In en, this message translates to:
  /// **'Error'**
  String get stateIndicatorError;

  /// No description provided for @morningHour.
  ///
  /// In en, this message translates to:
  /// **'{hour} AM'**
  String morningHour(String hour);

  /// No description provided for @eveningHour.
  ///
  /// In en, this message translates to:
  /// **'{hour} PM'**
  String eveningHour(String hour);

  /// No description provided for @componentPopupMenuRename.
  ///
  /// In en, this message translates to:
  /// **'Rename'**
  String get componentPopupMenuRename;

  /// No description provided for @componentPopupMenuChangeIcon.
  ///
  /// In en, this message translates to:
  /// **'Change icon'**
  String get componentPopupMenuChangeIcon;

  /// No description provided for @componentValueNoReadingsYet.
  ///
  /// In en, this message translates to:
  /// **'No readings yet'**
  String get componentValueNoReadingsYet;

  /// No description provided for @componentValueUnhandledComponent.
  ///
  /// In en, this message translates to:
  /// **'Unhandled Component'**
  String get componentValueUnhandledComponent;

  /// No description provided for @errorNoInternet.
  ///
  /// In en, this message translates to:
  /// **'No internet connection. Please check your network and try again.'**
  String get errorNoInternet;

  /// No description provided for @errorConnectionTimeout.
  ///
  /// In en, this message translates to:
  /// **'Connection timeout. The server might be busy.'**
  String get errorConnectionTimeout;

  /// No description provided for @errorNetwork.
  ///
  /// In en, this message translates to:
  /// **'Network error: {errorMessage}'**
  String errorNetwork(String errorMessage);

  /// No description provided for @errorNetworkUnavailable.
  ///
  /// In en, this message translates to:
  /// **'Network unavailable. Please check your internet connection.'**
  String get errorNetworkUnavailable;

  /// No description provided for @errorRequestTimedOut.
  ///
  /// In en, this message translates to:
  /// **'Request timed out. Please try again later.'**
  String get errorRequestTimedOut;

  /// No description provided for @errorNetworkIssue.
  ///
  /// In en, this message translates to:
  /// **'Network issue detected. Please check your connection.'**
  String get errorNetworkIssue;

  /// No description provided for @errorAuthentication.
  ///
  /// In en, this message translates to:
  /// **'Authentication error: {errorMessage}'**
  String errorAuthentication(String errorMessage);

  /// No description provided for @errorDatabase.
  ///
  /// In en, this message translates to:
  /// **'Database error: {errorMessage}'**
  String errorDatabase(String errorMessage);

  /// No description provided for @errorStorage.
  ///
  /// In en, this message translates to:
  /// **'File storage error: {errorMessage}'**
  String errorStorage(String errorMessage);

  /// No description provided for @errorFailedSaveChanges.
  ///
  /// In en, this message translates to:
  /// **'Failed to save changes: {errorMessage}'**
  String errorFailedSaveChanges(String errorMessage);

  /// No description provided for @errorFailedPickImage.
  ///
  /// In en, this message translates to:
  /// **'Failed to pick image: {errorMessage}'**
  String errorFailedPickImage(String errorMessage);

  /// No description provided for @errorFailedLinkDevice.
  ///
  /// In en, this message translates to:
  /// **'Failed to link device: {errorMessage}'**
  String errorFailedLinkDevice(String errorMessage);

  /// No description provided for @errorLocationPermissionRequired.
  ///
  /// In en, this message translates to:
  /// **'Location permission is required for Wi-Fi configuration'**
  String get errorLocationPermissionRequired;

  /// No description provided for @errorPermissionDenied.
  ///
  /// In en, this message translates to:
  /// **'Permission has been denied, Manually allow location permission from settings.'**
  String get errorPermissionDenied;

  /// No description provided for @errorInvalidInput.
  ///
  /// In en, this message translates to:
  /// **'Invalid input: {errorMessage}'**
  String errorInvalidInput(String errorMessage);

  /// No description provided for @errorActionNotAllowed.
  ///
  /// In en, this message translates to:
  /// **'This action is not allowed on a demo account'**
  String get errorActionNotAllowed;

  /// No description provided for @errorUnexpected.
  ///
  /// In en, this message translates to:
  /// **'An unexpected error occurred.'**
  String get errorUnexpected;

  /// No description provided for @dateToday.
  ///
  /// In en, this message translates to:
  /// **'Today'**
  String get dateToday;

  /// No description provided for @dateYesterday.
  ///
  /// In en, this message translates to:
  /// **'Yesterday'**
  String get dateYesterday;

  /// No description provided for @componentNameTemperature.
  ///
  /// In en, this message translates to:
  /// **'Temperature'**
  String get componentNameTemperature;

  /// No description provided for @componentNameHumidity.
  ///
  /// In en, this message translates to:
  /// **'Humidity'**
  String get componentNameHumidity;

  /// No description provided for @componentNameWaterLevel.
  ///
  /// In en, this message translates to:
  /// **'Water Level'**
  String get componentNameWaterLevel;

  /// No description provided for @componentNameGas.
  ///
  /// In en, this message translates to:
  /// **'Gas Detector'**
  String get componentNameGas;

  /// No description provided for @componentNameFlame.
  ///
  /// In en, this message translates to:
  /// **'Flame Sensor'**
  String get componentNameFlame;

  /// No description provided for @componentNamePir.
  ///
  /// In en, this message translates to:
  /// **'Motion Sensor'**
  String get componentNamePir;

  /// No description provided for @componentNameLdr.
  ///
  /// In en, this message translates to:
  /// **'Light Sensor'**
  String get componentNameLdr;

  /// No description provided for @componentNameFingerprint.
  ///
  /// In en, this message translates to:
  /// **'Fingerprint Scanner'**
  String get componentNameFingerprint;

  /// No description provided for @componentNameWindow.
  ///
  /// In en, this message translates to:
  /// **'Window'**
  String get componentNameWindow;

  /// No description provided for @componentNameDoor.
  ///
  /// In en, this message translates to:
  /// **'Door'**
  String get componentNameDoor;

  /// No description provided for @componentNameLight.
  ///
  /// In en, this message translates to:
  /// **'Light'**
  String get componentNameLight;

  /// No description provided for @componentNameBuzzer.
  ///
  /// In en, this message translates to:
  /// **'Buzzer'**
  String get componentNameBuzzer;

  /// No description provided for @componentNameSecurity.
  ///
  /// In en, this message translates to:
  /// **'Security System'**
  String get componentNameSecurity;

  /// No description provided for @devicesScreenTitle.
  ///
  /// In en, this message translates to:
  /// **'Your Devices'**
  String get devicesScreenTitle;

  /// No description provided for @devicesScreenAddDeviceButton.
  ///
  /// In en, this message translates to:
  /// **'Add device'**
  String get devicesScreenAddDeviceButton;

  /// No description provided for @devicesScreenNeedInternetAccess.
  ///
  /// In en, this message translates to:
  /// **'You need internet access!'**
  String get devicesScreenNeedInternetAccess;

  /// No description provided for @devicesScreenLoadingList.
  ///
  /// In en, this message translates to:
  /// **'Loading devices list...'**
  String get devicesScreenLoadingList;

  /// No description provided for @devicesScreenUntitledDevice.
  ///
  /// In en, this message translates to:
  /// **'Untitled'**
  String get devicesScreenUntitledDevice;

  /// No description provided for @linkDeviceModalAlreadyLinked.
  ///
  /// In en, this message translates to:
  /// **'This device is already linked to your account'**
  String get linkDeviceModalAlreadyLinked;

  /// No description provided for @linkDeviceModalLinkButton.
  ///
  /// In en, this message translates to:
  /// **'Link this device'**
  String get linkDeviceModalLinkButton;

  /// No description provided for @newDeviceScreenWifiConfigHeader.
  ///
  /// In en, this message translates to:
  /// **'Connecting device to Wi-Fi network using ESP-Touch protocol'**
  String get newDeviceScreenWifiConfigHeader;

  /// No description provided for @newDeviceScreenDeviceDiscoveryHeader.
  ///
  /// In en, this message translates to:
  /// **'Select the device you want to link from the list:'**
  String get newDeviceScreenDeviceDiscoveryHeader;

  /// No description provided for @newDeviceScreenAppBarTitle.
  ///
  /// In en, this message translates to:
  /// **'Link a device'**
  String get newDeviceScreenAppBarTitle;

  /// No description provided for @newDeviceScreenWifiNetworkNote.
  ///
  /// In en, this message translates to:
  /// **'Make sure you are connected to the same Wi-Fi network as the device you want to link.'**
  String get newDeviceScreenWifiNetworkNote;

  /// No description provided for @newDeviceScreenLinkingDeviceProgress.
  ///
  /// In en, this message translates to:
  /// **'Linking device...'**
  String get newDeviceScreenLinkingDeviceProgress;

  /// No description provided for @deviceDetailsUntitledDevice.
  ///
  /// In en, this message translates to:
  /// **'Untitled'**
  String get deviceDetailsUntitledDevice;

  /// No description provided for @deviceDetailsDeviceTypeLabel.
  ///
  /// In en, this message translates to:
  /// **'Device type'**
  String get deviceDetailsDeviceTypeLabel;

  /// No description provided for @deviceDetailsMacAddressLabel.
  ///
  /// In en, this message translates to:
  /// **'MAC Address'**
  String get deviceDetailsMacAddressLabel;

  /// No description provided for @deviceDetailsDateAddedLabel.
  ///
  /// In en, this message translates to:
  /// **'Date added'**
  String get deviceDetailsDateAddedLabel;

  /// No description provided for @deviceDetailsSensorsLabel.
  ///
  /// In en, this message translates to:
  /// **'Sensors'**
  String get deviceDetailsSensorsLabel;

  /// No description provided for @deviceDetailsControlsLabel.
  ///
  /// In en, this message translates to:
  /// **'Controls'**
  String get deviceDetailsControlsLabel;

  /// No description provided for @deviceDiscoveryMacAddressLabel.
  ///
  /// In en, this message translates to:
  /// **'MAC Address: '**
  String get deviceDiscoveryMacAddressLabel;

  /// No description provided for @deviceDiscoveryLinkedSuccess.
  ///
  /// In en, this message translates to:
  /// **'Device linked successfully'**
  String get deviceDiscoveryLinkedSuccess;

  /// No description provided for @deviceDiscoveryLinkFailedTitle.
  ///
  /// In en, this message translates to:
  /// **'Failed to link device'**
  String get deviceDiscoveryLinkFailedTitle;

  /// No description provided for @deviceDiscoveryRefreshButton.
  ///
  /// In en, this message translates to:
  /// **'Refresh'**
  String get deviceDiscoveryRefreshButton;

  /// No description provided for @deviceDiscoveryNoDevicesFound.
  ///
  /// In en, this message translates to:
  /// **'No devices found'**
  String get deviceDiscoveryNoDevicesFound;

  /// No description provided for @deviceDiscoveryVpnWarning.
  ///
  /// In en, this message translates to:
  /// **'If you have a VPN running, turn it off then try again.'**
  String get deviceDiscoveryVpnWarning;

  /// No description provided for @deviceQuickOptionsEditButton.
  ///
  /// In en, this message translates to:
  /// **'Edit'**
  String get deviceQuickOptionsEditButton;

  /// No description provided for @deviceQuickOptionsInfoButton.
  ///
  /// In en, this message translates to:
  /// **'Info'**
  String get deviceQuickOptionsInfoButton;

  /// No description provided for @deviceQuickOptionsUnlinkButton.
  ///
  /// In en, this message translates to:
  /// **'Unlink'**
  String get deviceQuickOptionsUnlinkButton;

  /// No description provided for @deviceQuickOptionsUnlinkDialogTitle.
  ///
  /// In en, this message translates to:
  /// **'Unlink {deviceNameOrType}'**
  String deviceQuickOptionsUnlinkDialogTitle(String deviceNameOrType);

  /// No description provided for @deviceQuickOptionsUnlinkDialogMessage.
  ///
  /// In en, this message translates to:
  /// **'This will remove the device and all of its components from your account!'**
  String get deviceQuickOptionsUnlinkDialogMessage;

  /// No description provided for @deviceQuickOptionsUnlinkDialogConfirmButton.
  ///
  /// In en, this message translates to:
  /// **'Unlink'**
  String get deviceQuickOptionsUnlinkDialogConfirmButton;

  /// No description provided for @deviceQuickOptionsUnlinkSuccessSnackbar.
  ///
  /// In en, this message translates to:
  /// **'Device unlinked successfully'**
  String get deviceQuickOptionsUnlinkSuccessSnackbar;

  /// No description provided for @deviceQuickOptionsRenameDialogTitle.
  ///
  /// In en, this message translates to:
  /// **'Rename Device'**
  String get deviceQuickOptionsRenameDialogTitle;

  /// No description provided for @deviceQuickOptionsRenameSuccessSnackbar.
  ///
  /// In en, this message translates to:
  /// **'Device renamed to {newName}'**
  String deviceQuickOptionsRenameSuccessSnackbar(String newName);

  /// No description provided for @deviceQuickOptionsRenameDialogHint.
  ///
  /// In en, this message translates to:
  /// **'Name'**
  String get deviceQuickOptionsRenameDialogHint;

  /// No description provided for @deviceQuickOptionsRenameDialogCancelButton.
  ///
  /// In en, this message translates to:
  /// **'Cancel'**
  String get deviceQuickOptionsRenameDialogCancelButton;

  /// No description provided for @deviceQuickOptionsRenameDialogSaveButton.
  ///
  /// In en, this message translates to:
  /// **'Save'**
  String get deviceQuickOptionsRenameDialogSaveButton;

  /// No description provided for @udpDeviceDetailsIpAddressLabel.
  ///
  /// In en, this message translates to:
  /// **'IP Address'**
  String get udpDeviceDetailsIpAddressLabel;

  /// No description provided for @wifiConfigCredentialsTitle.
  ///
  /// In en, this message translates to:
  /// **'Your WiFi Credentials:'**
  String get wifiConfigCredentialsTitle;

  /// No description provided for @wifiConfigSsidLabel.
  ///
  /// In en, this message translates to:
  /// **'SSID (Network name)'**
  String get wifiConfigSsidLabel;

  /// No description provided for @wifiConfigSsidNotFound.
  ///
  /// In en, this message translates to:
  /// **'Not found!'**
  String get wifiConfigSsidNotFound;

  /// No description provided for @wifiConfigGetSsidButton.
  ///
  /// In en, this message translates to:
  /// **'Get SSID'**
  String get wifiConfigGetSsidButton;

  /// No description provided for @wifiConfigInstructions.
  ///
  /// In en, this message translates to:
  /// **'On the device: Hold down the reset button for 3 seconds then tap \"Start Provisioning\" button.'**
  String get wifiConfigInstructions;

  /// No description provided for @wifiConfigStartProvisioningButton.
  ///
  /// In en, this message translates to:
  /// **'Start provisioning'**
  String get wifiConfigStartProvisioningButton;

  /// No description provided for @wifiConfigMissingArgsSnackbar.
  ///
  /// In en, this message translates to:
  /// **'Missing arguments! Provisioning was not started.'**
  String get wifiConfigMissingArgsSnackbar;

  /// No description provided for @wifiConfigProvisioningDialogTitle.
  ///
  /// In en, this message translates to:
  /// **'Provisioning'**
  String get wifiConfigProvisioningDialogTitle;

  /// No description provided for @wifiConfigProvisioningDialogContent.
  ///
  /// In en, this message translates to:
  /// **'Provisioning started. Please wait...'**
  String get wifiConfigProvisioningDialogContent;

  /// No description provided for @wifiConfigStopButton.
  ///
  /// In en, this message translates to:
  /// **'Stop'**
  String get wifiConfigStopButton;

  /// No description provided for @wifiConfigDeviceProvisionedDialogTitle.
  ///
  /// In en, this message translates to:
  /// **'Device provisioned'**
  String get wifiConfigDeviceProvisionedDialogTitle;

  /// No description provided for @wifiConfigDeviceProvisionedDialogContentSuccess.
  ///
  /// In en, this message translates to:
  /// **'Device successfully connected to the network'**
  String get wifiConfigDeviceProvisionedDialogContentSuccess;

  /// No description provided for @wifiConfigDeviceProvisionedDialogContentDeviceLabel.
  ///
  /// In en, this message translates to:
  /// **'Device:'**
  String get wifiConfigDeviceProvisionedDialogContentDeviceLabel;

  /// No description provided for @wifiConfigDialogDeviceIp.
  ///
  /// In en, this message translates to:
  /// **'IP: {ipAddressText}'**
  String wifiConfigDialogDeviceIp(String ipAddressText);

  /// No description provided for @wifiConfigDialogDeviceBssid.
  ///
  /// In en, this message translates to:
  /// **'BSSID: {bssidText}'**
  String wifiConfigDialogDeviceBssid(String bssidText);

  /// No description provided for @wifiConfigSsidSnackbar.
  ///
  /// In en, this message translates to:
  /// **'SSID: {ssid}'**
  String wifiConfigSsidSnackbar(String ssid);

  /// No description provided for @wifiConfigOpenSettingsButton.
  ///
  /// In en, this message translates to:
  /// **'Open settings'**
  String get wifiConfigOpenSettingsButton;

  /// No description provided for @imageOptionsCameraButton.
  ///
  /// In en, this message translates to:
  /// **'Camera'**
  String get imageOptionsCameraButton;

  /// No description provided for @imageOptionsGalleryButton.
  ///
  /// In en, this message translates to:
  /// **'Gallery'**
  String get imageOptionsGalleryButton;

  /// No description provided for @imageOptionsRemoveButton.
  ///
  /// In en, this message translates to:
  /// **'Remove'**
  String get imageOptionsRemoveButton;

  /// No description provided for @notificationsScreenTitle.
  ///
  /// In en, this message translates to:
  /// **'Notifications'**
  String get notificationsScreenTitle;

  /// No description provided for @notificationsScreenNoNotifications.
  ///
  /// In en, this message translates to:
  /// **'No notifications'**
  String get notificationsScreenNoNotifications;

  /// No description provided for @notificationsScreenGroupThisWeek.
  ///
  /// In en, this message translates to:
  /// **'This Week'**
  String get notificationsScreenGroupThisWeek;

  /// No description provided for @notificationsScreenGroupOlder.
  ///
  /// In en, this message translates to:
  /// **'Older'**
  String get notificationsScreenGroupOlder;

  /// No description provided for @notificationsScreenLoading.
  ///
  /// In en, this message translates to:
  /// **'Loading notifications...'**
  String get notificationsScreenLoading;

  /// No description provided for @changePasswordScreenTitle.
  ///
  /// In en, this message translates to:
  /// **'Change Password'**
  String get changePasswordScreenTitle;

  /// No description provided for @changePasswordCurrentPasswordLabel.
  ///
  /// In en, this message translates to:
  /// **'Current Password'**
  String get changePasswordCurrentPasswordLabel;

  /// No description provided for @changePasswordNewPasswordLabel.
  ///
  /// In en, this message translates to:
  /// **'New Password'**
  String get changePasswordNewPasswordLabel;

  /// No description provided for @changePasswordSuccessSnackbar.
  ///
  /// In en, this message translates to:
  /// **'Password changed successfully'**
  String get changePasswordSuccessSnackbar;

  /// No description provided for @editProfileScreenTitle.
  ///
  /// In en, this message translates to:
  /// **'Edit Profile'**
  String get editProfileScreenTitle;

  /// No description provided for @editProfileUploadingImage.
  ///
  /// In en, this message translates to:
  /// **'Uploading image...'**
  String get editProfileUploadingImage;

  /// No description provided for @editProfileUpdatingData.
  ///
  /// In en, this message translates to:
  /// **'Updating data...'**
  String get editProfileUpdatingData;

  /// No description provided for @editProfileSuccessSnackbar.
  ///
  /// In en, this message translates to:
  /// **'Profile was updated successfully.'**
  String get editProfileSuccessSnackbar;

  /// No description provided for @editProfileConfirmationDialogSaveChanges.
  ///
  /// In en, this message translates to:
  /// **'Save Changes'**
  String get editProfileConfirmationDialogSaveChanges;

  /// No description provided for @profileActionsLogOut.
  ///
  /// In en, this message translates to:
  /// **'Log Out'**
  String get profileActionsLogOut;

  /// No description provided for @appInfoLanguageLabel.
  ///
  /// In en, this message translates to:
  /// **'Language'**
  String get appInfoLanguageLabel;

  /// No description provided for @appInfoContactSupport.
  ///
  /// In en, this message translates to:
  /// **'Contact support'**
  String get appInfoContactSupport;

  /// No description provided for @changeLanguageDialogTitle.
  ///
  /// In en, this message translates to:
  /// **'Change Language'**
  String get changeLanguageDialogTitle;

  /// No description provided for @profileAddName.
  ///
  /// In en, this message translates to:
  /// **'Add a name'**
  String get profileAddName;

  /// No description provided for @profileFailedToLoad.
  ///
  /// In en, this message translates to:
  /// **'Failed to load user information!'**
  String get profileFailedToLoad;

  /// No description provided for @profileLoadingUserInformation.
  ///
  /// In en, this message translates to:
  /// **'Loading user information...'**
  String get profileLoadingUserInformation;

  /// No description provided for @addRoomScreenTitle.
  ///
  /// In en, this message translates to:
  /// **'Add Room'**
  String get addRoomScreenTitle;

  /// No description provided for @roomsScreenTitle.
  ///
  /// In en, this message translates to:
  /// **'Rooms'**
  String get roomsScreenTitle;

  /// No description provided for @roomsScreenAddRoomButton.
  ///
  /// In en, this message translates to:
  /// **'Add Room'**
  String get roomsScreenAddRoomButton;

  /// No description provided for @deleteRoomDialogTitle.
  ///
  /// In en, this message translates to:
  /// **'Delete {name}?'**
  String deleteRoomDialogTitle(String name);

  /// No description provided for @deleteRoomDialogLoadingText.
  ///
  /// In en, this message translates to:
  /// **'Deleting room...'**
  String get deleteRoomDialogLoadingText;

  /// No description provided for @renameRoomDialogTitle.
  ///
  /// In en, this message translates to:
  /// **'Rename Room'**
  String get renameRoomDialogTitle;

  /// No description provided for @renameRoomDialogNewNameLabel.
  ///
  /// In en, this message translates to:
  /// **'New name'**
  String get renameRoomDialogNewNameLabel;

  /// No description provided for @renameRoomDialogEmptyNameError.
  ///
  /// In en, this message translates to:
  /// **'Name cannot be empty'**
  String get renameRoomDialogEmptyNameError;

  /// No description provided for @roomPopupMenuDeleteRoom.
  ///
  /// In en, this message translates to:
  /// **'Delete room'**
  String get roomPopupMenuDeleteRoom;

  /// No description provided for @componentsPickerLoadingComponents.
  ///
  /// In en, this message translates to:
  /// **'Loading components...'**
  String get componentsPickerLoadingComponents;

  /// No description provided for @componentsPickerNoComponentsFound.
  ///
  /// In en, this message translates to:
  /// **'No smart components found'**
  String get componentsPickerNoComponentsFound;

  /// No description provided for @componentsPickerOtherDevices.
  ///
  /// In en, this message translates to:
  /// **'Other Devices'**
  String get componentsPickerOtherDevices;

  /// No description provided for @componentsPickerPickComponentsTitle.
  ///
  /// In en, this message translates to:
  /// **'Pick Components'**
  String get componentsPickerPickComponentsTitle;

  /// No description provided for @fallbackSomethingWentWrong.
  ///
  /// In en, this message translates to:
  /// **'Something went wrong'**
  String get fallbackSomethingWentWrong;

  /// No description provided for @roomDeletedSuccess.
  ///
  /// In en, this message translates to:
  /// **'Room {name} deleted'**
  String roomDeletedSuccess(String name);

  /// No description provided for @actionFailedError.
  ///
  /// In en, this message translates to:
  /// **'Action failed: {error}'**
  String actionFailedError(String error);

  /// No description provided for @roomImageEditorUploadFailed.
  ///
  /// In en, this message translates to:
  /// **'Upload failed'**
  String get roomImageEditorUploadFailed;

  /// No description provided for @roomImageEditorRetryButton.
  ///
  /// In en, this message translates to:
  /// **'Retry'**
  String get roomImageEditorRetryButton;

  /// No description provided for @validatorsUsernameRequired.
  ///
  /// In en, this message translates to:
  /// **'Username is required'**
  String get validatorsUsernameRequired;

  /// No description provided for @validatorsUsernameNoSpaces.
  ///
  /// In en, this message translates to:
  /// **'Username cannot contain spaces'**
  String get validatorsUsernameNoSpaces;

  /// No description provided for @validatorsUsernameMinLength.
  ///
  /// In en, this message translates to:
  /// **'Username must be at least {length} characters'**
  String validatorsUsernameMinLength(int length);

  /// No description provided for @validatorsPasswordsDoNotMatch.
  ///
  /// In en, this message translates to:
  /// **'Passwords do not match'**
  String get validatorsPasswordsDoNotMatch;

  /// No description provided for @validatorsFieldRequired.
  ///
  /// In en, this message translates to:
  /// **'This field is required'**
  String get validatorsFieldRequired;

  /// No description provided for @validatorsPasswordMinLength.
  ///
  /// In en, this message translates to:
  /// **'Password must be at least {length} characters'**
  String validatorsPasswordMinLength(int length);
}

class _AppLocalizationsDelegate
    extends LocalizationsDelegate<AppLocalizations> {
  const _AppLocalizationsDelegate();

  @override
  Future<AppLocalizations> load(Locale locale) {
    return SynchronousFuture<AppLocalizations>(lookupAppLocalizations(locale));
  }

  @override
  bool isSupported(Locale locale) =>
      <String>['ar', 'en'].contains(locale.languageCode);

  @override
  bool shouldReload(_AppLocalizationsDelegate old) => false;
}

AppLocalizations lookupAppLocalizations(Locale locale) {
  // Lookup logic when only language code is specified.
  switch (locale.languageCode) {
    case 'ar':
      return AppLocalizationsAr();
    case 'en':
      return AppLocalizationsEn();
  }

  throw FlutterError(
    'AppLocalizations.delegate failed to load unsupported locale "$locale". This is likely '
    'an issue with the localizations generation tool. Please file an issue '
    'on GitHub with a reproducible sample app and the gen-l10n configuration '
    'that was used.',
  );
}
