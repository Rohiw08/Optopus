import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flow_canvas/flow_canvas.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:optopus/features/nodes/domain/entities/entity_schema.dart';
import 'package:optopus/features/nodes/presentation/providers/entity_schema_provider.dart';

// ─── Domain helpers ──────────────────────────────────────────────────────────

Color _domainColor(String domain) {
  switch (domain) {
    case 'logistics':
      return const Color(0xFF2196F3);
    case 'manufacturing':
      return const Color(0xFFFFC107);
    case 'aviation':
      return const Color(0xFF26C6DA);
    default:
      return const Color(0xFFEF5350);
  }
}

IconData _domainIcon(String domain) {
  switch (domain) {
    case 'logistics':
      return Icons.local_shipping_rounded;
    case 'manufacturing':
      return Icons.precision_manufacturing_rounded;
    case 'aviation':
      return Icons.flight_rounded;
    default:
      return Icons.hub_rounded;
  }
}

/// Returns a short human-readable type tag for the sidebar badge.
String _typeTag(String type) {
  switch (type) {
    case 'float':
      return 'float';
    case 'int':
      return 'int';
    case 'bool':
      return 'bool';
    default:
      return 'text';
  }
}

// ─── Handles ─────────────────────────────────────────────────────────────────

/// Provides type-appropriate FlowHandles for a node.
///   source → right-side SOURCE only
///   sink   → left-side  TARGET only
///   others → left TARGET + right SOURCE
Map<String, FlowHandle> handlesForType(String type, Size nodeSize) {
  // In FlowCanvas, FlowPositioned uses a Cartesian coordinate system
  // relative to the center of the node:
  // - Origin (0,0) is the center of the node
  // - +x is right
  // - +y is UP

  final halfWidth = nodeSize.width / 2;

  final target = FlowHandle(
    id: 'in',
    type: HandleType.target,
    position: Offset(-halfWidth, 0),
    size: const Size(14, 14),
  );

  final source = FlowHandle(
    id: 'out',
    type: HandleType.source,
    position: Offset(halfWidth, 0),
    size: const Size(14, 14),
  );

  switch (type) {
    case 'source':
      return {'out': source};
    case 'sink':
      return {'in': target};
    default:
      return {'in': target, 'out': source};
  }
}

// ─── OptopusNode ─────────────────────────────────────────────────────────────

/// Schema-driven node widget that fetches its properties from the API and
/// renders them as compact, DB-schema-style rows.
class OptopusNode extends ConsumerStatefulWidget {
  final FlowNode node;
  final FlowCanvasController controller;

  const OptopusNode({super.key, required this.node, required this.controller});

  @override
  ConsumerState<OptopusNode> createState() => _OptopusNodeState();
}

class _OptopusNodeState extends ConsumerState<OptopusNode> {
  final Map<String, TextEditingController> _textControllers = {};

  /// Track the last schema type we resized for to avoid redundant updates.
  String? _sizedForSchema;

  String get _nodeType => widget.node.data['label'] as String? ?? '';

  @override
  void dispose() {
    for (final c in _textControllers.values) c.dispose();
    super.dispose();
  }

  void _ensureControllers(
    List<EntityPropertySchema> props,
    Map<String, dynamic> currentData,
  ) {
    for (final p in props) {
      if (!_textControllers.containsKey(p.name)) {
        // Prefer any already-saved value on the node, otherwise fall back to schema default
        final saved = currentData[p.name];
        final initial = saved != null
            ? saved.toString()
            : (p.defaultValue ?? '').toString();
        _textControllers[p.name] = TextEditingController(text: initial);
      }
    }
  }

  /// Gather all current text field values and persist them to the canvas state.
  void _savePropertiesToCanvas(List<EntityPropertySchema> props) {
    final existing = Map<String, dynamic>.from(widget.node.data);
    for (final p in props) {
      final ctrl = _textControllers[p.name];
      if (ctrl == null) continue;
      final text = ctrl.text;
      if (p.type == 'float') {
        existing[p.name] = double.tryParse(text) ?? text;
      } else if (p.type == 'int') {
        existing[p.name] = int.tryParse(text) ?? text;
      } else if (p.type == 'bool') {
        existing[p.name] = text.toLowerCase() == 'true';
      } else {
        existing[p.name] = text;
      }
    }
    widget.controller.nodes.updateNode(widget.node.copyWith(data: existing));
  }

