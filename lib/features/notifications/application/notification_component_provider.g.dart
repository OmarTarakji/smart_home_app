// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'notification_component_provider.dart';

// **************************************************************************
// RiverpodGenerator
// **************************************************************************

// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint, type=warning

@ProviderFor(notificationComponent)
const notificationComponentProvider = NotificationComponentFamily._();

final class NotificationComponentProvider
    extends $FunctionalProvider<Component?, Component?, Component?>
    with $Provider<Component?> {
  const NotificationComponentProvider._({
    required NotificationComponentFamily super.from,
    required int? super.argument,
  }) : super(
         retry: null,
         name: r'notificationComponentProvider',
         isAutoDispose: true,
         dependencies: null,
         $allTransitiveDependencies: null,
       );

  @override
  String debugGetCreateSourceHash() => _$notificationComponentHash();

  @override
  String toString() {
    return r'notificationComponentProvider'
        ''
        '($argument)';
  }

  @$internal
  @override
  $ProviderElement<Component?> $createElement($ProviderPointer pointer) =>
      $ProviderElement(pointer);

  @override
  Component? create(Ref ref) {
    final argument = this.argument as int?;
    return notificationComponent(ref, argument);
  }

  /// {@macro riverpod.override_with_value}
  Override overrideWithValue(Component? value) {
    return $ProviderOverride(
      origin: this,
      providerOverride: $SyncValueProvider<Component?>(value),
    );
  }

  @override
  bool operator ==(Object other) {
    return other is NotificationComponentProvider && other.argument == argument;
  }

  @override
  int get hashCode {
    return argument.hashCode;
  }
}

String _$notificationComponentHash() =>
    r'0d0871c43e91fc8f626e40e593476cf7062db3f4';

final class NotificationComponentFamily extends $Family
    with $FunctionalFamilyOverride<Component?, int?> {
  const NotificationComponentFamily._()
    : super(
        retry: null,
        name: r'notificationComponentProvider',
        dependencies: null,
        $allTransitiveDependencies: null,
        isAutoDispose: true,
      );

  NotificationComponentProvider call(int? componentId) =>
      NotificationComponentProvider._(argument: componentId, from: this);

  @override
  String toString() => r'notificationComponentProvider';
}
