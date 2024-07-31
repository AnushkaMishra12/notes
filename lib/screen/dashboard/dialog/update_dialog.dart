import 'package:flutter/material.dart';
import 'package:get/get.dart';
import '../../../Data/auth_repo.dart';
import '../data/response_data.dart';
import '../view/dashboard_controller.dart';

class UpdateDialog extends StatelessWidget {
  final ResponseData note;
  const UpdateDialog({super.key, required this.note});

  @override
  Widget build(BuildContext context) {
    final TextEditingController titleController =
        TextEditingController(text: note.title ?? '');
    final TextEditingController descriptionController =
        TextEditingController(text: note.description ?? '');
    final TextEditingController updateTimeController =
        TextEditingController(text: note.updatedAt ?? '');
    final TextEditingController createTimeController =
        TextEditingController(text: note.createdAt ?? '');
    final DashBoardController taskController = Get.find();

    return AlertDialog(
      title: const Text('Update Note'),
      content: StatefulBuilder(
        builder: (BuildContext context, StateSetter setState) {
          return Form(
            key: DashBoardController.to.formKey,
            child: Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                TextFormField(
                  controller: titleController,
                  decoration: const InputDecoration(labelText: 'Note Name'),
                  validator: (value) {
                    if (value == null || value.isEmpty) {
                      return 'Please enter Note Name';
                    }
                    return null;
                  },
                ),
                TextFormField(
                  controller: descriptionController,
                  decoration:
                      const InputDecoration(labelText: 'Note Description'),
                  validator: (value) {
                    if (value == null || value.isEmpty) {
                      return 'Please enter Note Description';
                    }
                    return null;
                  },
                ),
                TextFormField(
                  controller: updateTimeController,
                  decoration: const InputDecoration(labelText: 'Updated At'),
                  validator: (value) {
                    if (value == null || value.isEmpty) {
                      return 'Please enter Note Description';
                    }
                    return null;
                  },
                ),
                TextFormField(
                  controller: createTimeController,
                  decoration: const InputDecoration(labelText: 'Created At'),
                  validator: (value) {
                    if (value == null || value.isEmpty) {
                      return 'Please enter Note Description';
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
                await AuthRepo.updateNotes(note.id.toString(), {
                  'title': titleController.text,
                  'description': descriptionController.text,
                  'createdAt': createTimeController.text,
                  'updatedAt': updateTimeController.text,
                });

                taskController.updateTask(
                  ResponseData(
                    id: note.id,
                    title: titleController.text,
                    description: descriptionController.text,
                    updatedAt: updateTimeController.text,
                    color: note.color,
                    createdAt: createTimeController.text,
                    isCompleted: note.isCompleted,
                    pinned: note.pinned,
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
