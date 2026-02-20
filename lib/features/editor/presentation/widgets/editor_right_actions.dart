import 'package:flow_canvas/flow_canvas.dart';
import 'package:flutter/material.dart';
import 'package:optopus/core/widgets/sidebar_content_bar.dart';
import 'package:optopus/features/flows/domain/entities/flow_entity.dart';
import 'package:optopus/features/editor/presentation/controllers/editor_controller.dart';
import 'package:optopus/features/editor/presentation/controllers/right_panel_controller.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

// Consistent icon size for all sidebar buttons
const double _kIconSize = 18.0;

class EditorRightActions extends ConsumerWidget {
  final double width;
  final FlowCanvasController controller;
  final FlowEntity? flow;

  const EditorRightActions({
    super.key,
    required this.width,
    required this.controller,
    this.flow,
  });

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final activePanel = ref.watch(rightPanelControllerProvider);

    return SideBar(
      minWidth: 40,
      width: width,
      height: double.infinity,
      border: Border(
        left: BorderSide(color: Theme.of(context).dividerColor, width: 0.5),
      ),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.start,
        children: [
          const SizedBox(height: 12),

          // ── Browse Nodes ────────────────────────────────────────────────
          _PanelToggleButton(
            icon: Icons.grid_view_rounded,
            panelType: RightPanelType.nodes,
            activePanel: activePanel,
            tooltip: 'Browse Nodes',
          ),

          // ── Canvas JSON ─────────────────────────────────────────────────
          _PanelToggleButton(
            icon: Icons.code_rounded,
            panelType: RightPanelType.json,
            activePanel: activePanel,
            tooltip: 'Canvas JSON',
          ),

          if (flow != null) ...[
            // ── API Payload Preview ─────────────────────────────────────
            _PanelToggleButton(
              icon: Icons.upload_rounded,
              panelType: RightPanelType.apiPayload,
              activePanel: activePanel,
              tooltip: 'API Payload (sent to backend)',
            ),

            // ── Save ────────────────────────────────────────────────────
            Consumer(
              builder: (context, ref, child) {
                final isSaving = ref.watch(isSavingProvider);
                return _ActionButton(
                  icon: Icons.save_outlined,
                  iconWidget: isSaving
                      ? SizedBox.square(
                          dimension: _kIconSize,
                          child: const CircularProgressIndicator(
                            strokeWidth: 1.5,
                          ),
                        )
                      : null,
                  tooltip: isSaving ? 'Saving...' : 'Save Flow',
                  onPressed: isSaving
                      ? null
                      : () async {
                          final json = controller.currentState.toJson();
                          await ref
                              .read(editorControllerProvider.notifier)
                              .saveFlow(flowId: flow!.id, data: json);
                          if (context.mounted) {
                            ScaffoldMessenger.of(context).showSnackBar(
                              const SnackBar(content: Text('Flow saved')),
                            );
                          }
                        },
                );
              },
            ),

            // ── Run Flow ────────────────────────────────────────────────
            Consumer(
              builder: (context, ref, child) {
                final execState = ref.watch(editorControllerProvider);
                final isRunning = execState.isLoading;
                final hasResults = execState.when(
                  data: (d) => d != null,
                  error: (_, e) => false,
                  loading: () => false,
                );

                final color = isRunning || !hasResults
                    ? null
                    : Colors.green.shade400;

                return _ActionButton(
                  icon: Icons.play_circle_outline_rounded,
                  tooltip: isRunning ? 'Running...' : 'Run Flow',
                  iconColor: color,
                  iconWidget: isRunning
                      ? SizedBox.square(
                          dimension: _kIconSize,
                          child: const CircularProgressIndicator(
                            strokeWidth: 1.5,
                          ),
                        )
                      : null,
                  onPressed: isRunning
                      ? null
                      : () async {
                          final json = controller.currentState.toJson();
                          await ref
                              .read(editorControllerProvider.notifier)
                              .executeFlow(
                                flowId: flow!.id,
                                flowName: flow!.name,
                                data: json,
                              );
                          if (!context.mounted) return;
                          ref
                              .read(editorControllerProvider)
                              .whenOrNull(
                                data: (_) => ref
                                    .read(rightPanelControllerProvider.notifier)
                                    .show(RightPanelType.results),
                                error: (err, _) =>
                                    ScaffoldMessenger.of(context).showSnackBar(
                                      SnackBar(
                                        content: Text('Execution error: $err'),
                                        backgroundColor: Colors.red,
                                      ),
                                    ),
                              );
                        },
                );
              },
            ),

            // ── Results (appears after a run) ───────────────────────────
            Consumer(
              builder: (context, ref, child) {
                final execState = ref.watch(editorControllerProvider);
                final hasResults = execState.when(
                  data: (d) => d != null,
                  error: (_, e) => false,
                  loading: () => false,
                );
                if (!hasResults) return const SizedBox.shrink();
                return _PanelToggleButton(
                  icon: Icons.bar_chart_rounded,
                  panelType: RightPanelType.results,
                  activePanel: activePanel,
                  tooltip: 'Results',
                );
              },
            ),
          ],
        ],
      ),
    );
  }
}

// ─── Shared button widgets ────────────────────────────────────────────────────

/// Icon button that toggles a side panel and highlights when that panel is open.
class _PanelToggleButton extends ConsumerWidget {
  final IconData icon;
  final RightPanelType panelType;
  final RightPanelType? activePanel;
  final String tooltip;

  const _PanelToggleButton({
    required this.icon,
    required this.panelType,
    required this.activePanel,
    required this.tooltip,
  });

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final isActive = activePanel == panelType;
    final color = isActive
        ? Theme.of(context).colorScheme.primary
        : Theme.of(context).iconTheme.color?.withAlpha(180);

    return _ActionButton(
      icon: icon,
      tooltip: tooltip,
      iconColor: color,
      onPressed: () =>
          ref.read(rightPanelControllerProvider.notifier).toggle(panelType),
    );
  }
}

/// Thin, consistent icon button with optional colour and loading widget.
class _ActionButton extends StatelessWidget {
  final IconData icon;
  final String tooltip;
  final Color? iconColor;
  final Widget? iconWidget;
  final VoidCallback? onPressed;

  const _ActionButton({
    required this.icon,
    required this.tooltip,
    this.iconColor,
    this.iconWidget,
    this.onPressed,
  });

  @override
  Widget build(BuildContext context) {
    final defaultColor =
        Theme.of(context).iconTheme.color?.withAlpha(180) ??
        Theme.of(context).colorScheme.onSurface;

    return Tooltip(
      message: tooltip,
      preferBelow: false,
      child: SizedBox(
        width: 36,
        height: 36,
        child: IconButton(
          padding: EdgeInsets.zero,
          iconSize: _kIconSize,
          onPressed: onPressed,
          icon:
              iconWidget ??
              Icon(icon, size: _kIconSize, color: iconColor ?? defaultColor),
        ),
      ),
    );
  }
}
