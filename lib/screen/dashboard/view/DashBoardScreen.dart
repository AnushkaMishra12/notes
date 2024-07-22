import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:get/get.dart';
import 'package:notes/screen/dashboard/dialog/CreateNoteDialog.dart';
import '../../../Widget/NoteCard.dart';
import '../../../routes/AppRoutes.dart';
import '../../login/screen/LoginController.dart';
import '../data/ResponseData.dart';
import 'DashBoardController.dart';

class DashBoardScreen extends StatelessWidget {
  const DashBoardScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final DashBoardController taskController = Get.put(DashBoardController());
    final LoginController loginController = Get.find();
    return Scaffold(
      backgroundColor: Theme.of(context).colorScheme.surface,
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
                      const CircleAvatar(
                        radius: 30,
                        backgroundImage: AssetImage('assets/images/bg_1.png'),
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
                        icon: const Icon(Icons.login_outlined),
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
                              color: Theme.of(context)
                                  .colorScheme
                                  .onSecondaryFixed,
                            ),
                            onPressed: () {},
                          ),
                          Text(
                            'Finding Notes',
                            style: TextStyle(
                                fontSize: 15,
                                color: Theme.of(context)
                                    .colorScheme
                                    .onSecondaryFixed),
                          ),
                        ],
                      )),
                  Expanded(
                    child: Obx(() {
                      if (taskController.isLoading.value) {
                        return const Center(child: CircularProgressIndicator());
                      } else {
                        return SingleChildScrollView(
                          child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                const SizedBox(height: 15),
                                const Text(
                                  'All Tasks',
                                  style: TextStyle(
                                      fontWeight: FontWeight.bold,
                                      fontSize: 18),
                                ),
                                GridView.builder(
                                  shrinkWrap: true,
                                  physics: const NeverScrollableScrollPhysics(),
                                  gridDelegate:
                                      const SliverGridDelegateWithFixedCrossAxisCount(
                                          crossAxisCount: 2,
                                          mainAxisSpacing: 10,
                                          crossAxisSpacing: 10),
                                  itemCount: taskController.allTasks.length,
                                  itemBuilder: (context, index) {
                                    final task = taskController.allTasks[index];
                                    return InkWell(
                                        onTap: () {
                                          Get.toNamed(AppRoutes.detail,
                                              arguments: task);
                                        },
                                        child: NoteCard(task: task));
                                  },
                                ),
                                const SizedBox(height: 15),
                                if (taskController
                                    .completedTasks.isNotEmpty) ...[
                                  const Text(
                                    'Completed Tasks',
                                    style: TextStyle(
                                        fontWeight: FontWeight.bold,
                                        fontSize: 18),
                                  ),
                                  GridView.builder(
                                    shrinkWrap: true,
                                    physics:
                                        const NeverScrollableScrollPhysics(),
                                    gridDelegate:
                                        const SliverGridDelegateWithFixedCrossAxisCount(
                                            crossAxisCount: 2,
                                            mainAxisSpacing: 10,
                                            crossAxisSpacing: 10),
                                    itemCount:
                                        taskController.completedTasks.length,
                                    itemBuilder: (context, index) {
                                      final task =
                                          taskController.completedTasks[index];
                                      return NoteCard(task: task);
                                    },
                                  ),
                                ],
                                const SizedBox(height: 15),
                                if (taskController.pendingTasks.isNotEmpty) ...[
                                  const Text(
                                    'Pinned Tasks',
                                    style: TextStyle(
                                        fontWeight: FontWeight.bold,
                                        fontSize: 18),
                                  ),
                                  GridView.builder(
                                    shrinkWrap: true,
                                    physics:
                                        const NeverScrollableScrollPhysics(),
                                    gridDelegate:
                                        const SliverGridDelegateWithFixedCrossAxisCount(
                                            crossAxisCount: 2,
                                            mainAxisSpacing: 10,
                                            crossAxisSpacing: 10),
                                    itemCount:
                                        taskController.pendingTasks.length,
                                    itemBuilder: (context, index) {
                                      final ResponseData task =
                                          taskController.pendingTasks[index];
                                      return NoteCard(task: task);
                                    },
                                  ),
                                ],
                              ]),
                        );
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
