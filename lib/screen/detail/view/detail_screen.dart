import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:notes/utils/date.dart';
import 'package:notes/utils/ext.dart';
import '../dialog/color_picker_dialog.dart';
import 'detail_controller.dart';

class DetailScreen extends StatelessWidget {
  const DetailScreen({super.key});

  @override
  Widget build(BuildContext context) {
    Get.put(DetailController());
    return Scaffold(
      appBar: AppBar(
        title: const Text(
          'Notes Details',
          style: TextStyle(
              fontWeight: FontWeight.bold, fontSize: 24, color: Colors.black),
        ),
        actions: [
          Obx(
            () => TextButton(
              onPressed: () {
                DetailController.to.editable.value =
                    !DetailController.to.editable.value;
              },
              child: Text(
                DetailController.to.editable.isFalse
                    ? 'Edit'
                    : DetailController.to.listData.value != null
                        ? "Update"
                        : "Save",
                style: const TextStyle(
                    fontWeight: FontWeight.bold,
                    fontSize: 24,
                    color: Colors.black),
              ),
            ),
          ),
          TextButton(
            onPressed: () {
              showDialog(
                context: context,
                builder: (BuildContext context) {
                  return Obx(
                    () => ColorPickerDialog(
                      isCompleted:
                          DetailController.to.listData.value?.isCompleted ??
                              false,
                      isPinned:
                          DetailController.to.listData.value?.pinned ?? false,
                      selectedColor:
                          DetailController.to.listData.value?.color.toColor(),
                      completeStateChanged: (isCompleted) {
                        DetailController.to.listData.value = DetailController
                            .to.listData.value
                            ?.copyWith(isCompleted: isCompleted);
                      },
                      onColorSelected: (color) {
                        debugPrint("=============> ${color.toHex()}");
                        DetailController.to.listData.value = DetailController
                            .to.listData.value
                            ?.copyWith(color: color.toHex());
                      },
                      pinnedStateChanged: (isPinned) {
                        DetailController.to.listData.value = DetailController
                            .to.listData.value
                            ?.copyWith(pinned: isPinned);
                      },
                    ),
                  );
                },
                barrierDismissible: true,
              );
            },
            child: const Icon(
              Icons.camera,
              size: 35,
            ),
          ),
        ],
      ),
      body: Stack(
        children: [
          Container(
            padding: const EdgeInsets.all(10),
            margin: const EdgeInsets.only(top: 10, bottom: 100),
            child: Obx(
              () => Container(
                width: double.infinity,
                margin: const EdgeInsets.all(10),
                decoration: BoxDecoration(
                    border: Border.all(color: Colors.black, width: 1),
                    color: DetailController.to.listData.value?.color.toColor(),
                    borderRadius: BorderRadius.circular(10)),
                child: Column(
                  children: [
                    const SizedBox(height: 10),
                    TextField(
                      controller: DetailController.to.titleController,
                      textAlign: TextAlign.center,
                      readOnly: !DetailController.to.editable.value,
                      decoration: const InputDecoration(
                        border: InputBorder.none,
                      ),
                      style: const TextStyle(
                          fontSize: 24,
                          fontWeight: FontWeight.bold,
                          color: Colors.black),
                    ),
                    const SizedBox(height: 20),
                    const Divider(color: Colors.black, thickness: 2),
                    const SizedBox(height: 20),
                    Expanded(
                      child: SingleChildScrollView(
                        padding: const EdgeInsets.all(5),
                        child: Column(
                          children: [
                            TextField(
                              maxLines: null,
                              controller:
                                  DetailController.to.descriptionController,
                              textAlign: TextAlign.center,
                              readOnly: !DetailController.to.editable.value,
                              decoration: const InputDecoration(
                                border: InputBorder.none,
                              ),
                              style: const TextStyle(
                                  fontSize: 18,
                                  fontWeight: FontWeight.bold,
                                  color: Colors.black),
                            ),
                            const SizedBox(height: 20),
                            Text(
                              DetailController.to.listData.value?.updatedAt
                                      .toDateTime()
                                      ?.toDateString() ??
                                  '',
                              textAlign: TextAlign.left,
                              style: const TextStyle(
                                  fontSize: 16,
                                  fontWeight: FontWeight.bold,
                                  color: Colors.black54),
                            ),
                            const SizedBox(height: 20),
                            Text(
                              DetailController.to.listData.value?.createdAt
                                      .toDateTime()
                                      ?.toDateString() ??
                                  '',
                              textAlign: TextAlign.left,
                              style: const TextStyle(
                                  fontSize: 16,
                                  fontWeight: FontWeight.bold,
                                  color: Colors.black38),
                            ),
                          ],
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ),
          Align(
            alignment: Alignment.bottomCenter,
            child: Container(
              margin: const EdgeInsets.all(15),
              child: Row(
                children: [
                  Expanded(
                    child: FloatingActionButton.extended(
                      extendedIconLabelSpacing: 15,
                      onPressed: () {
                        DetailController.to.updateNotes();
                      },
                      label: const Text(
                        "Update Note",
                        style: TextStyle(color: Colors.white),
                      ),
                      backgroundColor: Colors.black,
                    ),
                  ),
                  const SizedBox(width: 16),
                  FloatingActionButton(
                    onPressed: () {},
                    backgroundColor: Colors.black,
                    child: const Icon(
                      Icons.dashboard_rounded,
                      color: Colors.white,
                    ),
                  ),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
}
