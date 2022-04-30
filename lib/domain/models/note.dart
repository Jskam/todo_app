import 'package:hive/hive.dart';

part 'note.g.dart';

@HiveType(typeId: 0)
class Note extends HiveObject {
  @HiveField(0)
  String title;

  @HiveField(1)
  DateTime date;

  @HiveField(3)
  String theme;

  Note({
    required this.date,
    required this.theme,
    required this.title,
  });
}
