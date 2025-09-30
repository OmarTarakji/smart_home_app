import 'package:riverpod_annotation/riverpod_annotation.dart';
import 'package:smart_home/features/fingerprint/domain/add_fingerprint_response.dart';
import 'package:smart_home/features/fingerprint/domain/add_fingerprint_state.dart';

part 'add_fingerprint_controller.g.dart';

@riverpod
class AddFingerprintNotifier extends _$AddFingerprintNotifier {
  @override
  AddFingerprintResponse build() =>
      const AddFingerprintResponse(AddFpState.none);

  void setState(AddFingerprintResponse newState) => state = newState;
}
