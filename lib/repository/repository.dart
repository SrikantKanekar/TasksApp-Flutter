import 'package:tasks/database/cache_data_source/cache_data_source.dart';
import 'package:tasks/database/cache_data_source/cache_data_source_impl.dart';
import 'package:tasks/model/task.dart';
import 'package:tasks/model/task_list.dart';
import 'package:tasks/util/enums/order.dart';

class Repository {
  final CacheDataSource cache = CacheDataSourceImpl();

  Stream<List<TaskList>> getTaskListsAsStream() {
    return cache.getTaskListsAsStream();
  }

  Future<List<TaskList>> getTaskLists() {
    return cache.getTaskLists();
  }

  void addTaskList(TaskList taskList) {
    cache.addTaskList(taskList);
  }

  void renameTaskList(String name, int index) async {
    cache.renameTaskList(name, index);
  }

  void updateTaskListOrder(Order order, int index) async {
    cache.updateTaskListOrder(order, index);
  }

  void deleteTaskList(int index) async {
    cache.deleteTaskList(index);
  }

  // Task
  Future<Task> getTaskById(String id, int index) async {
    return cache.getTaskById(id, index);
  }

  void addTask(Task task, int index) async {
    cache.addTask(task, index);
  }

  void updateTask(Task task, int index) async {
    cache.updateTask(task, index);
  }

  void toggleCompleted(Task task, int index) async {
    cache.toggleCompleted(task, index);
  }

  Future<int> changeTaskList(Task task, String name, int index) async {
    return cache.changeTaskList(task, name, index);
  }

  void deleteTask(Task task, int index) async {
    cache.deleteTask(task, index);
  }

  void deleteCompletedTasks(int index) async {
    cache.deleteCompletedTasks(index);
  }
}
