import 'package:riverpod_annotation/riverpod_annotation.dart';

part 'auth_view_provider.g.dart';

// 0 signin
// 1 signup
// 2 reset password

@riverpod
class AuthView extends _$AuthView {
  @override
  int build() {
    return 0;
  }

  void set(int view) {
    state = view;
  }
}
