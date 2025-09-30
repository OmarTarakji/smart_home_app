// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'latest_scans_provider.dart';

// **************************************************************************
// RiverpodGenerator
// **************************************************************************

// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint, type=warning

@ProviderFor(latestScans)
const latestScansProvider = LatestScansFamily._();

final class LatestScansProvider
    extends
        $FunctionalProvider<
          AsyncValue<List<FingerprintScan>>,
          List<FingerprintScan>,
          FutureOr<List<FingerprintScan>>
        >
    with
        $FutureModifier<List<FingerprintScan>>,
        $FutureProvider<List<FingerprintScan>> {
  const LatestScansProvider._({
    required LatestScansFamily super.from,
    required int super.argument,
  }) : super(
         retry: null,
         name: r'latestScansProvider',
         isAutoDispose: true,
         dependencies: null,
         $allTransitiveDependencies: null,
       );

  @override
  String debugGetCreateSourceHash() => _$latestScansHash();

  @override
  String toString() {
    return r'latestScansProvider'
        ''
        '($argument)';
  }

  @$internal
  @override
  $FutureProviderElement<List<FingerprintScan>> $createElement(
    $ProviderPointer pointer,
  ) => $FutureProviderElement(pointer);

  @override
  FutureOr<List<FingerprintScan>> create(Ref ref) {
    final argument = this.argument as int;
    return latestScans(ref, argument);
  }

  @override
  bool operator ==(Object other) {
    return other is LatestScansProvider && other.argument == argument;
  }

  @override
  int get hashCode {
    return argument.hashCode;
  }
}

String _$latestScansHash() => r'3a4acc4df10791cf97adddd10634c13777259b53';

final class LatestScansFamily extends $Family
    with $FunctionalFamilyOverride<FutureOr<List<FingerprintScan>>, int> {
  const LatestScansFamily._()
    : super(
        retry: null,
        name: r'latestScansProvider',
        dependencies: null,
        $allTransitiveDependencies: null,
        isAutoDispose: true,
      );

  LatestScansProvider call(int scannerId) =>
      LatestScansProvider._(argument: scannerId, from: this);

  @override
  String toString() => r'latestScansProvider';
}
