import 'package:tasks/model/task.dart';
import 'package:tasks/model/task_list.dart';

List<TaskList> tasksLists = [
  TaskList(name: 'list 1', tasks: tasks..shuffle()),
  TaskList(name: 'list 2', tasks: tasks..shuffle()),
  TaskList(name: 'list 3', tasks: tasks..shuffle()),
  TaskList(name: 'list 4', tasks: tasks..shuffle())
];

var tasks = [
  Task(id: '1', name: 'task 1', description: 'description 1', completed: true),
  Task(id: '2', name: 'task 2', description: 'description 2', completed: true),
  Task(id: '3', name: 'task 3', description: 'description 3', completed: true),
  Task(id: '4', name: 'task 4', description: 'description 4', completed: false),
  Task(id: '5', name: 'task 5', description: 'description 5', completed: false),
  Task(id: '6', name: 'task 6', description: 'description 6', completed: false),
  Task(id: '7', name: 'task 7', description: 'description 7', completed: false),
  Task(id: '8', name: 'task 8', description: 'description 8', completed: false),
  Task(id: '9', name: 'task 9', description: 'description 9', completed: false),
  Task(id: '10', name: 'task 10', description: 'description 10', completed: false),
];