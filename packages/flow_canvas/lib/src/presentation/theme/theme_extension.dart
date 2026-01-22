import 'package:flow_canvas/src/presentation/theme/flow_theme.dart';
import 'package:flow_canvas/src/presentation/theme/theme_provider.dart';
import 'package:flutter/widgets.dart';

extension FlowCanvasThemeExtension on BuildContext {
  FlowCanvasTheme get flowCanvasTheme {
    return FlowCanvasThemeProvider.of(this);
  }

  FlowCanvasTheme? get flowCanvasThemeMaybe {
    return FlowCanvasThemeProvider.maybeOf(this);
  }
}