  @override
  Widget build(BuildContext context) {
    final schemaAsync = ref.watch(entitySchemaProvider(_nodeType));

    return schemaAsync.when(
      data: (schema) {
        _ensureControllers(schema.properties, widget.node.data);
        final accent = _domainColor(schema.domain);

        // Auto-resize the node to fit its property count — only once per schema
        if (_sizedForSchema != schema.type) {
          _sizedForSchema = schema.type;
          const headerHeight = 44.0;
          const rowHeight = 66.0;
          final desiredHeight =
              headerHeight + schema.properties.length * rowHeight;
          const desiredWidth = 220.0;

          // Recalculate handles for the correct final size
          final newHandles = handlesForType(
            schema.type,
            Size(desiredWidth, desiredHeight),
          );

          WidgetsBinding.instance.addPostFrameCallback((_) {
            if (!mounted) return;
            widget.controller.nodes.updateNode(
              widget.node.copyWith(
                size: Size(desiredWidth, desiredHeight),
                handles: newHandles,
              ),
            );
          });
        }

        return DefaultNodeWidget(
          node: widget.node,
          handleBuilder: (context, state, style, handleType) {
            final isSource = handleType == HandleType.source;
            final isActive = state.active || state.hovered || state.validTarget;
            final baseColor = state.validTarget
                ? Colors.green
                : isActive
                ? accent
                : accent.withAlpha(180);
            final sz = isActive ? 13.0 : 10.0;

            return AnimatedContainer(
              duration: const Duration(milliseconds: 150),
              width: sz,
              height: sz,
              decoration: BoxDecoration(
                color: baseColor,
                // SOURCE (output) → circle  |  TARGET (input) → rounded square
                shape: isSource ? BoxShape.circle : BoxShape.rectangle,
                borderRadius: isSource ? null : BorderRadius.circular(3),
                border: Border.all(color: Colors.white.withAlpha(80), width: 1),
                boxShadow: isActive
                    ? [BoxShadow(color: accent.withAlpha(120), blurRadius: 6)]
                    : null,
              ),
            );
          },
          style: FlowNodeStyle.system(context).copyWith(
            decoration: BoxDecoration(
              color: Theme.of(context).colorScheme.surface,
              borderRadius: BorderRadius.circular(8),
              border: Border.all(
                color: Theme.of(context).colorScheme.outlineVariant,
                width: 1,
              ),
              boxShadow: [
                BoxShadow(
                  color: Colors.black.withAlpha(80),
                  blurRadius: 16,
                  offset: const Offset(0, 6),
                ),
              ],
            ),
            selectedDecoration: BoxDecoration(
              color: Theme.of(context).colorScheme.surface,
              borderRadius: BorderRadius.circular(8),
              border: Border.all(color: accent, width: 1.5),
              boxShadow: [
                BoxShadow(
                  color: accent.withAlpha(60),
                  blurRadius: 20,
                  offset: const Offset(0, 6),
                ),
              ],
            ),
            hoverDecoration: BoxDecoration(
              color: Theme.of(context).colorScheme.surfaceBright,
              borderRadius: BorderRadius.circular(8),
              border: Border.all(
                color: Theme.of(context).colorScheme.outline,
                width: 1,
              ),
              boxShadow: [
                BoxShadow(
                  color: Colors.black.withAlpha(60),
                  blurRadius: 12,
                  offset: const Offset(0, 4),
                ),
              ],
            ),
          ),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [
              // ── Accent top bar ────────────────────────────────────────────
              Container(
                height: 3,
                decoration: BoxDecoration(
                  color: accent,
                  borderRadius: const BorderRadius.vertical(
                    top: Radius.circular(7),
                  ),
                ),
              ),
              // ── Header ──────────────────────────────────────────────────
              Container(
                padding: const EdgeInsets.symmetric(
                  horizontal: 12,
                  vertical: 9,
                ),
                decoration: BoxDecoration(
                  color: Theme.of(context).colorScheme.surfaceBright,
                  border: Border(
                    bottom: BorderSide(
                      color: Theme.of(context).colorScheme.outlineVariant,
                      width: 1,
                    ),
                  ),
                ),
                child: Row(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    Icon(_domainIcon(schema.domain), color: accent, size: 14),
                    const SizedBox(width: 7),
                    Expanded(
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            schema.type.toUpperCase(),
                            style: GoogleFonts.inter(
                              fontWeight: FontWeight.w700,
                              fontSize: 12,
                              color: Theme.of(context).colorScheme.onSurface,
                              letterSpacing: 0.5,
                            ),
                            overflow: TextOverflow.ellipsis,
                          ),
                          const SizedBox(height: 2),
                          Row(
                            children: [
                              Expanded(
                                child: Text(
                                  widget.node.id,
                                  style: GoogleFonts.firaCode(
                                    fontSize: 9,
                                    color: Theme.of(
                                      context,
                                    ).colorScheme.onSurface.withAlpha(120),
                                  ),
                                  overflow: TextOverflow.ellipsis,
                                ),
                              ),
                              MouseRegion(
                                cursor: SystemMouseCursors.click,
                                child: GestureDetector(
                                  onTap: () async {
                                    await Clipboard.setData(
                                      ClipboardData(text: widget.node.id),
                                    );
                                    if (context.mounted) {
                                      ScaffoldMessenger.of(
                                        context,
                                      ).showSnackBar(
                                        const SnackBar(
                                          content: Text('Copied node ID!'),
                                          duration: Duration(seconds: 2),
                                        ),
                                      );
                                    }
                                  },
                                  child: Icon(
                                    Icons.copy_rounded,
                                    size: 11,
                                    color: Theme.of(
                                      context,
                                    ).colorScheme.onSurface.withAlpha(120),
                                  ),
                                ),
                              ),
                            ],
                          ),
                        ],
                      ),
                    ),
                    const SizedBox(width: 6),
                    Container(
                      padding: const EdgeInsets.symmetric(
                        horizontal: 5,
                        vertical: 2,
                      ),
                      decoration: BoxDecoration(
                        color: accent.withAlpha(25),
                        borderRadius: BorderRadius.circular(3),
                      ),
                      child: Text(
                        schema.domain,
                        style: GoogleFonts.inter(
                          fontSize: 9,
                          color: accent.withAlpha(220),
                          fontWeight: FontWeight.w500,
                        ),
                      ),
                    ),
                  ],
                ),
              ),

              // ── Property rows ────────────────────────────────────────────
              ...schema.properties
                  .map(
                    (prop) => _PropertyRow(
                      prop: prop,
                      controller: _textControllers[prop.name]!,
                      accent: accent,
                      onChanged: (_) =>
                          _savePropertiesToCanvas(schema.properties),
                      onBoolChanged: (_) =>
                          _savePropertiesToCanvas(schema.properties),
                    ),
                  )
                  .toList(),
            ],
          ),
        );
      },
      loading: () => _Placeholder(
        width: 220,
        child: const Center(child: CircularProgressIndicator(strokeWidth: 2)),
      ),
      error: (err, _) => _Placeholder(
        width: 220,
        child: Text(
          'Error: $err',
          style: const TextStyle(color: Colors.redAccent, fontSize: 10),
        ),
      ),
    );
  }
}

