import 'dart:async';

import 'package:flutter/MATERIAL.dart';
import 'package:hive/hive.dart';
import 'package:todo_app/domain/models/models.dart';
import 'package:todo_app/navigation.dart';

class TasksModel extends ChangeNotifier {
  late final Box<Task> box;
  var _tasks = <Task>[];
  List<Task> get tasks => _tasks;

  TasksModel() {
    setup();
  }

  Future<void> setup() async {
    await _openBox();
    updateState();
  }

  Future<void> _openBox() async {
    if (!Hive.isAdapterRegistered(2)) {
      Hive.registerAdapter(TaskAdapter());
    }
    box = await Hive.openBox('tasks_box');
  }

  Future<void> deleteTask(int index) async {
    box.delete(index);
    updateState();
  }

  void navToCreateNewTask(context) {
    Navigator.pushNamed(context, MainNavigationRouteNames.taskForm)
        .then((value) => updateState());
  }

  void updateState() {
    _tasks = box.values.toList();
    notifyListeners();
  }
}
