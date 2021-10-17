import 'package:tasks/model/task.dart';
import 'package:tasks/util/enums/order.dart';

class TaskList {
  String name;
  final List<Task> tasks;
  Order order;

  TaskList({
    required this.name,
    required this.tasks,
    this.order = Order.normal,
  });
}
