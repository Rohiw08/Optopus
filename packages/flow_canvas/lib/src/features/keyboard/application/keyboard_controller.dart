import 'package:flow_canvas/src/core/canvas/flow_canvas_internal_controller.dart';
import 'package:flow_canvas/src/features/keyboard/application/keyboard_action_service.dart';
import 'package:flow_canvas/src/core/options/components/keyboard_options.dart';
import 'package:flow_canvas/src/core/enums/enums.dart';
import 'package:flutter/widgets.dart';

class KeyboardController {
  final FlowCanvasInternalController _controller;
  final KeyboardActionService _keyboardActionService;

  KeyboardController({
    required FlowCanvasInternalController controller,
    required KeyboardActionService keyboardActionService,
  })  : _controller = controller,
        _keyboardActionService = keyboardActionService;

  /// Executes a canvas action based on a keyboard event.
  void handleKeyboardAction(
    KeyboardAction action, {
    required KeyboardOptions options,
    required double minZoom,
    required double maxZoom,
  }) {
    // Actions like undo/redo are handled by the HistoryController, not the service.
    if (action == KeyboardAction.undo) {
      _controller.history.undo();
      return;
    }
    if (action == KeyboardAction.redo) {
      _controller.history.redo();
      return;
    }

    // For all other actions, mutate the state via the service.
    _controller.mutate((s) => _keyboardActionService.handleAction(
          s,
          action,
          arrowMoveDelta:
              Offset(options.arrowKeyMoveSpeed, options.arrowKeyMoveSpeed),
          zoomStep: options.zoomStep,
          minZoom: minZoom,
          maxZoom: maxZoom,
        ));
  }
}
