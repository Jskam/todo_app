import 'dart:async';
import 'package:flutter/material.dart';

import 'package:hive/hive.dart';
import 'package:todo_app/domain/data_providers/box_manager.dart';
import 'package:todo_app/domain/models/models.dart';
import 'package:todo_app/navigation.dart';

class NotesModel extends ChangeNotifier {
  late final Future<Box<Note>> _box;
  var _notes = <Note>[];
  List<Note> get notes => _notes;

  String filter = 'all';

  NotesModel() {
    _box = BoxManager.instance.openNoteBox();
    updateState();
  }

  Future<void> updateState() async {
    _notes.clear();

    if (filter != 'all') {
      (await _box).toMap().forEach((key, value) {
        if(value.theme == filter){
        _notes.add(value);

        }
      });
    } else {
      _notes = (await _box).values.toList();
    }
    _notes.sort(((a, b) => b.date.compareTo(a.date)));
    notifyListeners();
  }

  void onFilterButtonPress() {
    switch (filter) {
      case 'all':
        filter = 'work';
        break;
      case 'work':
        filter = 'study';
        break;
      case 'study':
        filter = 'other';
        break;
      case 'other':
        filter = 'all';
        break;
    }
    updateState();
  }

  Future<void> deleteNote(int index) async {
    (await _box).delete(index);
    updateState();
  }

  void navToCreateNewNote(context) {
    Navigator.pushNamed(
      context,
      MainNavigationRouteNames.noteForm,
    ).then((value) => updateState());
  }

  @override
  void dispose() async {
    await BoxManager.instance.closeBox(await _box);
    super.dispose();
  }
}
