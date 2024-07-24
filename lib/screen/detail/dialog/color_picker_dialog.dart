import 'package:flutter/material.dart';
import 'package:get/get.dart';

class ColorPickerDialog extends StatelessWidget {
  ColorPickerDialog(
      {super.key,
      required this.onColorSelected,
      required this.isPinned,
      required this.isCompleted,
      required this.pinnedStateChanged,
      required this.completeStateChanged,
      this.selectedColor});
  final colorList = [
    Colors.greenAccent,
    Colors.cyan,
    Colors.lightGreen,
    Colors.lightGreenAccent,
    Colors.grey,
    Colors.yellowAccent,
    Colors.purpleAccent,
    Colors.teal
  ];
  final bool isPinned;
  final bool isCompleted;
  final Color? selectedColor;
  final Function(Color) onColorSelected;
  final Function(bool) pinnedStateChanged;
  final Function(bool) completeStateChanged;

  @override
  Widget build(BuildContext context) {
    return Stack(
      children: [
        Positioned(
          right: 20,
          top: 10,
          child: Material(
            type: MaterialType.transparency,
            child: Container(
              width: 250,
              padding: const EdgeInsets.all(15),
              decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.circular(8),
                boxShadow: const [
                  BoxShadow(
                    color: Colors.black26,
                    blurRadius: 10,
                    offset: Offset(0, 10),
                  ),
                ],
              ),
              child: Column(
                mainAxisSize: MainAxisSize.min,
                children: [
                  const Text(
                    'Note Color',
                    style: TextStyle(
                        fontWeight: FontWeight.bold, color: Colors.black),
                  ),
                  const SizedBox(height: 20),
                  GridView.builder(
                    shrinkWrap: true,
                    itemCount: colorList.length,
                    physics: const NeverScrollableScrollPhysics(),
                    gridDelegate:
                        const SliverGridDelegateWithFixedCrossAxisCount(
                            crossAxisCount: 5),
                    itemBuilder: (context, index) {
                      final item = colorList[index];
                      return _colorCircle(item, onColorSelected);
                    },
                  ),
                  SwitchListTile(
                    title: const Text('Pinned'),
                    value: isPinned,
                    onChanged: pinnedStateChanged,
                  ),
                  SwitchListTile(
                    title: const Text('Completed'),
                    value: isCompleted,
                    onChanged: completeStateChanged,
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.start,
                    children: [
                      TextButton(
                        onPressed: () => Get.back(),
                        child: const Text('share'),
                      ),
                    ],
                  ),
                ],
              ),
            ),
          ),
        ),
      ],
    );
  }

  Widget _colorCircle(Color color, Function(Color) onClick) {
    return GestureDetector(
      onTap: () {
        onClick.call(color);
      },
      child: Container(
        margin: const EdgeInsets.symmetric(horizontal: 8),
        decoration: BoxDecoration(
          shape: BoxShape.circle,
          color: color,
          border: Border.all(
            color: selectedColor == color ? Colors.black : Colors.transparent,
            width: 2,
          ),
        ),
        width: 30,
        height: 30,
      ),
    );
  }
}
