import 'package:flutter/material.dart';
import 'package:get/get.dart';
import '../dialog/color_picker_controller.dart';
import '../dialog/color_picker_dialog.dart';
import 'detail_controller.dart';

class DetailScreen extends StatelessWidget {
  DetailScreen({super.key});
  final ColorPickerController colorPickerController =
      Get.put(ColorPickerController());

  @override
  Widget build(BuildContext context) {
    Get.put(DetailController());
    return Scaffold(
      appBar: AppBar(
        title: const Text(
          'Notes Details',
          // '${DetailController.to.listData?.title}',
          style: TextStyle(
              fontWeight: FontWeight.bold, fontSize: 24, color: Colors.black),
        ),
        actions: [
          // Obx(
          //   () => TextButton(
          //     onPressed: () {
          //       DetailController.to.editable.value =
          //           !DetailController.to.editable.value;
          //     },
          //     child: Text(
          //       DetailController.to.editable.isFalse
          //           ? 'Edit'
          //           : DetailController.to.listData != null
          //               ? "Update"
          //               : "Save",
          //       // 'Email: ${DetailController.to.listData.title}',
          //       style: const TextStyle(
          //           fontWeight: FontWeight.bold,
          //           fontSize: 24,
          //           color: Colors.black),
          //     ),
          //   ),
          // ),
          TextButton(
            onPressed: () {
              showDialog(
                context: context,
                builder: (BuildContext context) {
                  return ColorPickerDialog();
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
            margin: const EdgeInsets.only(
                top: 10, right: 10, left: 10, bottom: 100),
            child: Obx(
              () => Column(
                mainAxisAlignment: MainAxisAlignment.start,
                children: [
                  Expanded(
                    child: Container(
                      width: double.infinity,
                      margin: const EdgeInsets.all(10),
                      decoration: BoxDecoration(
                          border: Border.all(color: Colors.black, width: 1),
                          color: colorPickerController.selectedColor.value,
                          borderRadius: BorderRadius.circular(30)),
                      child: Column(
                        children: [
                          const SizedBox(height: 10),
                          Text(
                            DetailController.to.listData?.title ?? '',
                            // controller: DetailController.to.titleController,
                            textAlign: TextAlign.center,
                            // readOnly: !DetailController.to.editable.value,
                            style: const TextStyle(
                                fontSize: 24,
                                fontWeight: FontWeight.bold,
                                color: Colors.black),
                          ),
                          const SizedBox(height: 20),
                          const Divider(color: Colors.black),
                          const SizedBox(height: 20),
                          Text(
                            DetailController.to.listData?.description ?? '',
                            textAlign: TextAlign.center,
                            style: const TextStyle(
                                fontSize: 20,
                                fontWeight: FontWeight.bold,
                                color: Colors.black),
                          ),
                          const SizedBox(height: 20),
                          Text(
                            'Updated At: ${DetailController.to.listData?.updatedAt}',
                            textAlign: TextAlign.left,
                            style: const TextStyle(
                                fontSize: 16,
                                fontWeight: FontWeight.bold,
                                color: Colors.black54),
                          ),
                          const SizedBox(height: 20),
                          //dd MMM yyyy hh:mm a
                          Text(
                            'Created At: ${DetailController.to.listData?.createdAt}',
                            textAlign: TextAlign.left,
                            style: const TextStyle(
                                fontSize: 16,
                                fontWeight: FontWeight.bold,
                                color: Colors.black38),
                          ),
                        ],
                      ),
                    ),
                  )
                ],
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
                      onPressed: () {},
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
