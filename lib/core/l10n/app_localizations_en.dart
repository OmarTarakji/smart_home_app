// ignore: unused_import
import 'package:intl/intl.dart' as intl;
import 'app_localizations.dart';

// ignore_for_file: type=lint

/// The translations for English (`en`).
class AppLocalizationsEn extends AppLocalizations {
  AppLocalizationsEn([String locale = 'en']) : super(locale);

  @override
  String get language => 'English';

  @override
  String get dashboard => 'Dashboard';

  @override
  String get devices => 'Devices';

  @override
  String get rooms => 'Rooms';

  @override
  String get profile => 'Profile';

  @override
  String get exitAndCancel => 'Cancel';

  @override
  String get delete => 'Delete';

  @override
  String get loading => 'Loading...';

  @override
  String get saving => 'Saving...';

  @override
  String get add => 'Add';

  @override
  String get save => 'Save';

  @override
  String get loginWelcomeBack => 'Welcome back';

  @override
  String get loginButtonText => 'Log in';

  @override
  String get loginDemoButton => 'Demo account';

  @override
  String get loginNeedAccount => 'Need an account? Register Now';

  @override
  String get loginLoggingIn => 'Logging in...';

  @override
  String get signupCreateAccountTitle => 'Create Your Account';

  @override
  String get signupButtonText => 'Sign up';

  @override
  String get signupSignInInstead => 'Sign in instead';

  @override
  String get signupCreatingAccount => 'Creating account...';

  @override
  String get password => 'Password';

  @override
  String get confirmPassword => 'Confirm password';

  @override
  String get username => 'Username';

  @override
  String get enterUsername => 'Enter username';

  @override
  String get dashboardLoadingComponents => 'Loading components...';

  @override
  String get dashboardNoComponentsFound => 'No components found';

  @override
  String get dashboardUnassignedRoom => 'Unassigned';

  @override
  String get dashboardOptionsLayout => 'Layout:';

  @override
  String get dashboardOptionsLayoutGrid => 'Grid';

  @override
  String get dashboardOptionsLayoutList => 'List';

  @override
  String get dashboardOptionsGroupBy => 'Group by:';

  @override
  String get dashboardOptionsGroupByNone => 'None';

  @override
  String get dashboardOptionsGroupByRoom => 'Room';

  @override
  String get dashboardOptionsGroupByDevice => 'Device';

  @override
  String get dashboardOptionsButtonOK => 'OK';

  @override
  String get fingerprintManage => 'Manage fingerprints';

  @override
  String get fingerprintScanHistory => 'Scan history';

  @override
  String get fingerprintNoHistory => 'No scan history';

  @override
  String get manageFingerprintsNote =>
      'Adding/Deleting fingerprints requires you to be connected to the same Wi-Fi network as the smart device.';

  @override
  String get fingerprintsErrorReloadButton => 'Try again';

  @override
  String get fingerprintAddButton => 'Add fingerprint';

  @override
  String get fingerprintsMaxNumber => 'Maximum number of fingerprints reached';

  @override
  String get fingerprintsDeleteAllButton => 'Delete all';

  @override
  String get fingerprintsDeleteDialog => 'Delete all fingerprints?';

  @override
  String get fingerprintsDeleting => 'Deleting all fingerprints...';

  @override
  String get fingerprintsDeleteAllError => 'Failed to delete fingerprints';

  @override
  String fingerprintDelete(String name) {
    return 'Delete \$$name';
  }

  @override
  String get fingerprintDeleteDialog =>
      'Do you want to delete this fingerprint?';

  @override
  String get fingerprintDeleting => 'Deleting fingerprint...';

  @override
  String get addFingerprintScreenTitle => 'Add Fingerprint';

  @override
  String get fingerprintNameTitle => 'Name:';

  @override
  String get fingerprintNameEmpty => 'This field cannot be empty';

  @override
  String get addFingerprintNext => 'Next';

  @override
  String get latestActivities => 'Latest Activities';

  @override
  String get flameSensorNoActivities => 'No Activities yet';

  @override
  String get flameSensorFlameDetected => 'Flame detected';

  @override
  String get stateIndicatorSyncing => 'Syncing...';

  @override
  String get stateIndicatorSynced => 'Synced';

  @override
  String get stateIndicatorError => 'Error';

  @override
  String morningHour(String hour) {
    return '$hour AM';
  }

  @override
  String eveningHour(String hour) {
    return '$hour PM';
  }

