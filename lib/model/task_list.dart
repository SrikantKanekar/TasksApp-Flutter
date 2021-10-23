import 'package:tasks/model/task.dart';
import 'package:tasks/model/order.dart';

class TaskList {
  int? id;
  String name;
  final List<Task> tasks;
  Order order;

  TaskList({
    this.id,
    required this.name,
    required this.tasks,
    this.order = Order.normal,
  });

  static TaskList fromJson(Map<String, dynamic> jsonData) {
    var tasks = List<Task>.from(jsonData['tasks'].map((task) => Task.fromJson(task)));
    return TaskList(
      id: jsonData['id'],
      name: jsonData['name'],
      tasks: tasks,
      order: jsonData['order'] == 'Date' ? Order.date : Order.normal,
    );
  }

  Map<String, dynamic> toJson() => {
        'id': id,
        'name': name,
        'tasks': tasks,
        'order': order == Order.date ? 'Date' : 'Normal'
      };
}
