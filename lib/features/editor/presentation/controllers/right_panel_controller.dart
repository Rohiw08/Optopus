import 'package:riverpod_annotation/riverpod_annotation.dart';

part 'right_panel_controller.g.dart';

enum RightPanelType { nodes, json, apiPayload, results }

/// Controls which panel (if any) is shown in the right sidebar.
@riverpod
class RightPanelController extends _$RightPanelController {
  @override
  RightPanelType? build() => null;

  void show(RightPanelType type) => state = type;

  void toggle(RightPanelType type) {
    state = (state == type) ? null : type;
  }

  void hide() => state = null;
}
