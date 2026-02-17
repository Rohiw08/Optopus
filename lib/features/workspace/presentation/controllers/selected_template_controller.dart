import 'package:riverpod_annotation/riverpod_annotation.dart';

part 'selected_template_controller.g.dart';

@riverpod
class SelectedTemplateController extends _$SelectedTemplateController {
  @override
  int build() => 0;

  void select(int index) {
    state = index;
  }
}
