import 'package:tasks/model/task.dart';
import 'package:tasks/model/task_list.dart';
import 'package:tasks/model/order.dart';

abstract class NetworkDataSource {

  Future<List<TaskList>> getTaskLists();

  void addTaskList(TaskList taskList);

  void renameTaskList(String name, int index);

  void updateTaskListOrder(Order order, int index);

  void deleteTaskList(int index);

  // Task
  void addTask(Task task, int index);

  void updateTask(Task task, int index);

  void toggleCompleted(Task task, int index);

  void changeTaskList(Task task, String name, int index);

  void deleteTask(Task task, int index);

  void deleteCompletedTasks(int index);
}