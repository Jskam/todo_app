import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:todo_app/screens/note_form/note_form_model.dart';
import 'package:todo_app/screens/note_form/note_form_screen.dart';
import 'package:todo_app/screens/notes/notes_model.dart';
import 'package:todo_app/screens/notes/notes_screen.dart';
import 'package:todo_app/screens/pomodoro/pomodoro_model.dart';
import 'package:todo_app/screens/pomodoro/pomodoro_screen.dart';
import 'package:todo_app/screens/task_form/task_form_model.dart';
import 'package:todo_app/screens/task_form/task_form_screen.dart';
import 'package:todo_app/screens/tasks/tasks_model.dart';
import 'package:todo_app/screens/tasks/tasks_screen.dart';
import 'package:todo_app/screens/timeline/timeline_model.dart';
import 'package:todo_app/screens/timeline/timeline_screen.dart';

class ScreenFactory {
  Widget makeNotesScreen() {
    return ChangeNotifierProvider(
      create: (_) => NotesModel(),
      child: const NotesScreen(),
    );
  }

  Widget makeNoteFormScreen() {
    return ChangeNotifierProvider(
      create: (_) => NoteFormModel(),
      child: const NoteFormScreen(),
    );
  }

  Widget makeTasksScreen() {
    return ChangeNotifierProvider(
      create: (_) => TasksModel(),
      child: const TasksScreen(),
    );
  }

  Widget makeTaskFormScreen() {
    return ChangeNotifierProvider(
      create: (_) => TaskFormModel(),
      child: const TaskFormScreen(),
    );
  }

  Widget makePomodoroScreen() {
    return ChangeNotifierProvider(
      child: const PomodoroScreen(),
      create: (_) => PomodoroModel(),
      lazy: false,
    );
  }

  Widget makeTimelineScreen() {
    return ChangeNotifierProvider(
      create: (_) => TimelineModel(),
      child: const TimelineScreen(),
    );
  }
}
