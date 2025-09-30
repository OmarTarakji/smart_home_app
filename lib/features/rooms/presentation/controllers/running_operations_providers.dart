import 'package:riverpod_annotation/riverpod_annotation.dart';

part 'running_operations_providers.g.dart';

@riverpod
class RenameRoomLoadingState extends _$RenameRoomLoadingState {
  @override
  bool build() => false;

  void setState(bool state) => this.state = state;
}

@riverpod
class RunningOperations extends _$RunningOperations {
  @override
  int build() => 0;
  void increment() => state++;
  void decrement() => state--;
}
