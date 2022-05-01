import 'package:flutter/cupertino.dart';
import 'package:hive/hive.dart';
import 'package:todo_app/domain/data_providers/box_manager.dart';
import 'package:todo_app/domain/models/models.dart';

class TaskFormModel extends ChangeNotifier {
  late final Future<Box<Task>> _box;

  var newTaskTitle = '';
  var newTaskDescription = '';
  var selectedColor = 'other';

  TaskFormModel() {
    _box = BoxManager.instance.openTaskBox();
  }

  Future<void> createTask(BuildContext context) async{
    final task = Task(
      date: DateTime.now(),
      theme: selectedColor,
      title: newTaskTitle,
      description: newTaskDescription,
    );
    (await _box).add(task);
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

  @override
  void dispose() async {
    await BoxManager.instance.closeBox(await _box);
    super.dispose();
  }
}
