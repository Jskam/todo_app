import 'package:flutter/material.dart';
import 'package:hive_flutter/hive_flutter.dart';
import 'package:todo_app/domain/models/models.dart';

class TimelineModel extends ChangeNotifier {
  var _tasks = <Task>[];
  var _sortTasks = <List<Task>>[[]];
  List<List<Task>> get sortTasks => _sortTasks;
  late final Box<Task> box;

  TimelineModel() {
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

  void _sortBox() {
    _tasks = box.values.toList();
    _tasks.sort((a, b) => b.date.compareTo(a.date));
    var count = 0;
    if (box.values.isNotEmpty) {
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

  void updateState() {
    _sortTasks = [[]];
    _sortBox();
    notifyListeners();
  }

  @override
  void dispose() {
    super.dispose();
    box.close();
  }
}
