import 'package:flutter/material.dart';
import 'package:get/get.dart';
import '../../../Data/AuthRepo.dart';
import '../data/ResponseData.dart';
import '../view/DashBoardController.dart';

class UpdateDialog extends StatelessWidget {
  final ResponseData task;
  const UpdateDialog({super.key, required this.task});

  @override
  Widget build(BuildContext context) {
    final TextEditingController titleController =
        TextEditingController(text: task.title ?? '');
    final TextEditingController descriptionController =
        TextEditingController(text: task.description ?? '');
    final TextEditingController updateTimeController =
        TextEditingController(text: task.updatedAt ?? '');
    final TextEditingController createTimeController =
        TextEditingController(text: task.createdAt ?? '');
    final DashBoardController taskController = Get.find();

    return AlertDialog(
      title: const Text('Update Task'),
      content: StatefulBuilder(
        builder: (BuildContext context, StateSetter setState) {
          return Form(
            key: DashBoardController.to.formKey,
            child: Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                TextFormField(
                  controller: titleController,
                  decoration: const InputDecoration(labelText: 'Task Name'),
                  validator: (value) {
                    if (value == null || value.isEmpty) {
                      return 'Please enter Task Name';
                    }
                    return null;
                  },
                ),
                TextFormField(
                  controller: descriptionController,
                  decoration:
                      const InputDecoration(labelText: 'Task Description'),
                  validator: (value) {
                    if (value == null || value.isEmpty) {
                      return 'Please enter Task Description';
                    }
                    return null;
                  },
                ),
                TextFormField(
                  controller: updateTimeController,
                  decoration: const InputDecoration(labelText: 'Updated At'),
                  validator: (value) {
                    if (value == null || value.isEmpty) {
                      return 'Please enter Task Description';
                    }
                    return null;
                  },
                ),
                TextFormField(
                  controller: createTimeController,
                  decoration: const InputDecoration(labelText: 'Created At'),
                  validator: (value) {
                    if (value == null || value.isEmpty) {
                      return 'Please enter Task Description';
                    }
                    return null;
                  },
                ),
              ],
            ),
          );
        },
      ),
      actions: [
        TextButton(
          onPressed: () {
            Navigator.of(context).pop();
          },
          child: const Text('Cancel'),
        ),
        ElevatedButton(
          onPressed: () async {
            if (DashBoardController.to.formKey.currentState!.validate()) {
              try {
                await AuthRepo.updateTask(task.id.toString(), {
                  'title': titleController.text,
                  'description': descriptionController.text,
                  'createdAt': createTimeController.text,
                  'updatedAt': updateTimeController.text,
                });

                taskController.updateTask(
                  ResponseData(
                    id: task.id,
                    title: titleController.text,
                    description: descriptionController.text,
                    updatedAt: updateTimeController.text,
                    color: task.color,
                    createdAt: createTimeController.text,
                    isCompleted: task.isCompleted,
                    pinned: task.pinned,
                  ),
                );

                if (context.mounted) {
                  Navigator.of(context).pop();
                  ScaffoldMessenger.of(context).showSnackBar(
                    const SnackBar(content: Text('Task updated successfully')),
                  );
                }
              } catch (e) {
                if (context.mounted) {
                  ScaffoldMessenger.of(context).showSnackBar(
                    const SnackBar(content: Text('Failed to update task')),
                  );
                }
              }
            }
          },
          child: const Text('Update'),
        ),
      ],
    );
  }
}
