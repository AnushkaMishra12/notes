import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'DetailController.dart';

class DetailScreen extends StatelessWidget {
  const DetailScreen({super.key});

  @override
  Widget build(BuildContext context) {
    Get.put(DetailController());
    return SafeArea(
      child: Scaffold(
        appBar: AppBar(
          // automaticallyImplyLeading: false,
          title: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text(
                DetailController.to.listData != null
                    ? 'Notes Details'
                    : "Add Note",
                //'Email: ${DetailController.to.listData.title}',
                style: const TextStyle(
                    fontWeight: FontWeight.bold,
                    fontSize: 24,
                    color: Colors.black),
              ),
            ],
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
                      : DetailController.to.listData != null
                          ? "Update"
                          : "Save",
                  //'Email: ${DetailController.to.listData.title}',
                  style: const TextStyle(
                      fontWeight: FontWeight.bold,
                      fontSize: 24,
                      color: Colors.black),
                ),
              ),
            ),
          ],
        ),
        body: Container(
          margin: const EdgeInsets.all(10),
          padding: const EdgeInsets.all(10),
          child: Obx(
            () => Column(
              children: [
                const SizedBox(height: 30),
                Expanded(
                  child: Container(
                    width: double.infinity,
                    padding: const EdgeInsets.all(10),
                    decoration: BoxDecoration(
                        border: Border.all(color: Colors.black, width: 2),
                        gradient: const LinearGradient(
                          colors: [Colors.white, Colors.white],
                        ),
                        borderRadius: BorderRadius.circular(30)),
                    child: Column(
                      children: [
                        const SizedBox(height: 10),
                        TextField(
                          controller: DetailController.to.titleController,
                          textAlign: TextAlign.center,
                          readOnly: !DetailController.to.editable.value,
                          style: const TextStyle(
                              fontSize: 24,
                              fontWeight: FontWeight.bold,
                              color: Colors.deepOrange),
                        ),
                        const SizedBox(height: 20),
                        Text(
                          '${DetailController.to.listData?.description ?? ''}',
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
                              color: Colors.green),
                        ),
                        const SizedBox(height: 20),
                        //dd MMM yyyy hh:mm a
                        Text(
                          'Created At: ${DetailController.to.listData?.createdAt}',
                          textAlign: TextAlign.left,
                          style: const TextStyle(
                              fontSize: 16,
                              fontWeight: FontWeight.bold,
                              color: Colors.indigo),
                        ),
                      ],
                    ),
                  ),
                )
              ],
            ),
          ),
        ),
      ),
    );
  }
}
