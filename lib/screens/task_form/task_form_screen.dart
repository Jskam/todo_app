import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:todo_app/screens/task_form/task_form_model.dart';
import 'package:todo_app/widgets/app_text.dart';

class TaskFormScreen extends StatelessWidget {
  const TaskFormScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final model = context.watch<TaskFormModel>();
    const checkIcon = Icon(
      Icons.check,
      color: Colors.white,
    );
    final color = model.selectedColor;
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        elevation: 0,
        backgroundColor: Colors.white,
        centerTitle: true,
        title: AppText(
          size: 20,
          text: 'Create New Task',
          weight: FontWeight.bold,
        ),
        iconTheme: const IconThemeData(color: Colors.black),
      ),
      body: Padding(
        padding: const EdgeInsets.all(20.0),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                TextField(
                  maxLength: 32,
                  decoration: const InputDecoration(
                    contentPadding: EdgeInsets.all(0),
                    hintText: 'Enter Title Here...',
                    focusedBorder: OutlineInputBorder(
                      borderSide: BorderSide(color: Colors.white),
                    ),
                    enabledBorder: UnderlineInputBorder(
                      borderSide: BorderSide(color: Colors.white),
                    ),
                  ),
                  onChanged: (value) => model.onChangedTitleInNewTask(value),
                ),
                TextField(
                  maxLength: 32,
                  decoration: const InputDecoration(
                    contentPadding: EdgeInsets.all(0),
                    hintText: 'Enter Description Here...',
                    focusedBorder: OutlineInputBorder(
                      borderSide: BorderSide(color: Colors.white),
                    ),
                    enabledBorder: UnderlineInputBorder(
                      borderSide: BorderSide(color: Colors.white),
                    ),
                  ),
                  onChanged: (value) =>
                      model.onChangedDescriptionInNewTask(value),
                ),
              ],
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Row(
                  children: [
                    GestureDetector(
                      onTap: () => model.onChangedColorInNewTask('work'),
                      child: CircleAvatar(
                        radius: color == 'work' ? 22 : 20,
                        backgroundColor: Colors.blue,
                        child: color == 'work' ? checkIcon : null,
                      ),
                    ),
                    const SizedBox(width: 10),
                    GestureDetector(
                      onTap: () => model.onChangedColorInNewTask('study'),
                      child: CircleAvatar(
                        radius: color == 'study' ? 22 : 20,
                        backgroundColor: Colors.green,
                        child: color == 'study' ? checkIcon : null,
                      ),
                    ),
                    const SizedBox(width: 10),
                    GestureDetector(
                      onTap: () => model.onChangedColorInNewTask('other'),
                      child: CircleAvatar(
                        radius: color == 'other' ? 22 : 20,
                        backgroundColor: Colors.orange,
                        child: color == 'other' ? checkIcon : null,
                      ),
                    ),
                  ],
                ),
                GestureDetector(
                  onTap: () => model.createTask(context),
                  child: CircleAvatar(
                    backgroundColor: model.selectedColor == 'work'
                        ? Colors.blue
                        : model.selectedColor == 'study'
                            ? Colors.green
                            : Colors.orange,
                    radius: 25,
                    child: const Icon(
                      Icons.save,
                      color: Colors.white,
                    ),
                  ),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