  @override
  String get componentPopupMenuRename => 'Rename';

  @override
  String get componentPopupMenuChangeIcon => 'Change icon';

  @override
  String get componentValueNoReadingsYet => 'No readings yet';

  @override
  String get componentValueUnhandledComponent => 'Unhandled Component';

  @override
  String get errorNoInternet =>
      'No internet connection. Please check your network and try again.';

  @override
  String get errorConnectionTimeout =>
      'Connection timeout. The server might be busy.';

  @override
  String errorNetwork(String errorMessage) {
    return 'Network error: $errorMessage';
  }

  @override
  String get errorNetworkUnavailable =>
      'Network unavailable. Please check your internet connection.';

  @override
  String get errorRequestTimedOut =>
      'Request timed out. Please try again later.';

  @override
  String get errorNetworkIssue =>
      'Network issue detected. Please check your connection.';

  @override
  String errorAuthentication(String errorMessage) {
    return 'Authentication error: $errorMessage';
  }

  @override
  String errorDatabase(String errorMessage) {
    return 'Database error: $errorMessage';
  }

  @override
  String errorStorage(String errorMessage) {
    return 'File storage error: $errorMessage';
  }

  @override
  String errorFailedSaveChanges(String errorMessage) {
    return 'Failed to save changes: $errorMessage';
  }

  @override
  String errorFailedPickImage(String errorMessage) {
    return 'Failed to pick image: $errorMessage';
  }

  @override
  String errorFailedLinkDevice(String errorMessage) {
    return 'Failed to link device: $errorMessage';
  }

  @override
  String get errorLocationPermissionRequired =>
      'Location permission is required for Wi-Fi configuration';

  @override
  String get errorPermissionDenied =>
      'Permission has been denied, Manually allow location permission from settings.';

  @override
  String errorInvalidInput(String errorMessage) {
    return 'Invalid input: $errorMessage';
  }

  @override
  String get errorActionNotAllowed =>
      'This action is not allowed on a demo account';

  @override
  String get errorUnexpected => 'An unexpected error occurred.';

  @override
  String get dateToday => 'Today';

  @override
  String get dateYesterday => 'Yesterday';

  @override
  String get dateThisWeek => 'This week';

  @override
  String get dateOlder => 'Older';

  @override
  String get componentNameTemperature => 'Temperature';

  @override
  String get componentNameHumidity => 'Humidity';

  @override
  String get componentNameWaterLevel => 'Water Level';

  @override
  String get componentNameGas => 'Gas Detector';

  @override
  String get componentNameFlame => 'Flame Sensor';

  @override
  String get componentNamePir => 'Motion Sensor';

  @override
  String get componentNameLdr => 'Light Sensor';

  @override
  String get componentNameFingerprint => 'Fingerprint Scanner';

  @override
  String get componentNameWindow => 'Window';

  @override
  String get componentNameDoor => 'Door';

  @override
  String get componentNameLight => 'Light';

  @override
  String get componentNameBuzzer => 'Buzzer';

  @override
  String get componentNameSecurity => 'Security System';

  @override
  String get readingOneDayAgo => '1 day ago';

  @override
  String get readingTwoDaysAgo => '2 days ago';

  @override
  String readingDaysAgo(Object days) {
    return '$days days ago';
  }

  @override
  String get readingOneHourAgo => '1 hour ago';

  @override
  String get readingTwoHoursAgo => '2 hours ago';

  @override
  String readingHoursAgo(Object hours) {
    return '$hours hours ago';
  }

  @override
  String get readingNow => 'Now';

  @override
  String get readingOneMinuteAgo => 'Recently';

  @override
  String readingMinutesAgoPlural(Object minutes) {
    return '$minutes minutes ago';
  }

  @override
  String readingMinutesAgo(Object minutes) {
    return '$minutes minutes ago';
  }

  @override
  String get readingSafe => 'Safe';

  @override
  String get readingRecently => 'Recently';

  @override
  String get readingWarning => 'Warning';

  @override
  String get readingDanger => 'Danger';

  @override
  String get readingLightVeryBright => 'Very Bright';

  @override
  String get readingLightBright => 'Bright';

  @override
  String get readingLightModerate => 'Moderate';

  @override
  String get readingLightDim => 'Dim';

  @override
  String get readingLightDark => 'Dark';

  @override
  String get toggleTypeLightOff => 'Off';

  @override
  String get toggleTypeLightOn => 'On';

  @override
  String get toggleTypeOpenableOff => 'Open';

