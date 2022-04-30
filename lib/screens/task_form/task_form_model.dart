import 'package:flutter/cupertino.dart';
import 'package:hive/hive.dart';
import 'package:todo_app/domain/models/models.dart';

class TaskFormModel extends ChangeNotifier {
  late final Box<Task> box;

  var newTaskTitle = '';
  var newTaskDescription = '';
  var selectedColor = 'other';

  TaskFormModel() {
    setup();
  }

  Future<void> setup() async {
    await _openBox();
  }

  Future<void> _openBox() async {
    if (!Hive.isAdapterRegistered(2)) {
      Hive.registerAdapter(TaskAdapter());
    }
    box = await Hive.openBox('tasks_box');
  }

  void createTask(BuildContext context) {
    final task = Task(
      date: DateTime.now(),
      theme: selectedColor,
      title: newTaskTitle,
      description: newTaskDescription,
    );
    box.add(task);
    Navigator.pop(context);
  }

  void onChangedTitleInNewTask(String value) {
    newTaskTitle = value;
  }

  void onChangedDescriptionInNewTask(String value) {
    newTaskDescription = value;
  }

  void onChangedColorInNewTask(String value) {
    selectedColor = value;
    notifyListeners();
  }
}
