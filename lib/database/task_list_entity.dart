import 'package:floor/floor.dart';

@entity
class TaskListEntity {
  @PrimaryKey(autoGenerate: true)
  final int? id;
  final String name;
  final String tasks;
  final int order;

  TaskListEntity({
    this.id,
    required this.name,
    required this.tasks,
    required this.order,
  });
}