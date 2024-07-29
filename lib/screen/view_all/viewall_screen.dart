import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:notes/screen/view_all/viewall_controller.dart';
import '../../../Widget/note_card.dart';
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
                    scrollInfo.metrics.maxScrollExtent) {
              controller.loadMoreNotes();
            }
            return true;
          },
          child: Obx(
            () => GridView.builder(
              gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                crossAxisCount: 2,
                mainAxisSpacing: 10,
                crossAxisSpacing: 10,
              ),
              itemCount: controller.notes.length +
                  (controller.isLoadingMore.value ? 1 : 0),
              itemBuilder: (context, index) {
                if (index == controller.notes.length) {
                  return const Center(child: CircularProgressIndicator());
                }
                final task = controller.notes[index];
                return InkWell(
                  onTap: () {
                    Get.toNamed(AppRoutes.detail, arguments: task);
                  },
                  child: NoteCard(note: task),
                );
              },
            ),
          ),
        ),
      ),
    );
  }
}
