import 'package:hive/hive.dart';

part 'task.g.dart';

@HiveType(typeId: 2)
class Task extends HiveObject {
  @HiveField(0)
  String title;
  @HiveField(1)
  String description;
  @HiveField(2)
  DateTime date;
  @HiveField(5)
  String theme;
  @HiveField(4)
  bool isDone;

  Task({
    required this.date,
    required this.theme,
    required this.title,
    required this.description,
    this.isDone = false,
  });
}
