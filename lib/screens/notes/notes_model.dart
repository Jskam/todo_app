import 'dart:async';
import 'package:flutter/material.dart';

import 'package:hive/hive.dart';
import 'package:todo_app/domain/models/models.dart';
import 'package:todo_app/navigation.dart';

class NotesModel extends ChangeNotifier {
  late final Box<Note> box;
  var _notes = <Note>[];
  List<Note> get notes => _notes;

  NotesModel() {
    setup();
  }

  Future<void> setup() async {
    await _openBox();
    updateState();
  }

  Future<void> _openBox() async {
    if (!Hive.isAdapterRegistered(0)) {
      Hive.registerAdapter(NoteAdapter());
    }
    box = await Hive.openBox('notes_box');
  }

  Future<void> deleteNote(int index) async {
    box.delete(index);
    updateState();
  }

  void navToCreateNewNote(context) {
    Navigator.pushNamed(
      context,
      MainNavigationRouteNames.noteForm,
    ).then((value) => updateState());
  }

  void updateState() {
    _notes = box.values.toList();
    _notes.sort(((a, b) => b.date.compareTo(a.date)));
    notifyListeners();
  }
}
