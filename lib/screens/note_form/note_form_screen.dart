import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:todo_app/screens/note_form/note_form_model.dart';
import 'package:todo_app/widgets/app_text.dart';

class NoteFormScreen extends StatelessWidget {
  const NoteFormScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final model = context.watch<NoteFormModel>();
    const checkIcon = Icon(
      Icons.check,
      color: Colors.white,
    );
    final choseColor = model.selectedColor;
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        elevation: 0,
        backgroundColor: Colors.white,
        centerTitle: true,
        title: AppText(
          size: 20,
          text: 'Create New Note',
          fweight: FontWeight.bold,
        ),
        iconTheme: const IconThemeData(color: Colors.black),
      ),
      body: Padding(
        padding: const EdgeInsets.all(20.0),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            TextField(
              minLines: 3,
              maxLines: 20,
              decoration: const InputDecoration(
                contentPadding: EdgeInsets.all(0),
                hintText: 'Enter here...',
                focusedBorder: OutlineInputBorder(
                  borderSide: BorderSide(color: Colors.white),
                ),
                enabledBorder: UnderlineInputBorder(
                  borderSide: BorderSide(color: Colors.white),
                ),
              ),
              onChanged: (value) => model.onChangedTextInNewNote(value),
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Row(
                  children: [
                    GestureDetector(
                      onTap: () => model.onChangedColorInNewNote('work'),
                      child: CircleAvatar(
                        radius: choseColor == 'work' ? 22 : 20,
                        backgroundColor: Colors.blue,
                        child: choseColor == 'work' ? checkIcon : null,
                      ),
                    ),
                    const SizedBox(width: 10),
                    GestureDetector(
                      onTap: () => model.onChangedColorInNewNote('study'),
                      child: CircleAvatar(
                        radius: choseColor == 'study' ? 22 : 20,
                        backgroundColor: Colors.green,
                        child: choseColor == 'study' ? checkIcon : null,
                      ),
                    ),
                    const SizedBox(width: 10),
                    GestureDetector(
                      onTap: () => model.onChangedColorInNewNote('other'),
                      child: CircleAvatar(
                        radius: choseColor == 'other' ? 22 : 20,
                        backgroundColor: Colors.orange,
                        child: choseColor == 'other' ? checkIcon : null,
                      ),
                    ),
                  ],
                ),
                GestureDetector(
                  onTap: () => model.createNote(context),
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
