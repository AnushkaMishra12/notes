import 'package:flutter/material.dart';
import 'package:get/get.dart';
import '../view/dashboard_controller.dart';

class CreateNotesDialog extends StatelessWidget {
  final TextEditingController _titleController = TextEditingController();
  final TextEditingController _descriptionController = TextEditingController();
  final DashBoardController _taskController = Get.find();

  CreateNotesDialog({super.key});

  void _createTask() async {
    final title = _titleController.text;
    final description = _descriptionController.text;

    if (title.isEmpty || description.isEmpty) {
      Get.snackbar('Error', 'Please fill in all fields');
      return;
    }

    try {
      _taskController.createTask(title, description);
      Get.back();
    } catch (e) {
      Get.snackbar('Error', 'Failed to create task: $e');
    }
  }

  @override
  Widget build(BuildContext context) {
    return AlertDialog(
      title: const Text('Create Task'),
      content: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          TextField(
            controller: _titleController,
            decoration: const InputDecoration(labelText: 'Title'),
          ),
          TextField(
            controller: _descriptionController,
            decoration: const InputDecoration(labelText: 'Description'),
          ),
        ],
      ),
      actions: [
        TextButton(
          onPressed: () {
            Get.back(); // Close the dialog
          },
          child: const Text('Cancel'),
        ),
        TextButton(
          onPressed: _createTask,
          child: const Text('Create'),
        ),
      ],
    );
  }
}
