import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'color_picker_controller.dart';

class ColorPickerDialog extends StatelessWidget {
  final ColorPickerController colorPickerController =
      Get.put(ColorPickerController());

  ColorPickerDialog({super.key});

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
                  Wrap(
                    spacing: 10,
                    runSpacing: 10,
                    children: [
                      _colorCircle(Colors.green),
                      _colorCircle(Colors.red),
                      _colorCircle(Colors.blue),
                      _colorCircle(Colors.yellow),
                      _colorCircle(Colors.orange),
                      _colorCircle(Colors.purple),
                      _colorCircle(Colors.pink),
                      _colorCircle(Colors.grey),
                    ],
                  ),
                  Obx(() => SwitchListTile(
                        title: const Text('Pinned'),
                        value: colorPickerController.isPasswordEnabled.value,
                        onChanged: (value) {
                          colorPickerController.isPasswordEnabled.value = value;
                        },
                      )),
                  Obx(() => SwitchListTile(
                        title: const Text('Completed'),
                        value: colorPickerController.isReminderEnabled.value,
                        onChanged: (value) {
                          colorPickerController.isReminderEnabled.value = value;
                        },
                      )),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.start,
                    children: [
                      TextButton(
                        onPressed: () => Get.back(),
                        child: const Text('share'),
                      ),
                      TextButton(
                        onPressed: () {
                          // Handle save action
                          Get.back();
                        },
                        child: const Text('delete'),
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

  Widget _colorCircle(Color color) {
    return GestureDetector(
      onTap: () {
        colorPickerController.changeColor(color);
      },
      child: Obx(
        () => Container(
          decoration: BoxDecoration(
            shape: BoxShape.circle,
            color: color,
            border: Border.all(
              color: colorPickerController.selectedColor.value == color
                  ? Colors.black
                  : Colors.transparent,
              width: 2,
            ),
          ),
          width: 30,
          height: 30,
        ),
      ),
    );
  }
}
