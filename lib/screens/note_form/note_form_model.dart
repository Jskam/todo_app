import 'package:flutter/cupertino.dart';
import 'package:hive_flutter/hive_flutter.dart';
import 'package:todo_app/domain/models/models.dart';

class NoteFormModel extends ChangeNotifier {
  late final Box<Note> box;

  var newNoteText = '';
  var selectedColor = 'other';

  NoteFormModel() {
    setup();
  }

  Future<void> setup() async {
    await _openBox();
  }

  Future<void> _openBox() async {
    if (!Hive.isAdapterRegistered(0)) {
      Hive.registerAdapter(NoteAdapter());
    }
    box = await Hive.openBox('notes_box');
  }

  void onChangedTextInNewNote(String value) {
    newNoteText = value;
  }

  void onChangedColorInNewNote(String value) {
    selectedColor = value;
    notifyListeners();
  }

  void createNote(BuildContext context) {
    final note = Note(
      date: DateTime.now(),
      theme: selectedColor,
      title: newNoteText,
    );
    box.add(note);
    notifyListeners();
    Navigator.pop(context);
  }
}
