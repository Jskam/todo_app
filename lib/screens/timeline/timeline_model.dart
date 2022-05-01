import 'package:flutter/material.dart';
import 'package:hive_flutter/hive_flutter.dart';
import 'package:todo_app/domain/data_providers/box_manager.dart';
import 'package:todo_app/domain/models/models.dart';

class TimelineModel extends ChangeNotifier {
  late final Future<Box<Task>> _box;
  var _tasks = <Task>[];

  var _sortTasks = <List<Task>>[[]];
  List<List<Task>> get sortTasks => _sortTasks;

  TimelineModel() {
    _box = BoxManager.instance.openTaskBox();
    updateState();
  }

  Future<void> _sortBox() async {
    _tasks = (await _box).values.toList();
    _tasks.sort((a, b) => b.date.compareTo(a.date));
    var count = 0;
    if ((await _box).values.isNotEmpty) {
      var date = _tasks[0].date.day + _tasks[0].date.month;
      for (var task in _tasks) {
        if (date == task.date.day + task.date.month) {
          _sortTasks[count].add(task);
        } else {
          date = task.date.day + task.date.month;
          _sortTasks.add([]);
          count++;
          _sortTasks[count].add(task);
        }
      }
    }
  }

  Future<void> updateState() async {
    _sortTasks = [[]];
    await _sortBox();
    notifyListeners();
  }

  @override
  Future<void> dispose() async {
    await BoxManager.instance.closeBox(await _box);
    super.dispose();
  }
}
