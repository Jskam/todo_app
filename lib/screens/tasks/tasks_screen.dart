import 'dart:math';

import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import 'package:todo_app/screens/tasks/tasks_model.dart';
import 'package:todo_app/widgets/app_text.dart';

class TasksScreen extends StatelessWidget {
  const TasksScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final model = context.watch<TasksModel>();
    final tasks = model.tasks;

    return Scaffold(
      appBar: AppBar(
        iconTheme: const IconThemeData(color: Colors.black),
        backgroundColor: Colors.transparent,
        elevation: 0,
        centerTitle: true,
        title: AppText(
          size: 20,
          text: 'All Tasks You Created',
          color: Colors.black.withOpacity(.6),
        ),
      ),
      body: tasks.isNotEmpty
          ? ListView.builder(
              physics: const BouncingScrollPhysics(),
              shrinkWrap: true,
              itemCount: tasks.length,
              itemBuilder: (context, index) {
                final task = tasks[index];

                final color = task.theme == 'work'
                    ? Colors.blue
                    : task.theme == 'study'
                        ? Colors.green
                        : Colors.orange[700];
                return Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 20),
                  child: Card(
                    elevation: 3,
                    margin: EdgeInsets.only(
                      bottom: tasks.length - 1 != index ? 5 : 100,
                      left: 0,
                      right: 0,
                      top: 5,
                    ),
                    child: Row(
                      crossAxisAlignment: CrossAxisAlignment.center,
                      children: [
                        Container(
                          margin: const EdgeInsets.only(top: 3, bottom: 3),
                          width: 30,
                          height: 45,
                          decoration: BoxDecoration(
                            color: color,
                            borderRadius: const BorderRadius.only(
                              topRight: Radius.circular(15),
                              bottomRight: Radius.circular(15),
                            ),
                          ),
                        ),
                        const SizedBox(width: 15),
                        Expanded(
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              AppText(
                                size: 16,
                                text: task.title,
                                fweight: FontWeight.bold,
                                overflow: true,
                              ),
                              AppText(
                                  size: 16,
                                  text: task.description,
                                  color: Colors.black.withOpacity(.8),
                                  fweight: FontWeight.w300,
                                  overflow: true),
                            ],
                          ),
                        ),
                        IconButton(
                          onPressed: () => model.deleteTask(task.key),
                          icon: const Icon(
                            Icons.delete,
                            color: Colors.red,
                          ),
                        ),
                      ],
                    ),
                  ),
                );
              },
            )
          : Center(
              child: AppText(size: 18, text: 'Oh.. empty :('),
            ),
      floatingActionButtonLocation: FloatingActionButtonLocation.centerFloat,
      floatingActionButton: FloatingActionButton(
        onPressed: () => model.navToCreateNewTask(context),
        child: const Icon(
          Icons.add,
          color: Colors.white,
        ),
        elevation: 3,
        backgroundColor: Colors.blueGrey,
      ),
    );
  }
}
