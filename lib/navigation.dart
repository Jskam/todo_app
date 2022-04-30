import 'package:flutter/material.dart';
import 'package:todo_app/screen_factory.dart';

abstract class MainNavigationRouteNames {
  static const notes = '/';
  static const noteForm = '/note_form';
  static const tasks = '/tasks';
  static const taskForm = '/tasks/task_form';
  static const timeline = '/timeline';
  static const pomodoro = '/pomodoro';
}

class MainNavigation {
  static final _screenFactory = ScreenFactory();
  final initialRoute = MainNavigationRouteNames.notes;
  final routes = {
    MainNavigationRouteNames.notes: (context) =>
        _screenFactory.makeNotesScreen(),
    MainNavigationRouteNames.noteForm: (context) =>
        _screenFactory.makeNoteFormScreen(),
    MainNavigationRouteNames.tasks: (context) =>
        _screenFactory.makeTasksScreen(),
    MainNavigationRouteNames.taskForm: (context) =>
        _screenFactory.makeTaskFormScreen(),
    MainNavigationRouteNames.timeline: (context) =>
        _screenFactory.makeTimelineScreen(),
    MainNavigationRouteNames.pomodoro: (context) =>
        _screenFactory.makePomodoroScreen(),
  };

  
}
void resetNav(context) {
    Navigator.pushNamedAndRemoveUntil(
        context, MainNavigationRouteNames.notes, (route) => false);
  }