// ─── _PropertyRow ─────────────────────────────────────────────────────────────

class _PropertyRow extends StatelessWidget {
  final EntityPropertySchema prop;
  final TextEditingController controller;
  final Color accent;
  final ValueChanged<String>? onChanged;
  final ValueChanged<bool>? onBoolChanged;

  const _PropertyRow({
    required this.prop,
    required this.controller,
    required this.accent,
    this.onChanged,
    this.onBoolChanged,
  });

  @override
  Widget build(BuildContext context) {
    final isBool = prop.type == 'bool';
    final isNumeric = prop.type == 'float' || prop.type == 'int';

    return Container(
      decoration: const BoxDecoration(
        border: Border(bottom: BorderSide(color: Color(0xFF252839), width: 1)),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        mainAxisSize: MainAxisSize.min,
        children: [
          // Label row: name left, type badge right
          Padding(
            padding: const EdgeInsets.fromLTRB(12, 8, 12, 3),
            child: Row(
              children: [
                // Small dot indicator
                Container(
                  width: 6,
                  height: 6,
                  margin: const EdgeInsets.only(right: 7),
                  decoration: BoxDecoration(
                    shape: BoxShape.circle,
                    color: prop.required
                        ? accent.withAlpha(200)
                        : const Color(0xFF4A4E6A),
                  ),
                ),
                // Field name
                Expanded(
                  child: Text(
                    prop.name,
                    style: GoogleFonts.inter(
                      fontSize: 11,
                      color: prop.required
                          ? Theme.of(
                              context,
                            ).colorScheme.onSurface.withAlpha(220)
                          : Theme.of(
                              context,
                            ).colorScheme.onSurface.withAlpha(140),
                      fontWeight: prop.required
                          ? FontWeight.w500
                          : FontWeight.w400,
                    ),
                    overflow: TextOverflow.ellipsis,
                  ),
                ),
                if (prop.required)
                  Padding(
                    padding: const EdgeInsets.only(right: 4),
                    child: Text(
                      '*',
                      style: TextStyle(
                        color: accent,
                        fontSize: 11,
                        fontWeight: FontWeight.w700,
                      ),
                    ),
                  ),
                // Type badge
                Text(
                  _typeTag(prop.type),
                  style: GoogleFonts.firaCode(
                    fontSize: 9,
                    color: Theme.of(
                      context,
                    ).colorScheme.onSurface.withAlpha(70),
                    fontWeight: FontWeight.w400,
                  ),
                ),
              ],
            ),
          ),

          // Input field
          Padding(
            padding: const EdgeInsets.fromLTRB(12, 0, 12, 8),
            child: isBool
                ? _boolField(context)
                : _textField(context, isNumeric),
          ),
        ],
      ),
    );
  }

