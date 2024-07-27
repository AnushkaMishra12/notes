import 'package:flutter/material.dart';
import 'package:get/get.dart';
import '../../../Widget/note_card.dart';
import '../../routes/app_routes.dart';
import '../dashboard/data/response_data.dart';

class ViewAllScreen extends StatelessWidget {
  const ViewAllScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final arguments = Get.arguments as Map<String, dynamic>;
    final String title = arguments['title'];
    final List<ResponseData> notes = arguments['notes'];

    return Scaffold(
      appBar: AppBar(
        title: Text(title),
      ),
      body: Padding(
        padding: const EdgeInsets.all(20.0),
        child: GridView.builder(
          gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
            crossAxisCount: 2,
            mainAxisSpacing: 10,
            crossAxisSpacing: 10,
          ),
          itemCount: notes.length,
          itemBuilder: (context, index) {
            final task = notes[index];
            return InkWell(
                onTap: () {
                  Get.toNamed(AppRoutes.detail, arguments: task);
                },
                child: NoteCard(note: task));
          },
        ),
      ),
    );
  }
}
