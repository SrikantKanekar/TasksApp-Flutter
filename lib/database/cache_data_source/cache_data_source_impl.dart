import 'package:tasks/database/dao/task_list_dao.dart';
import 'package:tasks/database/database/app_database.dart';
import 'package:tasks/database/mapper/task_list_mapper.dart';
import 'package:tasks/model/task.dart';
import 'package:tasks/model/task_list.dart';
import 'package:tasks/model/order.dart';

import 'cache_data_source.dart';

class CacheDataSourceImpl implements CacheDataSource {
  TaskListDao? dao;

  @override
  Future<void> init() async {
    var database =
        await $FloorAppDatabase.databaseBuilder('app_database.db').build();
    dao = database.taskListDao;
  }

  @override
  Stream<List<TaskList>> getTaskListsAsStream() {
    var data = dao!.getAllTaskListsAsStream();
    return data.map(
      (list) => list
          .map((taskList) => TaskListMapper.mapFromDatabase(taskList))
          .toList(),
    );
  }

  @override
  Future<List<TaskList>> getTaskLists() async {
    var data = await dao!.getAllTaskLists();
    return data.map((list) => TaskListMapper.mapFromDatabase(list)).toList();
  }

  @override
  Future<void> addTaskList(TaskList taskList) async {
    await dao!.insertList(TaskListMapper.mapToDatabase(taskList));
  }

  @override
  Future<int> getTaskListId(String name) async {
    var taskList = await dao!.getListByName(name);
    return taskList!.id!;
  }

  @override
  void renameTaskList(String name, int index) async {
    var taskLists = await getTaskLists();
    var list = taskLists[index];
    list.name = name;
    dao!.updateList(TaskListMapper.mapToDatabase(list));
  }

  @override
  void updateTaskListOrder(Order order, int index) async {
    var taskLists = await getTaskLists();
    var list = taskLists[index];
    list.order = order;
    dao!.updateList(TaskListMapper.mapToDatabase(list));
  }

  @override
  void syncTaskLists(List<TaskList> taskLists) async {
    var currentList = await dao!.getAllTaskLists();
    var networkList = taskLists.map((e) => TaskListMapper.mapToDatabase(e)).toList();
    networkList.forEach((list) {
      var exists = currentList.any((element) => element.id == list.id);
      exists ? dao!.updateList(list) : dao!.insertList(list);
    });
  }

  @override
  void deleteTaskList(int index) async {
    var taskLists = await getTaskLists();
    var list = taskLists[index];
    dao!.deleteList(TaskListMapper.mapToDatabase(list));
  }

  // Task
  @override
  Future<Task> getTaskById(String id, int index) async {
    var taskLists = await getTaskLists();
    var list = taskLists[index];
    return list.tasks.firstWhere((task) => task.id == id);
  }

  @override
  void addTask(Task task, int index) async {
    var taskLists = await getTaskLists();
    var list = taskLists[index];
    list.tasks.add(task);
    dao!.updateList(TaskListMapper.mapToDatabase(list));
  }

  @override
  void updateTask(Task task, int index) async {
    var taskLists = await getTaskLists();
    var list = taskLists[index];
    var taskIndex = list.tasks.indexWhere((item) => item.id == task.id);
    list.tasks[taskIndex] = task;
    dao!.updateList(TaskListMapper.mapToDatabase(list));
  }

  @override
  void toggleCompleted(Task task, int index) async {
    var taskLists = await getTaskLists();
    var list = taskLists[index];
    var taskIndex = list.tasks.indexWhere((item) => item.id == task.id);
    list.tasks[taskIndex].completed = !task.completed;
    dao!.updateList(TaskListMapper.mapToDatabase(list));
  }

  @override
  Future<int> changeTaskList(Task task, String name, int index) async {
    var taskLists = await getTaskLists();
    var list = taskLists[index];
    list.tasks.removeWhere((item) => item.id == task.id);

    var newListIndex = taskLists.indexWhere((list) => list.name == name);
    var newList = taskLists[newListIndex];
    newList.tasks.add(task);

    dao!.updateList(TaskListMapper.mapToDatabase(list));
    dao!.updateList(TaskListMapper.mapToDatabase(newList));
    return newListIndex;
  }

  @override
  void deleteTask(Task task, int index) async {
    var taskLists = await getTaskLists();
    var list = taskLists[index];
    list.tasks.removeWhere((item) => item.id == task.id);
    dao!.updateList(TaskListMapper.mapToDatabase(list));
  }

  @override
  void deleteCompletedTasks(int index) async {
    var taskLists = await getTaskLists();
    var list = taskLists[index];
    list.tasks.removeWhere((task) => task.completed);
    dao!.updateList(TaskListMapper.mapToDatabase(list));
  }

  @override
  Future<void> deleteDatabase() async {
    var taskLists = await dao!.getAllTaskLists();
    dao!.deleteAll(taskLists);
  }
}
