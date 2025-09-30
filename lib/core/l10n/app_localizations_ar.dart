// ignore: unused_import
import 'package:intl/intl.dart' as intl;
import 'app_localizations.dart';

// ignore_for_file: type=lint

/// The translations for Arabic (`ar`).
class AppLocalizationsAr extends AppLocalizations {
  AppLocalizationsAr([String locale = 'ar']) : super(locale);

  @override
  String get language => 'العربية';

  @override
  String get dashboard => 'لوحة التحكم';

  @override
  String get devices => 'الأجهزة';

  @override
  String get rooms => 'الغرف';

  @override
  String get profile => 'الحساب';

  @override
  String get exitAndCancel => 'العودة';

  @override
  String get delete => 'حذف';

  @override
  String get loading => 'جاري التحميل...';

  @override
  String get add => 'إضافة';

  @override
  String get save => 'حفظ';

  @override
  String get loginWelcomeBack => 'مرحبًا بعودتك';

  @override
  String get loginButtonText => 'تسجيل الدخول';

  @override
  String get loginDemoButton => 'حساب تجريبي';

  @override
  String get loginNeedAccount => 'ليس لديك حساب؟ سجل الآن';

  @override
  String get loginLoggingIn => 'جاري تسجيل الدخول...';

  @override
  String get signupCreateAccountTitle => 'أنشئ حسابك';

  @override
  String get signupButtonText => 'إنشاء حساب';

  @override
  String get signupSignInInstead => 'تسجيل الدخول بدلاً من ذلك';

  @override
  String get signupCreatingAccount => 'جاري إنشاء الحساب...';

  @override
  String get password => 'كلمة المرور';

  @override
  String get confirmPassword => 'تأكيد كلمة المرور';

  @override
  String get username => 'اسم المستخدم';

  @override
  String get enterUsername => 'ادخل اسم المستخدم';

  @override
  String get dashboardLoadingComponents => 'جار تحميل المكونات...';

  @override
  String get dashboardNoComponentsFound => 'لم يتم العثور على مكونات';

  @override
  String get dashboardUnassignedRoom => 'غير مخصص';

  @override
  String get dashboardOptionsLayout => 'طريقة العرض:';

  @override
  String get dashboardOptionsLayoutGrid => 'شبكة';

  @override
  String get dashboardOptionsLayoutList => 'قائمة';

  @override
  String get dashboardOptionsGroupBy => 'تجميع حسب:';

  @override
  String get dashboardOptionsGroupByNone => 'بدون';

  @override
  String get dashboardOptionsGroupByRoom => 'الغرفة';

  @override
  String get dashboardOptionsGroupByDevice => 'الجهاز';

  @override
  String get dashboardOptionsButtonOK => 'موافق';

  @override
  String get fingerprintManage => 'إدارة بصمات الأصابع';

  @override
  String get fingerprintScanHistory => 'سجل المسح';

  @override
  String get latestActivities => 'آخر النشاطات';

  @override
  String get flameSensorNoActivities => 'لا توجد أنشطة بعد';

  @override
  String get flameSensorFlameDetected => 'تم الكشف عن لهب';

  @override
  String get stateIndicatorSyncing => 'جاري المزامنة...';

  @override
  String get stateIndicatorSynced => 'تمت المزامنة';

  @override
  String get stateIndicatorError => 'خطأ';

  @override
  String morningHour(String hour) {
    return '$hour ص';
  }

  @override
  String eveningHour(String hour) {
    return '$hour م';
  }

  @override
  String get componentPopupMenuRename => 'إعادة تسمية';

  @override
  String get componentPopupMenuChangeIcon => 'تغيير الأيقونة';

  @override
  String get componentValueNoReadingsYet => 'لا توجد قراءات بعد';

  @override
  String get componentValueUnhandledComponent => 'مكون غير معالج';

  @override
  String get errorNoInternet =>
      'لا يوجد اتصال بالإنترنت. يرجى التحقق من الشبكة والمحاولة مرة أخرى.';

  @override
  String get errorConnectionTimeout =>
      'انتهت مهلة الاتصال. قد يكون الخادم مشغولاً.';

  @override
  String errorNetwork(String errorMessage) {
    return 'خطأ في الشبكة: $errorMessage';
  }

