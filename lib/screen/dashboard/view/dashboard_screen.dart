import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:get/get.dart';
import 'package:notes/screen/dashboard/dialog/create_note_dialog.dart';
import '../../../Widget/note_grid.dart';
import '../../../api/ui_state.dart';
import '../../../routes/app_routes.dart';
import '../../login/screen/login_controller.dart';
import '../data/response_data.dart';
import 'dashboard_controller.dart';

class DashBoardScreen extends StatelessWidget {
  const DashBoardScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final DashBoardController noteController = Get.put(DashBoardController());
    final LoginController loginController = Get.find();
    final TextEditingController searchController = TextEditingController();

    searchController.addListener(() {
      noteController.updateSearchQuery(searchController.text);
    });

    Future<void> refreshNotes() async {
      noteController.fetchTasks();
    }

    return Scaffold(
      backgroundColor: Colors.white,
      body: Stack(
        children: [
          SafeArea(
            child: Container(
              padding: const EdgeInsets.all(20),
              child: Column(
                children: [
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Obx(
                        () => CircleAvatar(
                          radius: 30,
                          backgroundImage: noteController
                                  .userImage.value.isEmpty
                              ? const AssetImage('assets/images/bg_1.png')
                              : NetworkImage(noteController.userImage.value),
                        ),
                      ),
                      const Text(
                        'My Notes',
                        textAlign: TextAlign.center,
                        style: TextStyle(
                            fontWeight: FontWeight.bold,
                            fontSize: 24,
                            color: Colors.black),
                      ),
                      IconButton(
                        alignment: Alignment.topRight,
                        icon: const Icon(
                          Icons.logout,
                          size: 30,
                          color: Colors.red,
                        ),
                        onPressed: () {
                          loginController.logout();
                        },
                      ),
                    ],
                  ),
                  Container(
                    margin: const EdgeInsets.only(top: 10),
                    padding: const EdgeInsets.all(5),
                    decoration: BoxDecoration(
                        color: Theme.of(context).colorScheme.secondaryFixed,
                        borderRadius: BorderRadius.circular(10)),
                    child: Row(
                      children: [
                        IconButton(
                          icon: FaIcon(
                            FontAwesomeIcons.search,
                            color:
                                Theme.of(context).colorScheme.onSecondaryFixed,
                          ),
                          onPressed: () {},
                        ),
                        Expanded(
                          child: TextField(
                            controller: searchController,
                            decoration: const InputDecoration(
                              hintText: 'Finding Notes',
                              border: InputBorder.none,
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),
                  Expanded(
                    child: Obx(() {
                      final state = noteController.allNotes.value;
                      if (state is Loading) {
                        return const Center(child: CircularProgressIndicator());
                      } else if (state is Success<List<ResponseData>>) {
                        final displayNotes = searchController.text.isEmpty
                            ? state.data
                            : noteController.filteredNotes;
                        return RefreshIndicator(
                          onRefresh: refreshNotes,
                          child: SingleChildScrollView(
                            child: Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  const SizedBox(height: 15),
                                  Row(
                                    mainAxisAlignment:
                                        MainAxisAlignment.spaceBetween,
                                    children: [
                                      const Text(
                                        'All Notes',
                                        style: TextStyle(
                                            fontWeight: FontWeight.bold,
                                            fontSize: 18),
                                      ),
                                      TextButton(
                                        onPressed: () {
                                          Get.toNamed(
                                            AppRoutes.view,
                                            arguments: {
                                              'title': 'All Notes',
                                              'notes': state.data,
                                            },
                                          );
                                        },
                                        child: const Text('View All'),
                                      ),
                                    ],
                                  ),
                                  NotesGrid(
                                    itemCount: displayNotes.length,
                                    notes: displayNotes,
                                    callback: (task) {
                                      Get.toNamed(AppRoutes.detail,
                                          arguments: task);
                                    },
                                  ),
                                  const SizedBox(height: 15),
                                  if (noteController
                                      .completedNotes.isNotEmpty) ...[
                                    Row(
                                      mainAxisAlignment:
                                          MainAxisAlignment.spaceBetween,
                                      children: [
                                        const Text(
                                          'Completed Notes',
                                          style: TextStyle(
                                              fontWeight: FontWeight.bold,
                                              fontSize: 18),
                                        ),
                                        TextButton(
                                          onPressed: () {
                                            Get.toNamed(
                                              AppRoutes.view,
                                              arguments: {
                                                'title': 'Completed Notes',
                                                'notes': noteController
                                                    .completedNotes,
                                              },
                                            );
                                          },
                                          child: const Text('View All'),
                                        ),
                                      ],
                                    ),
                                    NotesGrid(
                                      itemCount:
                                          noteController.completedNotes.length,
                                      notes: noteController.completedNotes,
                                      callback: (task) {
                                        Get.toNamed(AppRoutes.detail,
                                            arguments: task);
                                      },
                                    ),
                                  ],
                                  const SizedBox(height: 15),
                                  if (noteController
                                      .pendingNotes.isNotEmpty) ...[
                                    Row(
                                      mainAxisAlignment:
                                          MainAxisAlignment.spaceBetween,
                                      children: [
                                        const Text(
                                          'Pinned Notes',
                                          style: TextStyle(
                                              fontWeight: FontWeight.bold,
                                              fontSize: 18),
                                        ),
                                        TextButton(
                                          onPressed: () {
                                            Get.toNamed(
                                              AppRoutes.view,
                                              arguments: {
                                                'title': 'Pinned Notes',
                                                'notes':
                                                    noteController.pendingNotes,
                                              },
                                            );
                                          },
                                          child: const Text('View All'),
                                        ),
                                      ],
                                    ),
                                    NotesGrid(
                                      itemCount:
                                          noteController.pendingNotes.length,
                                      notes: noteController.pendingNotes,
                                      callback: (task) {
                                        Get.toNamed(AppRoutes.detail,
                                            arguments: task);
                                      },
                                    ),
                                  ],
                                ]),
                          ),
                        );
                      } else if (state is Error<List<ResponseData>>) {
                        return Center(child: Text(state.msg));
                      } else {
                        return const SizedBox.shrink();
                      }
                    }),
                  )
                ],
              ),
            ),
          ),
          Positioned(
            bottom: 30,
            left: 30,
            right: 30,
            child: Container(
              decoration:
                  BoxDecoration(borderRadius: BorderRadius.circular(40)),
              width: double.infinity,
              child: FloatingActionButton.extended(
                onPressed: () {
                  Get.dialog(CreateNotesDialog());
                },
                label: const Text(
                  'Create Note',
                  style: TextStyle(color: Colors.white),
                ),
                icon: const Icon(
                  Icons.add,
                  color: Colors.white,
                ),
                backgroundColor: Theme.of(context).colorScheme.shadow,
              ),
            ),
          ),
        ],
      ),
    );
  }
}
