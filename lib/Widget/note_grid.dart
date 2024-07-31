import 'package:flutter/material.dart';
import '../screen/dashboard/data/response_data.dart';
import 'note_card.dart';

class NotesGrid extends StatelessWidget {
  const NotesGrid({
    super.key,
    required this.itemCount,
    this.isLoading = false,
    /* required this.getNote, */
    required this.notes,
    required this.callback,
    this.physics,
    this.shrinkWrap = false,
  });
  final ScrollPhysics? physics;
  final bool shrinkWrap;
  final List<ResponseData> notes;
  final int itemCount;
  final bool isLoading;
  final Function(ResponseData) callback;
  // final ResponseData Function(int index) getNote;

  @override
  Widget build(BuildContext context) {
    return GridView.builder(
      shrinkWrap: shrinkWrap,
      physics: physics,
      gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
        crossAxisCount: 2,
        mainAxisSpacing: 10,
        crossAxisSpacing: 10,
      ),
      itemCount: itemCount + (isLoading ? 1 : 0),
      itemBuilder: (context, index) {
        if (index == itemCount) {
          return const Center(child: CircularProgressIndicator());
        }
        final task = notes[index];
        return InkWell(
          onTap: () {
            callback(task);
          },
          child: NoteCard(note: task),
        );
      },
    );
  }
}
