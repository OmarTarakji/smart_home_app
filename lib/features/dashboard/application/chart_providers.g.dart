// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'chart_providers.dart';

// **************************************************************************
// RiverpodGenerator
// **************************************************************************

// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint, type=warning

@ProviderFor(dayReadingsAvg)
const dayReadingsAvgProvider = DayReadingsAvgFamily._();

final class DayReadingsAvgProvider
    extends
        $FunctionalProvider<
          AsyncValue<List<AvgComponentReading>>,
          List<AvgComponentReading>,
          FutureOr<List<AvgComponentReading>>
        >
    with
        $FutureModifier<List<AvgComponentReading>>,
        $FutureProvider<List<AvgComponentReading>> {
  const DayReadingsAvgProvider._({
    required DayReadingsAvgFamily super.from,
    required int super.argument,
  }) : super(
         retry: null,
         name: r'dayReadingsAvgProvider',
         isAutoDispose: true,
         dependencies: null,
         $allTransitiveDependencies: null,
       );

  @override
  String debugGetCreateSourceHash() => _$dayReadingsAvgHash();

  @override
  String toString() {
    return r'dayReadingsAvgProvider'
        ''
        '($argument)';
  }

  @$internal
  @override
  $FutureProviderElement<List<AvgComponentReading>> $createElement(
    $ProviderPointer pointer,
  ) => $FutureProviderElement(pointer);

  @override
  FutureOr<List<AvgComponentReading>> create(Ref ref) {
    final argument = this.argument as int;
    return dayReadingsAvg(ref, argument);
  }

  @override
  bool operator ==(Object other) {
    return other is DayReadingsAvgProvider && other.argument == argument;
  }

  @override
  int get hashCode {
    return argument.hashCode;
  }
}

String _$dayReadingsAvgHash() => r'd947d7afaf4c9570c51c60f4a4c043ac0b78f52d';

final class DayReadingsAvgFamily extends $Family
    with $FunctionalFamilyOverride<FutureOr<List<AvgComponentReading>>, int> {
  const DayReadingsAvgFamily._()
    : super(
        retry: null,
        name: r'dayReadingsAvgProvider',
        dependencies: null,
        $allTransitiveDependencies: null,
        isAutoDispose: true,
      );

  DayReadingsAvgProvider call(int id) =>
      DayReadingsAvgProvider._(argument: id, from: this);

  @override
  String toString() => r'dayReadingsAvgProvider';
}

@ProviderFor(hourlyReadingsCount)
const hourlyReadingsCountProvider = HourlyReadingsCountFamily._();

final class HourlyReadingsCountProvider
    extends
        $FunctionalProvider<
          AsyncValue<List<ComponentReadingCount>>,
          List<ComponentReadingCount>,
          FutureOr<List<ComponentReadingCount>>
        >
    with
        $FutureModifier<List<ComponentReadingCount>>,
        $FutureProvider<List<ComponentReadingCount>> {
  const HourlyReadingsCountProvider._({
    required HourlyReadingsCountFamily super.from,
    required int super.argument,
  }) : super(
         retry: null,
         name: r'hourlyReadingsCountProvider',
         isAutoDispose: true,
         dependencies: null,
         $allTransitiveDependencies: null,
       );

  @override
  String debugGetCreateSourceHash() => _$hourlyReadingsCountHash();

  @override
  String toString() {
    return r'hourlyReadingsCountProvider'
        ''
        '($argument)';
  }

  @$internal
  @override
  $FutureProviderElement<List<ComponentReadingCount>> $createElement(
    $ProviderPointer pointer,
  ) => $FutureProviderElement(pointer);

  @override
  FutureOr<List<ComponentReadingCount>> create(Ref ref) {
    final argument = this.argument as int;
    return hourlyReadingsCount(ref, argument);
  }

  @override
  bool operator ==(Object other) {
    return other is HourlyReadingsCountProvider && other.argument == argument;
  }

  @override
  int get hashCode {
    return argument.hashCode;
  }
}

String _$hourlyReadingsCountHash() =>
    r'3395d4022d25834434dd9c7d2409c97aef9f02a7';

final class HourlyReadingsCountFamily extends $Family
    with $FunctionalFamilyOverride<FutureOr<List<ComponentReadingCount>>, int> {
  const HourlyReadingsCountFamily._()
    : super(
        retry: null,
        name: r'hourlyReadingsCountProvider',
        dependencies: null,
        $allTransitiveDependencies: null,
        isAutoDispose: true,
      );

  HourlyReadingsCountProvider call(int id) =>
      HourlyReadingsCountProvider._(argument: id, from: this);

  @override
  String toString() => r'hourlyReadingsCountProvider';
}

@ProviderFor(ChartDate)
const chartDateProvider = ChartDateProvider._();

final class ChartDateProvider extends $NotifierProvider<ChartDate, DateTime> {
  const ChartDateProvider._()
    : super(
        from: null,
        argument: null,
        retry: null,
        name: r'chartDateProvider',
        isAutoDispose: true,
        dependencies: null,
        $allTransitiveDependencies: null,
      );

  @override
  String debugGetCreateSourceHash() => _$chartDateHash();

  @$internal
  @override
  ChartDate create() => ChartDate();

  /// {@macro riverpod.override_with_value}
  Override overrideWithValue(DateTime value) {
    return $ProviderOverride(
      origin: this,
      providerOverride: $SyncValueProvider<DateTime>(value),
    );
  }
}

String _$chartDateHash() => r'cb96925c3db424ba78c401d8ec782ba8dfd26cfd';

abstract class _$ChartDate extends $Notifier<DateTime> {
  DateTime build();
  @$mustCallSuper
  @override
  void runBuild() {
    final created = build();
    final ref = this.ref as $Ref<DateTime, DateTime>;
    final element =
        ref.element
            as $ClassProviderElement<
              AnyNotifier<DateTime, DateTime>,
              DateTime,
              Object?,
              Object?
            >;
    element.handleValue(ref, created);
  }
}
