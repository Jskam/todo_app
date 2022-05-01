import 'dart:async';

import 'package:flutter/MATERIAL.dart';
import 'package:hive/hive.dart';
import 'package:todo_app/domain/data_providers/box_manager.dart';
import 'package:todo_app/domain/models/models.dart';
import 'package:todo_app/navigation.dart';

class TasksModel extends ChangeNotifier {
  late final Future<Box<Task>> _box;

  var _tasks = <Task>[];
  List<Task> get tasks => _tasks;

  TasksModel() {
    setup();
  }

  Future<void> setup() async {
    _box = BoxManager.instance.openTaskBox();
    updateState();
  }

  Future<void> deleteTask(int index) async {
    (await _box).delete(index);
    updateState();
  }

  void navToCreateNewTask(context) {
    Navigator.pushNamed(context, MainNavigationRouteNames.taskForm).then(
      (value) => updateState(),
    );
  }

  Future<void> updateState() async {
    _tasks = (await _box).values.toList();
    notifyListeners();
  }

  @override
  void dispose() async {
    await BoxManager.instance.closeBox(await _box);
    super.dispose();
  }
}
