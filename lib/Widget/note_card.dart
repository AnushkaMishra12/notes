import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:get/get.dart';
import 'package:notes/utils/ext.dart';
import '../screen/dashboard/data/response_data.dart';
import '../screen/dashboard/view/dashboard_controller.dart';

class NoteCard extends StatelessWidget {
  final ResponseData note;
  const NoteCard({super.key, required this.note});

  @override
  Widget build(BuildContext context) {
    Color taskColor = Colors.white70;
    if (note.color != null) {
      taskColor = note.color.toColor();
    }
    final DashBoardController taskController = Get.find();
    return Container(
      width: double.infinity,
      height: 50,
      padding: const EdgeInsets.all(8),
      margin: const EdgeInsets.only(top: 8),
      decoration: BoxDecoration(
          border: Border.all(color: Colors.black, width: 1),
          color: taskColor,
          borderRadius: BorderRadius.circular(10)),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.spaceAround,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            maxLines: 1,
            overflow: TextOverflow.ellipsis,
            note.title.toString(),
            style: const TextStyle(
                color: Colors.black87,
                fontWeight: FontWeight.bold,
                fontSize: 16),
          ),
          const SizedBox(height: 10),
          Text(
            maxLines: 1,
            overflow: TextOverflow.ellipsis,
            note.description.toString(),
            style: const TextStyle(
                color: Colors.white, fontWeight: FontWeight.bold, fontSize: 15),
          ),
          const SizedBox(height: 10),
          Row(
            children: [
              Expanded(
                child: Text(
                  maxLines: 1,
                  overflow: TextOverflow.ellipsis,
                  note.createdAt.toString(),
                  style: const TextStyle(
                      color: Colors.white,
                      fontWeight: FontWeight.bold,
                      fontSize: 12),
                ),
              ),
            ],
          ),
          const SizedBox(height: 8),
          Row(
            children: [
              IconButton(
                alignment: Alignment.bottomLeft,
                icon: const FaIcon(
                  FontAwesomeIcons.trash,
                  color: Colors.white,
                ),
                onPressed: () {
                  taskController.deleteTask(note.id.toString());
                },
              ),
              // IconButton(
              //   alignment: Alignment.bottomRight,
              //   icon: const FaIcon(
              //     FontAwesomeIcons.edit,
              //     color: Colors.white,
              //   ),
              //   onPressed: () {
              //     showDialog(
              //       context: context,
              //       builder: (BuildContext context) {
              //         return UpdateDialog(note: note);
              //       },
              //     );
              //   },
              // ),
            ],
          ),
        ],
      ),
    );
  }
}
