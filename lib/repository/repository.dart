import 'package:tasks/model/task.dart';
import 'package:tasks/model/task_list.dart';

class Repository {
  late final List<TaskList> data;

  Repository() {
    data = [
      TaskList(name: 'list 1', tasks: generateTasks('list1')),
      TaskList(name: 'list 2', tasks: generateTasks('list2')),
      TaskList(name: 'list 3', tasks: generateTasks('list3')),
      TaskList(name: 'list 4', tasks: generateTasks('list4')),
    ];
  }

  List<Task> generateTasks(String prefix) {
    final List<Task> tasks = [];
    for (var a = 0; a < 10; a++) {
      tasks.add(
        Task(
            id: '$prefix$a',
            name: 'Task $a',
            description: 'description $a',
            completed: a < 4),
      );
    }
    return tasks;
  }
}
