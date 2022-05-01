import 'package:hive/hive.dart';
import 'package:todo_app/domain/models/models.dart';

class BoxManager {
  static final BoxManager instance = BoxManager._();
  BoxManager._();

  final Map<String, int> _boxCounter = <String, int>{};

  Future<Box<Task>> openTaskBox() async {
    return _openBox('tasks_box', 2, TaskAdapter());
  }

  Future<Box<Note>> openNoteBox() async {
    return _openBox('notes_box', 0, NoteAdapter());
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

  String makeTaskBoxName(int groupKey) => 'tasks_box_$groupKey';

  Future<Box<T>> _openBox<T>(
    String name,
    int typeId,
    TypeAdapter<T> adapter,
  ) async {
    // Уже открыт
    if (Hive.isBoxOpen(name)) {
      final count = _boxCounter[name] ?? 1;
      _boxCounter[name] = count + 1;
      return Hive.openBox<T>(name);
    }
    // Открытие
    _boxCounter[name] = 1;
    if (!Hive.isAdapterRegistered(typeId)) {
      Hive.registerAdapter(adapter);
    }
    return Hive.openBox<T>(name);
  }
}