  @override
  String get errorNetworkUnavailable =>
      'الشبكة غير متاحة. يرجى التحقق من اتصالك بالإنترنت.';

  @override
  String get errorRequestTimedOut =>
      'انتهت مهلة الطلب. يرجى المحاولة مرة أخرى لاحقًا.';

  @override
  String get errorNetworkIssue =>
      'تم اكتشاف مشكلة في الشبكة. يرجى التحقق من اتصالك.';

  @override
  String errorAuthentication(String errorMessage) {
    return 'خطأ في المصادقة: $errorMessage';
  }

  @override
  String errorDatabase(String errorMessage) {
    return 'خطأ في قاعدة البيانات: $errorMessage';
  }

  @override
  String errorStorage(String errorMessage) {
    return 'خطأ في تخزين الملفات: $errorMessage';
  }

  @override
  String errorFailedSaveChanges(String errorMessage) {
    return 'فشل حفظ التغييرات: $errorMessage';
  }

  @override
  String errorFailedPickImage(String errorMessage) {
    return 'فشل اختيار الصورة: $errorMessage';
  }

  @override
  String errorFailedLinkDevice(String errorMessage) {
    return 'فشل ربط الجهاز: $errorMessage';
  }

  @override
  String get errorLocationPermissionRequired =>
      'إذن الموقع مطلوب لتهيئة الواي فاي';

  @override
  String get errorPermissionDenied =>
      'تم رفض الإذن، يرجى السماح بإذن الموقع يدويًا من الإعدادات.';

  @override
  String errorInvalidInput(String errorMessage) {
    return 'إدخال غير صالح: $errorMessage';
  }

  @override
  String get errorActionNotAllowed =>
      'هذا الإجراء غير مسموح به في الحساب التجريبي.';

  @override
  String get errorUnexpected => 'خطأ غير متوقع.';

  @override
  String get dateToday => 'اليوم';

  @override
  String get dateYesterday => 'الأمس';

  @override
  String get componentNameTemperature => 'درجة الحرارة';

  @override
  String get componentNameHumidity => 'الرطوبة';

  @override
  String get componentNameWaterLevel => 'مستوى الماء';

  @override
  String get componentNameGas => 'كاشف الغاز';

  @override
  String get componentNameFlame => 'مستشعر اللهب';

  @override
  String get componentNamePir => 'مستشعر الحركة';

  @override
  String get componentNameLdr => 'مستشعر الضوء';

  @override
  String get componentNameFingerprint => 'ماسح البصمات';

  @override
  String get componentNameWindow => 'نافذة';

  @override
  String get componentNameDoor => 'باب';

  @override
  String get componentNameLight => 'ضوء';

  @override
  String get componentNameBuzzer => 'جرس';

  @override
  String get componentNameSecurity => 'نظام الأمن';

  @override
  String get devicesScreenTitle => 'أجهزتك';

  @override
  String get devicesScreenAddDeviceButton => 'إضافة جهاز';

  @override
  String get devicesScreenNeedInternetAccess => 'تحتاج إلى اتصال بالإنترنت!';

  @override
  String get devicesScreenLoadingList => 'جاري تحميل قائمة الأجهزة...';

  @override
  String get devicesScreenUntitledDevice => 'بدون عنوان';

  @override
  String get linkDeviceModalAlreadyLinked => 'هذا الجهاز مرتبط بالفعل بحسابك';

  @override
  String get linkDeviceModalLinkButton => 'ربط هذا الجهاز';

  @override
  String get newDeviceScreenWifiConfigHeader =>
      'توصيل الجهاز بشبكة الواي فاي باستخدام بروتوكول ESP-Touch';

  @override
  String get newDeviceScreenDeviceDiscoveryHeader =>
      'حدد الجهاز الذي تريد ربطه من القائمة:';

  @override
  String get newDeviceScreenAppBarTitle => 'ربط جهاز';

  @override
  String get newDeviceScreenWifiNetworkNote =>
      'تأكد من أنك متصل بنفس شبكة الواي فاي التي يتصل بها الجهاز الذي تريد ربطه.';

  @override
  String get newDeviceScreenLinkingDeviceProgress => 'جاري ربط الجهاز...';

  @override
  String get deviceDetailsUntitledDevice => 'بدون عنوان';

  @override
  String get deviceDetailsDeviceTypeLabel => 'نوع الجهاز';

