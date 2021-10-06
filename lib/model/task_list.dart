import 'package:tasks/model/task.dart';

class TaskList {
  final String name;
  final List<Task> tasks;

  TaskList({
    required this.name,
    required this.tasks,
  });
}
