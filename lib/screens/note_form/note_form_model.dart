import 'package:flutter/cupertino.dart';
import 'package:hive_flutter/hive_flutter.dart';
import 'package:todo_app/domain/data_providers/box_manager.dart';
import 'package:todo_app/domain/models/models.dart';

class NoteFormModel extends ChangeNotifier {
  late final Future<Box<Note>> _box;

  String newNoteText = '';
  var selectedColor = 'other';

  NoteFormModel() {
    _box = BoxManager.instance.openNoteBox();
  }

  Future<void> createNote(BuildContext context) async {
    final note = Note(
      date: DateTime.now(),
      theme: selectedColor,
      title: newNoteText,
    );
    (await _box).add(note);
    notifyListeners();
    Navigator.pop(context);
  }

  void onChangedTextInNewNote(String value) {
    newNoteText = value;
  }

  void onChangedColorInNewNote(String value) {
    selectedColor = value;
    notifyListeners();
  }

  @override
  void dispose() async {
    await BoxManager.instance.closeBox(await _box);
    super.dispose();
  }
}
