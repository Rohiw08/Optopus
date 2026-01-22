import 'package:flutter/material.dart';
import 'package:flutter_colorpicker/flutter_colorpicker.dart';
import 'package:flow_canvas/flow_canvas.dart';

class ColorPickerCard extends StatefulWidget {
  final FlowNode node;
  final FlowCanvasController controller;

  const ColorPickerCard({
    super.key,
    required this.node,
    required this.controller,
  });

  @override
  State<ColorPickerCard> createState() => _ColorPickerCardState();
}

class _ColorPickerCardState extends State<ColorPickerCard> {
  late Color currentColor;
  late Color pickerColor;

  @override
  void initState() {
    super.initState();
    currentColor = widget.node.data['color'] ?? Colors.pink;
    pickerColor = currentColor;
  }

  @override
  void didUpdateWidget(covariant ColorPickerCard oldWidget) {
    super.didUpdateWidget(oldWidget);
    final newColor = widget.node.data['color'];
    if (newColor != null && newColor != currentColor) {
      setState(() {
        currentColor = newColor;
      });
    }
  }

  void changeColor(Color color) {
    setState(() => pickerColor = color);
  }

  void _showColorPickerDialog() {
    pickerColor = currentColor;
    showDialog(
      context: context,
      builder: (context) => AlertDialog(
        title: const Text('Pick a color!'),
        content: SingleChildScrollView(
          child: ColorPicker(
            pickerColor: pickerColor,
            onColorChanged: changeColor,
            paletteType: PaletteType.hsv,
          ),
        ),
        actions: <Widget>[
          ElevatedButton(
            child: const Text('Got it'),
            onPressed: () {
              setState(() {
                currentColor = pickerColor;
              });

              final newNodeData = Map<String, dynamic>.from(widget.node.data);
              newNodeData['color'] = currentColor;
              final updatedNode = widget.node.copyWith(data: newNodeData);
              widget.controller.nodes.updateNode(updatedNode);

              Navigator.of(context).pop();
            },
          ),
        ],
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    String colorString = currentColor.value.toRadixString(16).padLeft(8, '0');
    String hexCode = colorString.substring(2);
    return DefaultNodeWidget(
      node: widget.node,
      child: GestureDetector(
        onTap: _showColorPickerDialog,
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const Padding(
              padding: EdgeInsets.all(10),
              child: Text(
                'shape color',
                style: TextStyle(fontSize: 14, fontWeight: FontWeight.bold),
              ),
            ),
            const Divider(
              height: 1,
              thickness: 1,
              color: Color.fromARGB(25, 0, 0, 0),
            ),
            Expanded(
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  Padding(
                    padding: const EdgeInsets.all(10),
                    child: Row(
                      children: [
                        Container(
                          width: 30,
                          height: 30,
                          decoration: BoxDecoration(
                            color: currentColor,
                            borderRadius: const BorderRadius.all(
                              Radius.circular(6),
                            ),
                            border: Border.all(width: 1),
                          ),
                        ),
                        const SizedBox(width: 10),
                        Text(
                          '#$hexCode',
                          style: const TextStyle(
                            fontSize: 18,
                            fontWeight: FontWeight.w500,
                            fontFamily: 'monospace',
                          ),
                        ),
                      ],
                    ),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
