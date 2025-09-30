import 'package:smart_home/features/fingerprint/domain/add_fingerprint_state.dart';

class AddFingerprintResponse {
  const AddFingerprintResponse(this.state) : id = null;
  const AddFingerprintResponse.success(this.id) : state = AddFpState.success;

  final AddFpState state;
  final int? id;
}
