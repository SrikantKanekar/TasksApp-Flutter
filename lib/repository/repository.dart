import 'package:tasks/database/cache_data_source/cache_data_source.dart';
import 'package:tasks/database/cache_data_source/cache_data_source_impl.dart';
import 'package:tasks/model/task.dart';
import 'package:tasks/model/task_list.dart';
import 'package:tasks/network/network_data_source.dart';
import 'package:tasks/network/network_data_source_impl.dart';
import 'package:tasks/model/order.dart';

class Repository {
  final CacheDataSource cache = CacheDataSourceImpl();
  final NetworkDataSource network = NetworkDataSourceImpl();

  Future<void> init() async {
    await cache.init();
  }

  Future<void> syncTaskLists() async {
    var networkList = await network.getTaskLists();
    cache.syncTaskLists(networkList);
    // await cache.getTaskLists();
  }

  Stream<List<TaskList>> getTaskListsAsStream() {
    return cache.getTaskListsAsStream();
  }

  void addTaskList(TaskList taskList) async {
    await cache.addTaskList(taskList);
    var id = await cache.getTaskListId(taskList.name);
    taskList.id = id;
    network.addTaskList(taskList);
  }

  void renameTaskList(String name, int index) async {
    cache.renameTaskList(name, index);
    network.renameTaskList(name, index);
  }

  void updateTaskListOrder(Order order, int index) async {
    cache.updateTaskListOrder(order, index);
    network.updateTaskListOrder(order, index);
  }

  void deleteTaskList(int index) async {
    cache.deleteTaskList(index);
    network.deleteTaskList(index);
  }

  // Task
  Future<Task> getTaskById(String id, int index) async {
    return cache.getTaskById(id, index);
  }

  void addTask(Task task, int index) async {
    cache.addTask(task, index);
    network.addTask(task, index);
  }

  void updateTask(Task task, int index) async {
    cache.updateTask(task, index);
    network.updateTask(task, index);
  }

  void toggleCompleted(Task task, int index) async {
    cache.toggleCompleted(task, index);
    network.toggleCompleted(task, index);
  }

  Future<int> changeTaskList(Task task, String name, int index) async {
    network.changeTaskList(task, name, index);
    return cache.changeTaskList(task, name, index);
  }

  void deleteTask(Task task, int index) async {
    cache.deleteTask(task, index);
    network.deleteTask(task, index);
  }

  void deleteCompletedTasks(int index) async {
    cache.deleteCompletedTasks(index);
    network.deleteCompletedTasks(index);
  }

  void deleteDatabase() {
    cache.deleteDatabase();
  }
}
