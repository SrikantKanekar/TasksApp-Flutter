import 'package:tasks/model/task.dart';
import 'package:tasks/model/task_list.dart';

List<TaskList> tasksLists = [
  TaskList(name: 'list 1', tasks: tasks..shuffle()),
  TaskList(name: 'list 2', tasks: tasks..shuffle()),
  TaskList(name: 'list 3', tasks: tasks..shuffle()),
  TaskList(name: 'list 4', tasks: tasks..shuffle())
];

var tasks = [
  Task(name: 'task 1', description: 'description 1', completed: true),
  Task(name: 'task 2', description: 'description 2', completed: true),
  Task(name: 'task 3', description: 'description 3', completed: true),
  Task(name: 'task 4', description: 'description 4', completed: false),
  Task(name: 'task 5', description: 'description 5', completed: false),
  Task(name: 'task 6', description: 'description 6', completed: false),
  Task(name: 'task 7', description: 'description 7', completed: false),
  Task(name: 'task 8', description: 'description 8', completed: false),
  Task(name: 'task 9', description: 'description 9', completed: false),
  Task(name: 'task 10', description: 'description 10', completed: false),
];