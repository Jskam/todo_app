import 'package:hive/hive.dart';
import 'package:todo_app/domain/models/models.dart';

class BoxManager {
  static final BoxManager instance = BoxManager._();
  BoxManager._();

  final Map<String, int> _boxCounter = <String, int>{};

  Box<Task> openTaskBox() {
    return _openBox('tasks_box', 2, TaskAdapter());
  }

  Box<Note> openNoteBox() {
    return _openBox('notes_box', 0, NoteAdapter());
  }

  Box<T> _openBox<T>(
    String name,
    int typeId,
    TypeAdapter<T> adapter,
  ) {
    if (Hive.isBoxOpen(name)) {
      final count = _boxCounter[name] ?? 1;
      _boxCounter[name] = count + 1;
      return Hive.openBox(name) as Box<T>;
      
    }

    _boxCounter[name] = 1;

    if (!Hive.isAdapterRegistered(typeId)) {
      Hive.registerAdapter(adapter);
    }

    return Hive.openBox(name) as Box<T>;
  }

  Future<void> closeBox<T>(Box<T> box) async {
    if (!box.isOpen) {
      _boxCounter.remove(box.name);
      return;
    }

    final count = _boxCounter[box.name] ?? 1;
    _boxCounter[box.name] = count - 1;
    if (count > 0) return;

    _boxCounter.remove(box.name);
    await box.compact();
    await box.close();
  }
}