  @override
  String get deviceDetailsMacAddressLabel => 'عنوان MAC';

  @override
  String get deviceDetailsDateAddedLabel => 'تاريخ الإضافة';

  @override
  String get deviceDetailsSensorsLabel => 'المستشعرات';

  @override
  String get deviceDetailsControlsLabel => 'أدوات التحكم';

  @override
  String get deviceDiscoveryMacAddressLabel => 'عنوان MAC: ';

  @override
  String get deviceDiscoveryLinkedSuccess => 'تم ربط الجهاز بنجاح';

  @override
  String get deviceDiscoveryLinkFailedTitle => 'فشل ربط الجهاز';

  @override
  String get deviceDiscoveryRefreshButton => 'تحديث';

  @override
  String get deviceDiscoveryNoDevicesFound => 'لم يتم العثور على أجهزة';

  @override
  String get deviceDiscoveryVpnWarning =>
      'إذا كان لديك VPN قيد التشغيل، قم بإيقاف تشغيله ثم أعد المحاولة.';

  @override
  String get deviceQuickOptionsEditButton => 'تعديل';

  @override
  String get deviceQuickOptionsInfoButton => 'تفاصيل الجهاز';

  @override
  String get deviceQuickOptionsUnlinkButton => 'إلغاء الربط';

  @override
  String deviceQuickOptionsUnlinkDialogTitle(String deviceNameOrType) {
    return 'إلغاء ربط $deviceNameOrType';
  }

  @override
  String get deviceQuickOptionsUnlinkDialogMessage =>
      'سيؤدي هذا إلى إزالة الجهاز وجميع مكوناته من حسابك!';

  @override
  String get deviceQuickOptionsUnlinkDialogConfirmButton => 'إلغاء الربط';

  @override
  String get deviceQuickOptionsUnlinkSuccessSnackbar =>
      'تم إلغاء ربط الجهاز بنجاح';

  @override
  String get deviceQuickOptionsRenameDialogTitle => 'إعادة تسمية الجهاز';

  @override
  String deviceQuickOptionsRenameSuccessSnackbar(String newName) {
    return 'تمت إعادة تسمية الجهاز إلى $newName';
  }

  @override
  String get deviceQuickOptionsRenameDialogHint => 'الاسم';

  @override
  String get deviceQuickOptionsRenameDialogCancelButton => 'إلغاء';

  @override
  String get deviceQuickOptionsRenameDialogSaveButton => 'حفظ';

  @override
  String get udpDeviceDetailsIpAddressLabel => 'عنوان IP';

  @override
  String get wifiConfigCredentialsTitle => 'بيانات شبكة الواي فاي:';

  @override
  String get wifiConfigSsidLabel => 'SSID (اسم الشبكة)';

  @override
  String get wifiConfigSsidNotFound => 'غير موجود!';

  @override
  String get wifiConfigGetSsidButton => 'احصل على SSID';

  @override
  String get wifiConfigInstructions =>
      'على الجهاز: اضغط مع الاستمرار على زر إعادة الضبط لمدة 3 ثوانٍ ثم انقر فوق زر \"بدء التجهيز\".';

  @override
  String get wifiConfigStartProvisioningButton => 'بدء التجهيز';

  @override
  String get wifiConfigMissingArgsSnackbar => 'بعض الحقول مفقودة!';

  @override
  String get wifiConfigProvisioningDialogTitle => 'التجهيز';

  @override
  String get wifiConfigProvisioningDialogContent =>
      'بدأ التجهيز. يرجى الانتظار...';

  @override
  String get wifiConfigStopButton => 'إيقاف';

  @override
  String get wifiConfigDeviceProvisionedDialogTitle => 'تم تجهيز الجهاز';

  @override
  String get wifiConfigDeviceProvisionedDialogContentSuccess =>
      'تم توصيل الجهاز بالشبكة بنجاح';

  @override
  String get wifiConfigDeviceProvisionedDialogContentDeviceLabel => 'الجهاز:';