  @override
  String get toggleTypeOpenableOn => 'Close';

  @override
  String get toggleSecurityOff => 'Off';

  @override
  String get toggleSecurityOn => 'On';

  @override
  String get devicesScreenTitle => 'Your Devices';

  @override
  String get devicesScreenAddDeviceButton => 'Add device';

  @override
  String get devicesScreenNeedInternetAccess => 'You need internet access!';

  @override
  String get devicesScreenLoadingList => 'Loading devices list...';

  @override
  String get devicesScreenUntitledDevice => 'Untitled';

  @override
  String get linkDeviceModalAlreadyLinked =>
      'This device is already linked to your account';

  @override
  String get linkDeviceModalLinkButton => 'Link this device';

  @override
  String get newDeviceScreenWifiConfigHeader =>
      'Connecting device to Wi-Fi network using ESP-Touch protocol';

  @override
  String get newDeviceScreenDeviceDiscoveryHeader =>
      'Select the device you want to link from the list:';

  @override
  String get newDeviceScreenAppBarTitle => 'Link a device';

  @override
  String get newDeviceScreenWifiNetworkNote =>
      'Make sure you are connected to the same Wi-Fi network as the device you want to link.';

  @override
  String get newDeviceScreenLinkingDeviceProgress => 'Linking device...';

  @override
  String get deviceDetailsUntitledDevice => 'Untitled';

  @override
  String get deviceDetailsDeviceTypeLabel => 'Device type';

  @override
  String get deviceDetailsMacAddressLabel => 'MAC Address';

  @override
  String get deviceDetailsDateAddedLabel => 'Date added';

  @override
  String get deviceDetailsSensorsLabel => 'Sensors';

  @override
  String get deviceDetailsControlsLabel => 'Controls';

  @override
  String get deviceDiscoveryMacAddressLabel => 'MAC Address: ';

  @override
  String get deviceDiscoveryLinkedSuccess => 'Device linked successfully';

  @override
  String get deviceDiscoveryLinkFailedTitle => 'Failed to link device';

  @override
  String get deviceDiscoveryRefreshButton => 'Refresh';

  @override
  String get deviceDiscoveryNoDevicesFound => 'No devices found';

  @override
  String get deviceDiscoveryVpnWarning =>
      'If you have a VPN running, turn it off then try again.';

  @override
  String get deviceQuickOptionsEditButton => 'Edit';

  @override
  String get deviceQuickOptionsInfoButton => 'Info';

  @override
  String get deviceQuickOptionsUnlinkButton => 'Unlink';

  @override
  String deviceQuickOptionsUnlinkDialogTitle(String deviceNameOrType) {
    return 'Unlink $deviceNameOrType';
  }

  @override
  String get deviceQuickOptionsUnlinkDialogMessage =>
      'This will remove the device and all of its components from your account!';

  @override
  String get deviceQuickOptionsUnlinkDialogConfirmButton => 'Unlink';

  @override
  String get deviceQuickOptionsUnlinkSuccessSnackbar =>
      'Device unlinked successfully';

  @override
  String get deviceQuickOptionsRenameDialogTitle => 'Rename Device';

  @override
  String deviceQuickOptionsRenameSuccessSnackbar(String newName) {
    return 'Device renamed to $newName';
  }

  @override
  String get deviceQuickOptionsRenameDialogHint => 'Name';

  @override
  String get deviceQuickOptionsRenameDialogCancelButton => 'Cancel';

  @override
  String get deviceQuickOptionsRenameDialogSaveButton => 'Save';

  @override
  String get udpDeviceDetailsIpAddressLabel => 'IP Address';

  @override
  String get wifiConfigCredentialsTitle => 'Your WiFi Credentials:';

  @override
  String get wifiConfigSsidLabel => 'SSID (Network name)';

  @override
  String get wifiConfigSsidNotFound => 'Not found!';

  @override
  String get wifiConfigGetSsidButton => 'Get SSID';

  @override
  String get wifiConfigInstructions =>
      'On the device: Hold down the reset button for 3 seconds then tap \"Start Provisioning\" button.';

  @override
  String get wifiConfigStartProvisioningButton => 'Start provisioning';

  @override
  String get wifiConfigMissingArgsSnackbar =>
      'Missing arguments! Provisioning was not started.';

  @override
  String get wifiConfigProvisioningDialogTitle => 'Provisioning';

  @override
  String get wifiConfigProvisioningDialogContent =>
      'Provisioning started. Please wait...';

