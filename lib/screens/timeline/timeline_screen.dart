import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:provider/provider.dart';
import 'package:todo_app/domain/models/task.dart';
import 'package:todo_app/navigation.dart';
import 'package:todo_app/screens/timeline/timeline_model.dart';
import 'package:todo_app/widgets/app_text.dart';

class TimelineScreen extends StatelessWidget {
  const TimelineScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final model = context.watch<TimelineModel>();
    final sortTasks = model.sortTasks;
    return Scaffold(
      appBar: AppBar(
        elevation: 0,
        backgroundColor: Colors.transparent,
        iconTheme: const IconThemeData(color: Colors.black),
        centerTitle: true,
        title: AppText(
          size: 20,
          text: 'Timeline',
          fweight: FontWeight.bold,
        ),
        actions: [
          IconButton(
            onPressed: () {
              Navigator.pushNamed(context, MainNavigationRouteNames.taskForm)
                  .then(
                (value) => model.updateState(),
              );
            },
            icon: const Icon(Icons.playlist_add),
          ),
        ],
      ),
      body: sortTasks[0].isNotEmpty
          ? ListView.builder(
              shrinkWrap: true,
              itemCount: sortTasks.length,
              itemBuilder: (context, index) {
                final tasks = sortTasks[index];
                final date = DateFormat.MMMMd().format(tasks[index].date);
                return Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 20),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      AppText(
                        size: 18,
                        text: DateFormat.MMMMd().format(DateTime.now()) == date
                            ? 'Today'
                            : date,
                        fweight: FontWeight.bold,
                      ),
                      Column(
                        children: tasks
                            .map(
                              (task) => GestureDetector(
                                onTap: () => _showModalWindow(context, task),
                                child: Card(
                                  child: ListTile(
                                    shape: RoundedRectangleBorder(
                                      borderRadius: BorderRadius.circular(30),
                                    ),
                                    title: AppText(
                                      size: 18,
                                      text: task.title,
                                      maxLines: 1,
                                      overflow: true,
                                      lineThrough: task.isDone ? true : false,
                                    ),
                                    trailing: IconButton(
                                      icon: task.isDone
                                          ? const Icon(
                                              Icons.check_circle_outline_sharp,
                                              color: Colors.green,
                                            )
                                          : const Icon(
                                              Icons.circle_outlined,
                                            ),
                                      onPressed: () {
                                        task.isDone = !task.isDone;
                                        task.save();
                                        model.updateState();
                                      },
                                    ),
                                  ),
                                ),
                              ),
                            )
                            .toList(),
                      ),
                    ],
                  ),
                );
              },
            )
          : Center(
              child: AppText(size: 18, text: 'Oh.. empty :('),
            ),
    );
  }

  Future<dynamic> _showModalWindow(BuildContext context, Task task) {
    return showDialog(
      context: context,
      builder: (context) {
        return AlertDialog(
          backgroundColor: task.theme == 'work'
              ? Colors.blue
              : task.theme == 'study'
                  ? Colors.green
                  : Colors.orange[700],
          title: Text(task.title),
          titleTextStyle: const TextStyle(
              fontWeight: FontWeight.bold, color: Colors.white, fontSize: 22),
          actions: [
            MaterialButton(
              color: Colors.white,
              onPressed: () {
                Navigator.of(context).pop();
              },
              child: AppText(
                size: 16,
                text: 'Close',
                color: Colors.black,
              ),
            ),
          ],
          content: AppText(
            size: 20,
            text: task.description,
            color: Colors.white,
          ),
        );
      },
    );
  }
}