  Widget _textField(BuildContext context, bool isNumeric) {
    return TextField(
      controller: controller,
      keyboardType: isNumeric
          ? const TextInputType.numberWithOptions(decimal: true)
          : TextInputType.text,
      inputFormatters: isNumeric
          ? [FilteringTextInputFormatter.allow(RegExp(r'[-0-9.]'))]
          : null,
      onChanged: onChanged,
      style: GoogleFonts.firaCode(
        fontSize: 11,
        color: Theme.of(context).colorScheme.onSurface.withAlpha(200),
      ),
      decoration: InputDecoration(
        hintText: prop.description,
        hintStyle: GoogleFonts.inter(
          fontSize: 10,
          color: Theme.of(context).colorScheme.onSurface.withAlpha(50),
        ),
        isDense: true,
        contentPadding: const EdgeInsets.symmetric(horizontal: 8, vertical: 6),
        filled: true,
        fillColor: Theme.of(context).colorScheme.surface,
        border: OutlineInputBorder(
          borderRadius: BorderRadius.circular(4),
          borderSide: BorderSide.none,
        ),
        enabledBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(4),
          borderSide: const BorderSide(color: Color(0xFF363A55), width: 1),
        ),
        focusedBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(4),
          borderSide: BorderSide(color: accent, width: 1),
        ),
      ),
    );
  }

  Widget _boolField(BuildContext context) {
    return StatefulBuilder(
      builder: (context, setLocalState) {
        final val = (controller.text.toLowerCase() == 'true');
        return Row(
          children: [
            SizedBox(
              height: 20,
              child: Switch.adaptive(
                value: val,
                onChanged: (v) {
                  setLocalState(() => controller.text = v.toString());
                  onBoolChanged?.call(v);
                },
                materialTapTargetSize: MaterialTapTargetSize.shrinkWrap,
                activeColor: accent,
              ),
            ),
            const SizedBox(width: 6),
            Text(
              prop.description,
              style: GoogleFonts.inter(
                fontSize: 10,
                color: Colors.white.withAlpha(120),
              ),
            ),
          ],
        );
      },
    );
  }
}

// ─── _Placeholder ─────────────────────────────────────────────────────────────

class _Placeholder extends StatelessWidget {
  final double width;
  final Widget child;

  const _Placeholder({required this.width, required this.child});

  @override
  Widget build(BuildContext context) {
    return Container(
      width: width,
      height: 80,
      padding: const EdgeInsets.all(12),
      decoration: BoxDecoration(
        color: const Color(0xFF1A1D27),
        borderRadius: BorderRadius.circular(8),
        border: Border.all(color: const Color(0xFF2E3147)),
      ),
      child: child,
    );
  }
}
