import 'package:tasks/database/dao/task_list_dao.dart';
import 'package:tasks/database/database/app_database.dart';
import 'package:tasks/database/mapper/task_list_mapper.dart';
import 'package:tasks/model/task.dart';
import 'package:tasks/model/task_list.dart';
import 'package:tasks/util/enums/order.dart';

import 'cache_data_source.dart';

class CacheDataSourceImpl implements CacheDataSource {
  late final TaskListDao dao;

  CacheDataSourceImpl() {
    $FloorAppDatabase
        .databaseBuilder('app_database.db')
        .build()
        .then((database) {
      dao = database.taskListDao;
    });
  }

  @override
  Stream<List<TaskList>> getTaskListsAsStream() {
    var data = dao.getAllTaskListsAsStream();
    return data.map(
      (list) => list
          .map((taskList) => TaskListMapper().mapFromDatabase(taskList))
          .toList(),
    );
  }

  @override
  Future<List<TaskList>> getTaskLists() async {
    var data = await dao.getAllTaskLists();
    return data.map((list) => TaskListMapper().mapFromDatabase(list)).toList();
  }

  @override
  void addTaskList(TaskList taskList) {
    dao.insertList(TaskListMapper().mapToDatabase(taskList));
  }

  @override
  void renameTaskList(String name, int index) async {
    var taskLists = await getTaskLists();
    var list = taskLists[index];
    list.name = name;
    dao.updateList(TaskListMapper().mapToDatabase(list));
  }

  @override
  void updateTaskListOrder(Order order, int index) async {
    var taskLists = await getTaskLists();
    var list = taskLists[index];
    list.order = order;
    dao.updateList(TaskListMapper().mapToDatabase(list));
  }

  @override
  void deleteTaskList(int index) async {
    var taskLists = await getTaskLists();
    var list = taskLists[index];
    dao.deleteList(TaskListMapper().mapToDatabase(list));
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
    dao.updateList(TaskListMapper().mapToDatabase(list));
  }

  @override
  void updateTask(Task task, int index) async {
    var taskLists = await getTaskLists();
    var list = taskLists[index];
    var taskIndex = list.tasks.indexWhere((item) => item.id == task.id);
    list.tasks[taskIndex] = task;
    dao.updateList(TaskListMapper().mapToDatabase(list));
  }

  @override
  void toggleCompleted(Task task, int index) async {
    var taskLists = await getTaskLists();
    var list = taskLists[index];
    var taskIndex = list.tasks.indexWhere((item) => item.id == task.id);
    list.tasks[taskIndex].completed = !task.completed;
    dao.updateList(TaskListMapper().mapToDatabase(list));
  }

  @override
  Future<int> changeTaskList(Task task, String name, int index) async {
    var taskLists = await getTaskLists();
    var list = taskLists[index];
    list.tasks.removeWhere((item) => item.id == task.id);

    var newListIndex = taskLists.indexWhere((list) => list.name == name);
    var newList = taskLists[newListIndex];
    newList.tasks.add(task);

    dao.updateList(TaskListMapper().mapToDatabase(list));
    dao.updateList(TaskListMapper().mapToDatabase(newList));
    return newListIndex;
  }

  @override
  void deleteTask(Task task, int index) async {
    var taskLists = await getTaskLists();
    var list = taskLists[index];
    list.tasks.removeWhere((item) => item.id == task.id);
    dao.updateList(TaskListMapper().mapToDatabase(list));
  }

  @override
  void deleteCompletedTasks(int index) async {
    var taskLists = await getTaskLists();
    var list = taskLists[index];
    list.tasks.removeWhere((task) => task.completed);
    dao.updateList(TaskListMapper().mapToDatabase(list));
  }
}
