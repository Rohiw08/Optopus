import 'dart:async';
import 'package:riverpod_annotation/riverpod_annotation.dart';

part 'reset_cooldown_provider.g.dart';

@riverpod
class ResetCooldown extends _$ResetCooldown {
  Timer? _timer;

  @override
  int build() {
    ref.onDispose(() => _timer?.cancel());
    return 0;
  }

  void restart([int seconds = 30]) {
    state = seconds;
    start(seconds);
  }

  void start([int seconds = 30]) {
    _timer?.cancel();
    state = seconds;

    _timer = Timer.periodic(const Duration(seconds: 1), (timer) {
      if (state > 0) {
        state--;
      } else {
        _timer?.cancel();
      }
    });
  }
}