  @override
  String get wifiConfigStopButton => 'Stop';

  @override
  String get wifiConfigDeviceProvisionedDialogTitle => 'Device provisioned';

  @override
  String get wifiConfigDeviceProvisionedDialogContentSuccess =>
      'Device successfully connected to the network';

  @override
  String get wifiConfigDeviceProvisionedDialogContentDeviceLabel => 'Device:';

  @override
  String wifiConfigDialogDeviceIp(String ipAddressText) {
    return 'IP: $ipAddressText';
  }

  @override
  String wifiConfigDialogDeviceBssid(String bssidText) {
    return 'BSSID: $bssidText';
  }

  @override
  String wifiConfigSsidSnackbar(String ssid) {
    return 'SSID: $ssid';
  }

  @override
  String get wifiConfigOpenSettingsButton => 'Open settings';

  @override
  String get imageOptionsCameraButton => 'Camera';

  @override
  String get imageOptionsGalleryButton => 'Gallery';

  @override
  String get imageOptionsRemoveButton => 'Remove';

  @override
  String get notificationsScreenTitle => 'Notifications';

  @override
  String get notificationsScreenNoNotifications => 'No notifications';

  @override
  String get notificationsScreenGroupThisWeek => 'This Week';

  @override
  String get notificationsScreenGroupOlder => 'Older';

  @override
  String get notificationsScreenLoading => 'Loading notifications...';

  @override
  String get changePasswordScreenTitle => 'Change Password';

  @override
  String get changePasswordCurrentPasswordLabel => 'Current Password';

  @override
  String get changePasswordNewPasswordLabel => 'New Password';

  @override
  String get changePasswordSuccessSnackbar => 'Password changed successfully';

  @override
  String get editProfileScreenTitle => 'Edit Profile';

  @override
  String get editProfileUploadingImage => 'Uploading image...';

  @override
  String get editProfileUpdatingData => 'Updating data...';

  @override
  String get editProfileSuccessSnackbar => 'Profile was updated successfully.';

  @override
  String get editProfileConfirmationDialogSaveChanges => 'Save Changes';

  @override
  String get profileActionsLogOut => 'Log Out';

  @override
  String get appInfoLanguageLabel => 'Language';

  @override
  String get appInfoContactSupport => 'Contact support';

  @override
  String get changeLanguageDialogTitle => 'Change Language';

  @override
  String get profileAddName => 'Add a name';

  @override
  String get profileFailedToLoad => 'Failed to load user information!';

  @override
  String get profileLoadingUserInformation => 'Loading user information...';

  @override
  String get addRoomScreenTitle => 'Add Room';

  @override
  String get roomsScreenTitle => 'Rooms';

  @override
  String get roomsScreenAddRoomButton => 'Add Room';

  @override
  String deleteRoomDialogTitle(String name) {
    return 'Delete $name?';
  }

  @override
  String get deleteRoomDialogLoadingText => 'Deleting room...';

  @override
  String get renameRoomDialogTitle => 'Rename Room';

  @override
  String get renameRoomDialogNewNameLabel => 'New name';

  @override
  String get renameRoomDialogEmptyNameError => 'Name cannot be empty';

  @override
  String get roomPopupMenuDeleteRoom => 'Delete room';

  @override
  String get componentsPickerLoadingComponents => 'Loading components...';

  @override
  String get componentsPickerNoComponentsFound => 'No smart components found';

  @override
  String get componentsPickerOtherDevices => 'Other Devices';

  @override
  String get componentsPickerPickComponentsTitle => 'Pick Components';

  @override
  String get fallbackSomethingWentWrong => 'Something went wrong';

  @override
  String roomDeletedSuccess(String name) {
    return 'Room $name deleted';
  }

  @override
  String actionFailedError(String error) {
    return 'Action failed: $error';
  }

  @override
  String get roomImageEditorUploadFailed => 'Upload failed';

  @override
  String get roomImageEditorRetryButton => 'Retry';

  @override
  String get validatorsUsernameRequired => 'Username is required';

  @override
  String get validatorsUsernameNoSpaces => 'Username cannot contain spaces';

  @override
  String validatorsUsernameMinLength(int length) {
    return 'Username must be at least $length characters';
  }

  @override
  String get validatorsPasswordsDoNotMatch => 'Passwords do not match';

  @override
  String get validatorsFieldRequired => 'This field is required';

  @override
  String validatorsPasswordMinLength(int length) {
    return 'Password must be at least $length characters';
  }
}