  @override
  String wifiConfigDialogDeviceIp(String ipAddressText) {
    return 'عنوان IP: $ipAddressText';
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
  String get wifiConfigOpenSettingsButton => 'فتح الإعدادات';

  @override
  String get imageOptionsCameraButton => 'الكاميرا';

  @override
  String get imageOptionsGalleryButton => 'المعرض';

  @override
  String get imageOptionsRemoveButton => 'إزالة';

  @override
  String get notificationsScreenTitle => 'الإشعارات';

  @override
  String get notificationsScreenNoNotifications => 'لا توجد إشعارات';

  @override
  String get notificationsScreenGroupThisWeek => 'هذا الأسبوع';

  @override
  String get notificationsScreenGroupOlder => 'أقدم';

  @override
  String get notificationsScreenLoading => 'جار تحميل الإشعارات...';

  @override
  String get changePasswordScreenTitle => 'تغيير كلمة المرور';

  @override
  String get changePasswordCurrentPasswordLabel => 'كلمة المرور الحالية';

  @override
  String get changePasswordNewPasswordLabel => 'كلمة المرور الجديدة';

  @override
  String get changePasswordSuccessSnackbar => 'تم تغيير كلمة المرور بنجاح';

  @override
  String get editProfileScreenTitle => 'تعديل الملف الشخصي';

  @override
  String get editProfileUploadingImage => 'جاري رفع الصورة...';

  @override
  String get editProfileUpdatingData => 'جاري تحديث البيانات...';

  @override
  String get editProfileSuccessSnackbar => 'تم تحديث الملف الشخصي بنجاح.';

  @override
  String get editProfileConfirmationDialogSaveChanges => 'حفظ التغييرات';

  @override
  String get profileActionsLogOut => 'تسجيل الخروج';

  @override
  String get appInfoLanguageLabel => 'اللغة';

  @override
  String get appInfoContactSupport => 'اتصل بالدعم';

  @override
  String get changeLanguageDialogTitle => 'تغيير اللغة';

  @override
  String get profileAddName => 'إضافة اسم';

  @override
  String get profileFailedToLoad => 'فشل تحميل معلومات المستخدم!';

  @override
  String get profileLoadingUserInformation => 'جاري تحميل معلومات المستخدم...';

  @override
  String get addRoomScreenTitle => 'إضافة غرفة';

  @override
  String get roomsScreenTitle => 'الغرف';

  @override
  String get roomsScreenAddRoomButton => 'إضافة غرفة';

  @override
  String deleteRoomDialogTitle(String name) {
    return 'حذف $name؟';
  }

  @override
  String get deleteRoomDialogLoadingText => 'جاري حذف الغرفة...';

  @override
  String get renameRoomDialogTitle => 'إعادة تسمية الغرفة';

  @override
  String get renameRoomDialogNewNameLabel => 'الاسم الجديد';

  @override
  String get renameRoomDialogEmptyNameError => 'لا يمكن أن يكون الاسم فارغًا';

  @override
  String get roomPopupMenuDeleteRoom => 'حذف الغرفة';

  @override
  String get componentsPickerLoadingComponents => 'جار تحميل المكونات...';

  @override
  String get componentsPickerNoComponentsFound =>
      'لم يتم العثور على مكونات ذكية';

  @override
  String get componentsPickerOtherDevices => 'أجهزة أخرى';

  @override
  String get componentsPickerPickComponentsTitle => 'اختر المكونات';

  @override
  String get fallbackSomethingWentWrong => 'حدث خطأ ما';

  @override
  String roomDeletedSuccess(String name) {
    return 'تم حذف الغرفة $name';
  }

  @override
  String actionFailedError(String error) {
    return 'فشل الإجراء: $error';
  }

  @override
  String get roomImageEditorUploadFailed => 'فشل الرفع';

  @override
  String get roomImageEditorRetryButton => 'إعادة المحاولة';

  @override
  String get validatorsUsernameRequired => 'اسم المستخدم مطلوب';

  @override
  String get validatorsUsernameNoSpaces =>
      'لا يمكن أن يحتوي اسم المستخدم على مسافات';

  @override
  String validatorsUsernameMinLength(int length) {
    return 'يجب أن يتكون اسم المستخدم من $length أحرف على الأقل';
  }

  @override
  String get validatorsPasswordsDoNotMatch => 'كلمات المرور غير متطابقة';

  @override
  String get validatorsFieldRequired => 'هذا الحقل مطلوب';

  @override
  String validatorsPasswordMinLength(int length) {
    return 'يجب أن تتكون كلمة المرور من $length أحرف على الأقل';
  }
}
