import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:notes/screen/view_all/viewAll_controller.dart';
import '../../Widget/note_grid.dart';
import '../../routes/app_routes.dart';

class ViewAllScreen extends StatelessWidget {
  const ViewAllScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final controller = Get.put(ViewAllController());
    final String title = Get.arguments['title'];

    return Scaffold(
      appBar: AppBar(
        title: Text(title),
      ),
      body: Padding(
        padding: const EdgeInsets.all(20.0),
        child: NotificationListener<ScrollNotification>(
          onNotification: (ScrollNotification scrollInfo) {
            if (!controller.isLoadingMore.value &&
                scrollInfo.metrics.pixels ==
                    scrollInfo.metrics.maxScrollExtent &&
                controller.isPageAvailable) {
              controller.loadMoreNotes();
            }
            return true;
          },
          child: Obx(
            () => NotesGrid(
              itemCount: controller.notes.length,
              isLoading: controller.isLoadingMore.value,
              notes: controller.notes,
              callback: (task) {
                Get.toNamed(AppRoutes.detail, arguments: task);
              },
              /*   getNote: (index){
              return controller.notes[index];
              }*/
            ),
          ),
        ),
      ),
    );
  }
}
